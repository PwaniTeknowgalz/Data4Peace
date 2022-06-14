

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

import '../../backend/controllers/auth_controller.dart';
import '../../utils/app_constants.dart';
import '../../utils/app_utils.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import '../auth/signup.dart';

class Home extends StatefulWidget {
  const Home ({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.only(top: 65),
        width: Get.size.width,
        height: Get.size.height,
        padding: EdgeInsets.all(20),
        child: Column(
         children: [
          SizedBox(height: 25),
          Container(
                height: Get.size.height *.3,
                width:  Get.size.height *.3,
                //decoration: BoxDecoration(image: DecorationImage(image: AssetImage("images/login2.png"))),
              ),

          SizedBox(height: 10),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black87,
                    ),
                    children: <TextSpan>[
                      
                      TextSpan(
                          text: 'Data4Peace is about verifying information on possibility of violence in hot spot areas during the election period. It will help report violence and also give safety tips during election period.',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppConst.mainColor,
                          )),
                    ],
                  ),
                ),
                SizedBox(height: 25),
          
         ],

        ),
      ),
    );
  }

}
