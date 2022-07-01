import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../frontend/widgets/media_card.dart';
import 'media_detail.dart';

class Media extends StatelessWidget {
  const Media({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.teal,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {},
        ),
        title: Text("Media and Arts"),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        width: Get.width,
        height: Get.height,
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            MediaCard(
              img: "assets/images/sec2.jpg",
              title: "Combating Hatespeech",
              subTitle: "Online competition by submitting media articles",
              files: "300 files submitted",
              views: "1000 views",
              onclick: () {
                Get.to(() => MediaDetail());
              },
            ),
            SizedBox(height: 12),
            MediaCard(
              img: "assets/images/sec1.jpg",
              title: "Peaceful Interraction",
              subTitle: "Online competition by submitting media articles",
              files: "300 files submitted",
              views: "1000 views",
              onclick: () {
                Get.to(() => MediaDetail());
              },
            ),
          ],
        ),
      ),
    );
  }
}
