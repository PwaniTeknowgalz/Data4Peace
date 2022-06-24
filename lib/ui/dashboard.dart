import 'package:data4peace/ui/safetyTips.dart';
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
      backgroundColor: Color.fromRGBO(43, 87, 64, 1),
      body: Stack(
        children: [
          Container(
            height: Get.height,
            width: Get.width,
            child: Column(
              children: [
                SizedBox(
                  height: 70,
                ),
                Container(
                  width: Get.width * .55,
                  height: Get.width * .55,
                  //margin: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/data4pbanner2.png"),
                          fit: BoxFit.contain)),
                )
              ],
            ),
          ),
          Container(
            height: Get.height,
            width: Get.width,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                //Top Nav
                Row(
                  children: [
                    SizedBox(width: 20),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.menu, color: Colors.white)),
                    Expanded(child: Container()),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.notifications, color: Colors.white)),
                    SizedBox(width: 20),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  width: Get.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hello",
                        style: TextStyle(color: Colors.white70),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Jumalaw98.",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 22),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: Get.height * .18),
                Expanded(
                  child: Container(
                    width: Get.width,
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(35),
                            topRight: Radius.circular(35))),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: 20),
                          Container(
                            width: Get.width,
                            child: Text(
                              "Select actions below",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16),
                            ),
                          ),
                          SizedBox(height: 20),
                          DataCard(
                            img: "assets/images/sec1.jpg",
                            title: "Safety Tips",
                            subTitle:
                                "Safety Tips on elections and browsing safely",
                            onclick: () {
                              Get.to(() => SafetyTips());
                            },
                          ),
                          SizedBox(height: 20),
                          DataCard(
                            img: "assets/images/sec2.jpg",
                            title: "Report",
                            subTitle:
                                "Report harassment, misinformation and disinformation",
                            onclick: () {
                              Get.to(() => Report());
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
