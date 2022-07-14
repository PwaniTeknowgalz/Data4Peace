import 'dart:io';

import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:path/path.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/app_utils.dart';
import 'auth_controller.dart';

class MainController extends GetxController {
  var competitions = {}.obs;

  var selectedCompetitions = Rxn<ParseObject>();

  var safetyTips = {}.obs;

  var selectedSafetyTip = Rxn<ParseObject>();

  var uploadFile = "".obs;

  var competitionEntries = {}.obs;

  static MainController get to => Get.find();

  //fetching competition data
  fetchCompetitionData() async {
    AppUtils.showLoading();
    competitions.clear();
    competitions.refresh();

    try {
      ParseObject reqObj = ParseObject("Competitions");
      QueryBuilder<ParseObject> query;
      query = QueryBuilder<ParseObject>(reqObj);
      //query.includeObject(["Votes","Entries"]);
      //   ..whereEqualTo('user', AuthController.to.parseUser.value?.objectId);
      var data = await query.find();
      if (data.isNotEmpty) {
        //print("Not Empty");
        var resCurrent = competitions.value;
        var results = data;

        for (var res in results) {
          var mres = res as ParseObject;

          resCurrent[mres.objectId] = mres;
        }
        competitions.value = resCurrent;
        competitions.refresh();
      }
    } on ParseError catch (e) {
      // e.g, e.code == 'canceled'
      print(e.message);
      AppUtils.showError("Competition List Fetching Failed!");
    }
    SmartDialog.dismiss();
  }

//fetching submission data
  fetchSubmissionData() async {
    AppUtils.showLoading();
    competitionEntries.clear();
    competitionEntries.refresh();
    try {
      QueryBuilder<ParseObject> queryCompe =
          QueryBuilder<ParseObject>(ParseObject('Competitions'))
            ..whereEqualTo('objectId', selectedCompetitions.value?.objectId);

      QueryBuilder<ParseObject> queryEntries =
          QueryBuilder<ParseObject>(ParseObject('Entries'))
            ..whereMatchesQuery('competition', queryCompe);

      queryEntries.includeObject(["user", "votes"]);

      var data = await queryEntries.query();
      if (data.success) {
        print(data.results);
        //print("Not Empty");
        var resCurrent = competitionEntries.value;
        var results = data.results ?? [];

        for (var res in results) {
          var mres = res as ParseObject;

          resCurrent[mres.objectId] = mres;
        }
        competitionEntries.value = resCurrent;
        competitionEntries.refresh();
      }
    } on ParseError catch (e) {
      // e.g, e.code == 'canceled'
      print(e.message);
      AppUtils.showError("Competition Entries List Fetching Failed!");
    }
    SmartDialog.dismiss();
  }

  //save Entry data
  saveEntryData({required String file, title}) async {
    var ext = extension(file);
    // var mfile = file.renameSync(
    //     (await getApplicationDocumentsDirectory()).path + "res_image$ext");

    var parseFile = ParseFile(File(file), debug: true, name: "entry$ext");
    var entry = ParseObject("Entries")
      ..set("title", title)
      ..set("user", AuthController.to.parseUser.value)
      ..set("submission", parseFile)
      ..set("competition", selectedCompetitions.value);

    AppUtils.showLoading();
    try {
      ParseResponse? response = await entry.save();

      if (response.success) {
        //  QueryBuilder<ParseObject> queryCompe =
        // QueryBuilder<ParseObject>(ParseObject('Competitions'));
        // queryCompe.whereEqualTo("objectId", selectedCompetitions.value?.objectId);

        var competition1 = ParseObject('Competitions')
          ..objectId = selectedCompetitions.value?.objectId ?? ""
          ..set(
              "entries", (selectedCompetitions.value?.get("entries") ?? 0) + 1);
        await competition1.save();

        var competition = await ParseObject("Competitions")
            .getObject(selectedCompetitions.value?.objectId ?? "");

        if (competition.success) {
          if (competition.result != null) {
            selectedCompetitions.value = competition.result;
            selectedCompetitions.refresh();
            competitions[selectedCompetitions.value?.objectId] =
                selectedCompetitions.value;
          }
        }

        AppUtils.showSuccess("Resource Saved Successfully!");
        SmartDialog.dismiss();
        return true;
      } else {
        print(response.error?.message);
        AppUtils.showError("Resource Saving Failed!");
      }
      SmartDialog.dismiss();
    } on ParseError catch (e) {
      // e.g, e.code == 'canceled'
      AppUtils.showError("Resource Saving Failed!");
    }

    return false;
  }

