import 'package:data4peace/frontend/widgets/report_card.dart';
import 'package:data4peace/frontend/widgets/side_navigation.dart';
import 'package:data4peace/ui/view_safety_tip.dart';
import 'package:data4peace/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

import '../backend/controllers/main_controller.dart';

class SafetyTips extends StatefulWidget {
  const SafetyTips({Key? key}) : super(key: key);

  @override
  State<SafetyTips> createState() => _SafetyTipsState();
}

class _SafetyTipsState extends State<SafetyTips> {

  @override
  initState(){

    super.initState();
    Future.microtask(() async {
      await MainController.to.fetchSafetyTips();
    });
  }
  
  // DateTime datenow = newDateTime
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      drawer: AppDrawerWidget().getDrawer("safety"),
      
      appBar: AppBar(
        
        iconTheme: Theme.of(context).iconTheme.copyWith(color: Colors.white),
        backgroundColor: AppConst.tealMainColor,
        // leading: IconButton(
        //   icon: Icon(Icons.menu, color: Colors.black87,),
        //   onPressed: () {},
        // ),
        title: const Text("Safety Tips",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
                actions: [
                  IconButton(
            onPressed: () async {
              await MainController.to.fetchSafetyTips();
            },
            icon: const Icon(
              Icons.refresh,
              color: Colors.white,
            )),
                ],
      ),
      body: Container(
        width: Get.width,
        height: Get.height,
        padding: const EdgeInsets.all(20),
        child: Obx(()=> ListView(
            children: MainController.to.safetyTips.entries.map((e) {
              return ReportDashcard(
                userImg: "${((e.value as ParseObject).get("image") as ParseFile).url}",
                userTitle: "${e.value.get("title")}",
                timestamp: "${e.value.get("createdAt")}",
                bannerImg: "${((e.value as ParseObject).get("image") as ParseFile).url}",
                caption:
                    "${e.value.get("content")}",
                favourites: "${e.value.get("likes")==null?0:e.value.get("likes").length}",
                comments: "${e.value.get("comments")==null?0:e.value.get("comments").length}",
                readMoreClick: () {

                  MainController.to.selectedSafetyTip.value = e.value;
                  Get.to(()=>const ViewSafetyTip());
                },
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
