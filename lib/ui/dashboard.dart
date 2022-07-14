import 'package:data4peace/backend/controllers/auth_controller.dart';
import 'package:data4peace/frontend/widgets/side_navigation.dart';
import 'package:data4peace/ui/media.dart';
import 'package:data4peace/ui/safety_tips.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../frontend/widgets/data_card.dart';
import 'reports.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      drawer: AppDrawerWidget().getDrawer("dashboard"),
      backgroundColor: const Color.fromRGBO(43, 87, 64, 1),
      body: Stack(
        children: [
          SizedBox(
            height: Get.height,
            width: Get.width,
            child: Column(
              children: [
                const SizedBox(
                  height: 70,
                ),
                Container(
                  width: Get.width * .55,
                  height: Get.width * .55,
                  //margin: EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/data4pbanner2.png"),
                          fit: BoxFit.contain)),
                )
              ],
            ),
          ),
          SizedBox(
            height: Get.height,
            width: Get.width,
            child: Column(
              children: [
                const SizedBox(
                  height: 90,
                ),
                //Top Nav
                // Row(
                //   children: [
                //     const SizedBox(width: 20),
                //     IconButton(
                //         onPressed: () {},
                //         icon: const Icon(Icons.menu, color: Colors.white)),
                //     Expanded(child: Container()),
                //     IconButton(
                //         onPressed: () {},
                //         icon: const Icon(Icons.notifications, color: Colors.white)),
                //     const SizedBox(width: 20),
                //   ],
                // ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  width: Get.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                       const Text(
                        "Hello",
                        style: TextStyle(color: Colors.white70),
                      ),
                       const SizedBox(height: 10),
                       Obx(()=>Text(
                          "${AuthController.to.parseUser.value!=null?AuthController.to.parseUser.value?.get("name"):""}",
                          style:  const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 22),
                                             ),
                       ),
                    ],
                  ),
                ),

                SizedBox(height: Get.height * .18),
                Expanded(
                  child: Container(
                    width: Get.width,
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius:  BorderRadius.only(
                            topLeft:  Radius.circular(35),
                            topRight:  Radius.circular(35))),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          SizedBox(
                            width: Get.width,
                            child: const Text(
                              "Select actions below",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16),
                            ),
                          ),
                          const SizedBox(height: 20),
                          DataCard(
                            img: "assets/images/sec1.jpg",
                            title: "Safety Tips",
                            subTitle:
                                "Safety Tips on elections and browsing safely",
                            onclick: () {
                              Get.to(() => const SafetyTips());
                            },
                          ),
                          const SizedBox(height: 20),
                          // DataCard(
                          //   img: "assets/images/sec2.jpg",
                          //   title: "Report",
                          //   subTitle:
                          //       "Report harassment, misinformation and disinformation",
                          //   onclick: () {
                          //     Get.to(() => const Report());
                          //   },
                          // ),
                          // const SizedBox(height: 20),
                          DataCard(

                            //Todo upload image 
                            img: "assets/images/sec2.jpg",
                            title: "Peace Initiatives",
                            subTitle:
                                "Upload and view content to promote peace",
                            onclick: () {
                              Get.to(() => const Media());
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
