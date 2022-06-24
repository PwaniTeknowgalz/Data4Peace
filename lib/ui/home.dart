import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dashboard.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var logo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(43, 87, 64, 1),
      body: Container(
        margin: EdgeInsets.only(top: 65),
        width: Get.size.width,
        height: Get.size.height,
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(height: 15),
            Container(
              height: Get.size.height * .18,
              width: Get.size.height * .18,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  image: DecorationImage(
                      image: AssetImage("assets/images/logo-data4peace.png"),
                      fit: BoxFit.cover)),
            ),
            //SizedBox(height: 10),
            Text("Data4Peace",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold)),

            Text(
                "Data4Peace is about verifying information on possibility of violence in hot spot areas during the election period. It will help report violence and also give safety tips during election period.",
                style: TextStyle(
                    color: Colors.white54,
                    fontSize: 16,
                    fontWeight: FontWeight.w500)),

            TextButton(
              onPressed: () {
                Get.to(() => DashBoard());
              },
              child: Text("Proceed", style: TextStyle(color: Colors.white)),
              style: TextButton.styleFrom(
                minimumSize: Size(Get.width * 0.7, 20),
                primary: Colors.white,
                backgroundColor: Color.fromRGBO(251, 120, 99, 1),
                textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: .5,
                    fontSize: 15),
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
