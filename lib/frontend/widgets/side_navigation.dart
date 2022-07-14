import 'package:data4peace/ui/dashboard.dart';
import 'package:data4peace/ui/safety_tips.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../backend/controllers/auth_controller.dart';
import '../../ui/media.dart';
import '../../utils/app_constants.dart';


class AppDrawerWidget {
  getDrawer(page) {
    var sideNav = Drawer(
      width: Get.width*.7,
      child: Column(
        children: [
          Container(
            color: AppConst.tealMainColor,
            width: Get.width,
            padding: const EdgeInsets.only(top: 60,bottom: 20,left: 20,right:20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircleAvatar(
                  child: Icon(Icons.person,color: Colors.white,),
                ),
                const SizedBox(height: 20,),
                Text(
                  "${AuthController.to.parseUser.value?.get("name")}",

                  style:
                  const TextStyle(fontWeight: FontWeight.bold, color: Colors.white,fontSize: 18),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "${AuthController.to.parseUser.value?.emailAddress}",
                  style: const TextStyle(color: Colors.white70),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          ListTile(
            onTap: (){
              Get.back();
              Get.offUntil(GetPageRoute(page: () => const DashBoard()), (route) => false);
            },
            leading: Icon(Icons.home_filled,color: page=="dashboard"?AppConst.accentColor:Colors.black45),
            title: Text("Dashboard",style: TextStyle(color: page=="dashboard"?AppConst.accentColor:Colors.black45,fontSize: 18),),
          ),
          const SizedBox(
            height: 10,
          ),
          ListTile(
            onTap: (){
              Get.back();
              Get.to(()=>const SafetyTips());
            },
            leading: Icon(Icons.mic_rounded,color: page=="safety"?AppConst.accentColor:Colors.black45),
            title: Text("Safety Tips",style: TextStyle(color: page=="safety"?AppConst.accentColor:Colors.black45,fontSize: 18),),
          ),
          ListTile(
            onTap: (){
              Get.back();
              Get.to(()=>const Media());
            },
            leading: Icon(Icons.mic_rounded,color: page=="media"?AppConst.accentColor:Colors.black45),
            title: Text("Media & Arts",style: TextStyle(color: page=="media"?AppConst.accentColor:Colors.black45,fontSize: 18),),
          ),
          const SizedBox(
            height: 10,
          ),
          ListTile(
            onTap: () async {
             await  AuthController.to.signOut();
            },
            leading: const Icon(Icons.logout,color: Colors.black45),
            title: const Text("Logout",style: TextStyle(color: Colors.black45,fontSize: 18),),
          )
        ],
      ),
    );
    return sideNav;
  }
}


