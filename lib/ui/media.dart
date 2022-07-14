import 'package:data4peace/frontend/widgets/side_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

import '../backend/controllers/main_controller.dart';
import '../frontend/widgets/media_card.dart';
import '../utils/app_constants.dart';
import 'media_detail.dart';

class Media extends StatefulWidget {
  const Media({Key? key}) : super(key: key);

  @override
  State<Media> createState() => _MediaState();
}

class _MediaState extends State<Media> {


  @override
  initState(){

    super.initState();
    Future.microtask(() async {
      await MainController.to.fetchCompetitionData();
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawerWidget().getDrawer("media"),
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: AppConst.tealMainColor,
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        //   onPressed: () {},
        // ),
        title: Text("Media and Arts"),
        actions: [
          IconButton(
            onPressed: () async {
              await MainController.to.fetchCompetitionData();
            },
            icon: const Icon(
              Icons.refresh,
              color: Colors.white,
            )),
        ],
      ),
      body: Obx(() {
          return MainController.to.competitions.value.isEmpty?Container(
              height: Get.height,
              width: Get.width,
              alignment: AlignmentDirectional.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children:  [
                  const Icon(Icons.campaign_outlined,color:AppConst.mainColor,size: 200,),
                  const SizedBox(height: 50,),
                  Text("No Competitions added yet",style: TextStyle(color: Colors.grey.shade400,fontSize: 24,fontWeight: FontWeight.bold),),
                  const SizedBox(height: 20,),
                   Text("Check back later",style: TextStyle(color: Colors.grey.shade400,fontSize: 18),)
                ],
              ),
            ):Container(
        width: Get.width,
        height: Get.height,
        padding: EdgeInsets.all(20),
        child:  ListView(
            children:MainController.to.competitions.value.entries.map((e) {
              return  Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  MediaCard(
                img: (e.value.get("image") as ParseFile).url??"",
                title: "${e.value.get("title")}",
                subTitle: "${e.value.get("subtitle")}",
                files: "${e.value.get("entries")} Entries",
                views: "${e.value.get("votes")??0} votes",
                onclick: () {
                  MainController.to.selectedCompetitions.value = e.value; 
                  Get.to(() => MediaDetail());
                },
              ),
              SizedBox(height: 12),
                ],
              );
            }).toList(),
          )
        
      );}),
    );
  }
}
