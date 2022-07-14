import 'dart:io';

import 'package:data4peace/ui/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'backend/main_binding.dart';
import 'frontend/auth/login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

 var keyParseServerUrl = "https://parseapi.back4app.com";

  // var keyParseApplicationId = "x2Jh12jkjTLHuQxnObjI1nHgv5n92NR9oEwMBILL";
  // var keyParseClientKey = "rVk5hF23igROajAiGqyJ9i07SDqh7JYukjjOEGdt";

  //Test Credentials
  var keyParseApplicationId = "8G0QcO27nAbdnCMIU3VGMdDVt86off4DmHkFFAGg";
  var keyParseClientKey = "4Y1iXxtkfiWxEAHK9SG6lUZjnqp88gRt2rThFVm5";

  var store = await CoreStoreSembastImp.getInstance(password: "data4peace");

  await Parse().initialize(keyParseApplicationId, keyParseServerUrl,
      clientKey: keyParseClientKey, autoSendSessionId: true, coreStore: store);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: MainBinding(),
      title: 'MobiPeace',
      theme: ThemeData(
        // textTheme: GoogleFonts.oxygenTextTheme(
        //   Theme.of(context).textTheme,
        // ),
        primarySwatch: Colors.teal,
      ),
      //home: const SplashScreen(),
      home: const Home(),
      builder: (BuildContext context, Widget? child) {
        return FlutterSmartDialog(child: child);
      },
    );
  }
}