  //save Vote
  saveVoteData(competition, user, entry) async {
    AppUtils.showLoading();
    QueryBuilder<ParseObject> queryCompe =
        QueryBuilder<ParseObject>(ParseObject('Competitions'))
          ..whereEqualTo('objectId', competition);
    QueryBuilder<ParseObject> queryUser =
        QueryBuilder<ParseObject>(ParseUser.forQuery())
          ..whereEqualTo('objectId', user);

    QueryBuilder<ParseObject> queryEntry =
        QueryBuilder<ParseObject>(ParseObject('Entries'))
          ..whereEqualTo('objectId', entry);

    QueryBuilder<ParseObject> queryVotes =
        QueryBuilder<ParseObject>(ParseObject('Votes'))
          ..whereMatchesQuery('competition', queryCompe)
          //..whereMatchesQuery('entry', queryEntry)
          ..whereMatchesQuery('user', queryUser);

    try {
      var votes = await queryVotes.query();

      var vote = null;

      if (votes.success && votes.results != null) {
        for (var a in votes.results! as List<ParseObject>) {
          vote = a;
          //print(vote);
        }
      }
      var addingVote = null;
      if (vote != null ) {
        addingVote = ParseObject("Votes")
          ..objectId = vote.objectId
          ..set("competition",
              ParseObject("Competitions")..objectId = competition)
          ..set("entry", ParseObject("Entries")..objectId = entry)
          ..set("user", AuthController.to.parseUser.value?.toPointer());
      } else {
        addingVote = ParseObject("Votes")
          ..set("competition",
              ParseObject("Competitions")..objectId = competition)
          ..set("entry", ParseObject("Entries")..objectId = entry)
          ..set("user", ParseUser.forQuery()..objectId = user);
      }

      var res = await addingVote.save();
      if (res.success) {

          // print(vote.get("entry")["objectId"]);
          // print(res.result.get("entry")["objectId"]);

        if(vote!=null && vote.get("entry")["objectId"]!=res.result.get("entry")["objectId"]){
          
          
          var oldEntry  = ParseObject("Entries")..objectId = vote.get("entry")["objectId"];
          var newEntry  = ParseObject("Entries")..objectId = res.result.get("entry")["objectId"];
          newEntry.setIncrement('votes', 1);
          oldEntry.setDecrement('votes', 1);
          var response1 = await newEntry.save();
          var response2 = await oldEntry.save();

        }

        if(vote==null){
          var cmp =  ParseObject("Competitions")..objectId = selectedCompetitions.value?.objectId..setIncrement("votes",1);
          await cmp.save();

           var newEntry  = ParseObject("Entries")..objectId = res.result.get("entry")["objectId"];
          newEntry.setIncrement('votes', 1);
          var response1 = await newEntry.save();

        }

        var competition = await ParseObject("Competitions")
            .getObject(selectedCompetitions.value?.objectId ?? "");

        if (competition.success) {
          if (competition.result != null) {
            selectedCompetitions.value = competition.result;
            selectedCompetitions.refresh();
            competitions[selectedCompetitions.value?.objectId] =
                selectedCompetitions.value;
          }
        }

        AppUtils.showSuccess("Vote Saved Successfully!");
        SmartDialog.dismiss();
        return true;
      } else {
        print(res.error?.message);
        AppUtils.showError("Vote Saving Failed!");
      }
      SmartDialog.dismiss();
    } on ParseError catch (e) {
      // e.g, e.code == 'canceled'
      AppUtils.showError("Vote Saving Failed!");
       SmartDialog.dismiss();
    }

    return false;
  }

  void openUrl(url) async {
    if (!await launchUrl(Uri.parse(url),mode: LaunchMode.externalApplication)) throw 'Could not launch $url';
  }

