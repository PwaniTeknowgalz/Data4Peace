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
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
     title: Text('Data4Peace',textAlign: TextAlign.center,
        style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500)),
      ),
      body: Container(
        
        decoration: BoxDecoration(
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
                Color.fromRGBO(43, 87, 64, 1,),
              Color.fromRGBO(1,1,1,1),
                Color.fromRGBO(1,1,1,1),
                Color.fromRGBO(43, 87, 64, 1,),
              ],


              
            )
          ),
        margin: EdgeInsets.only(top: 65),
        
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(height: 15),
            Container(
              height: Get.size.height * .20,
              width: Get.size.height * .20,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  image: DecorationImage(
                      image: AssetImage("assets/images/logo-data4peace.png"),
                      fit: BoxFit.cover)),
            ),
            
            //SizedBox(height: 15),
            Text("Data4Peace",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold)),
SizedBox(height: 15),
            Container(
              height: Get.size.height * .20,
              width: Get.size.width * .70,
              child: Text(
                  "Data4Peace is your one stop verifier of information on possibility of violence within and outside of unstable periods such as national elections. Make peace a priority now!",textAlign: TextAlign.justify,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500)),

            
            ),

            SizedBox(height: 15),



            TextButton(
              onPressed: () {
                Get.to(() => DashBoard());
              },
              child: Text("Proceed", style: TextStyle(color: Colors.white)),
              style: TextButton.styleFrom(
                minimumSize: Size(Get.width * 0.7, 20),
                primary: Colors.white,
                backgroundColor: Color.fromARGB(255, 90, 134, 81),
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