import 'package:data4peace/frontend/widgets/report_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SafetyTips extends StatelessWidget {
  const SafetyTips({Key? key}) : super(key: key);
  // DateTime datenow = newDateTime

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.black87,),
          onPressed: () {},
        ),
        title: Text("Safety Tips",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87)),
      ),
      body: Container(
        width: Get.width,
        height: Get.height,
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            ReportDashcard(
              userImg: "assets/images/avator.jpg",
              userTitle: "Admin",
              timestamp: "time",
              bannerImg: "assets/images/sec1.jpg",
              caption:
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
              favourites: "112",
              comments: "12",
              readMoreClick: () {},
            ),
            ReportDashcard(
              userImg: "assets/images/avator.jpg",
              userTitle: "Admin",
              timestamp: "time",
              bannerImg: "assets/images/sec2.jpg",
              caption:
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
              favourites: "112",
              comments: "12",
              readMoreClick: () {},
            ),
          ],
        ),
      ),
    );
  }
}