  //fetching safetyTips data
  fetchSafetyTips() async {
    AppUtils.showLoading();
    safetyTips.clear();
    safetyTips.refresh();

    try {
      ParseObject reqObj = ParseObject("SafetyTips");
      QueryBuilder<ParseObject> query;
      query = QueryBuilder<ParseObject>(reqObj);
      query.includeObject(["author"]);
      //   ..whereEqualTo('user', AuthController.to.parseUser.value?.objectId);
      var data = await query.find();
      if (data.isNotEmpty) {
        //print("Not Empty");
        var resCurrent = safetyTips.value;
        var results = data;

        for (var res in results) {
          var mres = res as ParseObject;

          resCurrent[mres.objectId] = mres;
        }
        safetyTips.value = resCurrent;
        safetyTips.refresh();
      }
    } on ParseError catch (e) {
      // e.g, e.code == 'canceled'
      print(e.message);
      AppUtils.showError("SafetyTips List Fetching Failed!");
    }
    SmartDialog.dismiss();
  }
addComment({content}) async {
    initializeDateFormatting();

    var comment = {
      "content": content,
      "createdAt":DateFormat.yMd().add_Hm().format(DateTime.now()),
      "author": {
        "name": AuthController.to.parseUser.value?.get("name"),
        "email": AuthController.to.parseUser.value?.emailAddress,
        "objectId": AuthController.to.parseUser.value?.objectId
      }
    };

    //selectedResource.value?.setAdd("comments", comment);

    AppUtils.showLoading();
    try {
      var resource = ParseObject("SafetyTips")
        ..objectId = selectedSafetyTip.value?.objectId ?? ""
        ..setAdd("comments", comment);
      ParseResponse? response = await resource.save();

      if (response.success) {
        var apiResponse = await ParseObject('SafetyTips')
            .getObject(selectedSafetyTip.value?.objectId ?? "");
        // var queryBuilder  = QueryBuilder<ParseObject>(ParseObject("Resources"))
        //   ..whereEqualTo('objectId', selectedResource.value?.objectId ?? "");
        //
        // var apiResponse = await queryBuilder.query();
        if (apiResponse.success && apiResponse.result != null) {
          selectedSafetyTip.value = apiResponse.results?.first;
          selectedSafetyTip.refresh();
          var allRes = safetyTips.value;
          allRes[selectedSafetyTip.value?.objectId] = selectedSafetyTip.value;
          safetyTips.value = allRes;
          safetyTips.refresh();
        }
        AppUtils.showSuccess("Comment Saved Successfully!");
      } else {
        print(response.error?.message);
        AppUtils.showError("Comment Saving Failed!");
      }
      SmartDialog.dismiss();
      return true;
    } on ParseError catch (e) {
      // e.g, e.code == 'canceled'
      AppUtils.showError("Comment Saving Failed!");
    }
    SmartDialog.dismiss();
    return false;

}

getIsLiked(){
var likes = selectedSafetyTip.value?.get("likes");
  if(likes==null){
    return false;
  }

  if((likes as List).isEmpty){
    return false;
  }

  if(likes.contains(AuthController.to.parseUser.value?.objectId)){
    return true;
  }

  return false;
}

getLikeCount(){
var likes = selectedSafetyTip.value?.get("likes");
  if(likes==null){
    return 0;
  }

  if((likes as List).isEmpty){
    return 0;
  }


  return likes.length;
}

fixDateDisplay(date){
  initializeDateFormatting();
  return DateFormat.yMd().add_Hm().format(date);
}


addLike() async {
    //initializeDateFormatting();

   
    AppUtils.showLoading();
    try {
      var likes = selectedSafetyTip.value?.get("likes");
      var resource = null;

      if(likes!=null && (likes as List).contains(AuthController.to.parseUser.value?.objectId))
      {
        resource = ParseObject("SafetyTips")
        ..objectId = selectedSafetyTip.value?.objectId ?? ""
        ..setRemove("likes", AuthController.to.parseUser.value?.objectId );
      }else{
        resource = ParseObject("SafetyTips")
        ..objectId = selectedSafetyTip.value?.objectId ?? ""
        ..setAddUnique("likes", AuthController.to.parseUser.value?.objectId );
      }
      ParseResponse response = await resource.save();

      if (response.success) {
        var apiResponse = await ParseObject('SafetyTips')
            .getObject(selectedSafetyTip.value?.objectId ?? "");
        // var queryBuilder  = QueryBuilder<ParseObject>(ParseObject("Resources"))
        //   ..whereEqualTo('objectId', selectedResource.value?.objectId ?? "");
        //
        // var apiResponse = await queryBuilder.query();
        if (apiResponse.success && apiResponse.result != null) {
          selectedSafetyTip.value = apiResponse.results?.first;
          selectedSafetyTip.refresh();
          var allRes = safetyTips.value;
          allRes[selectedSafetyTip.value?.objectId] = selectedSafetyTip.value;
          safetyTips.value = allRes;
          safetyTips.refresh();
        }

        if(likes!=null && (likes as List).contains(AuthController.to.parseUser.value?.objectId))
      {
        AppUtils.showSuccess("Post Unliked!");
        }else{
          AppUtils.showSuccess("Post Liked!");
        }
      } else {
        print(response.error?.message);
        AppUtils.showError("Like Saving Failed!");
      }
      SmartDialog.dismiss();
      return true;
    } on ParseError catch (e) {
      // e.g, e.code == 'canceled'
      AppUtils.showError("Like Saving Failed!");
    }
    SmartDialog.dismiss();
    return false;

}
}
