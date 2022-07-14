import 'package:data4peace/backend/controllers/auth_controller.dart';
import 'package:data4peace/frontend/auth/login.dart';
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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        // backgroundColor: Color.fromARGB(255, 255, 255, 255),
        backgroundColor: Colors.transparent,
        //  title: Text('Data4Peace',textAlign: TextAlign.center,
        //     style: TextStyle(
        //                   color: Colors.black,
        //                   fontSize: 16,
        //                   fontWeight: FontWeight.w500)),
      ),
      body: Container(
        height: Get.height,
        width: Get.width,

        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [
            0.1,
            0.4,
            0.6,
            0.9,
          ],
          colors: [
            Color.fromRGBO(
              43,
              87,
              64,
              1,
            ),
            Color.fromRGBO(1, 1, 1, 1),
            Color.fromRGBO(1, 1, 1, 1),
            Color.fromRGBO(
              43,
              87,
              64,
              1,
            ),
          ],
        )),
        //margin: EdgeInsets.only(top: 65),

        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(height: 15),
            Container(
              height: Get.size.height * .20,
              width: Get.size.height * .20,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  image: DecorationImage(
                      image: AssetImage("assets/images/logo-data4peace.png"),
                      fit: BoxFit.cover)),
            ),

            //SizedBox(height: 15),
            const Text("Data4Peace",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),
            SizedBox(
              height: Get.size.height * .20,
              width: Get.size.width * .70,
              child: const Text(
                  "Data4Peace is your one stop verifier of information on possibility of violence within and outside of unstable periods such as national elections. Make peace a priority now!",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500)),
            ),

            const SizedBox(height: 15),

            TextButton(
              onPressed: () {
                if (AuthController.to.parseUser.value != null) {
                  Get.to(() => const DashBoard());
                } else {
                  Get.to(() => const Login());
                }
              },
              style: TextButton.styleFrom(
                minimumSize: Size(Get.width * 0.7, 20),
                primary: Colors.white,
                backgroundColor: const Color.fromARGB(255, 90, 134, 81),
                textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: .5,
                    fontSize: 15),
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                ),
              ),
              child:
                  const Text("Proceed", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
