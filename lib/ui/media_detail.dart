import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MediaDetail extends StatelessWidget {
  const MediaDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Container(
        constraints: new BoxConstraints.expand(),
        color: Colors.grey[100],
        child: new Stack(
          children: <Widget>[
            _getBackground(),
            _getGradient(),
            _getContent(),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
          color: Colors.teal,
          child: Container(
            padding: EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.upload, color: Colors.white),
                    label: Text(
                      "Upload File".toUpperCase(),
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ))
              ],
            ),
          )),
    );
  }

  Container _getBackground() {
    return Container(
      child: Image.asset(
        "assets/images/sec1.jpg",
        fit: BoxFit.cover,
        height: 300.0,
      ),
      constraints: BoxConstraints.expand(height: 300.0),
    );
  }

  Container _getGradient() {
    return new Container(
      margin: new EdgeInsets.only(top: 190.0),
      height: 110.0,
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
          colors: <Color>[
            Color.fromARGB(0, 215, 215, 215),
            Color.fromARGB(255, 245, 245, 245)
          ],
          stops: [0.0, 0.9],
          begin: const FractionalOffset(0.0, 0.0),
          end: const FractionalOffset(0.0, 1.0),
        ),
      ),
    );
  }

  Widget _getContent() {
    return new ListView(
      padding: new EdgeInsets.all(20),
      children: <Widget>[
        SizedBox(
          height: 72,
        ),
        Stack(
          children: [
            Container(
              width: Get.width,
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.all(Radius.circular(20)),
                boxShadow: <BoxShadow>[
                  new BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10.0,
                    offset: new Offset(0.0, 10.0),
                  ),
                ],
              ),
              //Content
              child: Container(
                child: Column(
                  children: [
                    Container(height: 4.0),
                    Text("Combating Hatespeech",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600)),
                    SizedBox(
                      height: 12,
                    ),
                    Text("Online competition by submiting media articles",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white70,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400)),

                    //Separator
                    Container(
                        margin: new EdgeInsets.symmetric(vertical: 8.0),
                        height: 2.0,
                        width: 18.0,
                        color: Colors.teal[100]),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        //icon and text
                        Row(
                          children: [
                            Icon(
                              Icons.file_upload,
                              color: Colors.white70,
                              size: 16,
                            ),
                            SizedBox(width: 5),
                            Text("300 files submitted",
                                style: TextStyle(
                                    color: Colors.white70, fontSize: 12))
                          ],
                        ),
                        SizedBox(width: 20),
                        //icon and text
                        Row(
                          children: [
                            Icon(
                              Icons.download,
                              color: Colors.white70,
                              size: 16,
                            ),
                            SizedBox(width: 5),
                            Text("1000 views",
                                style: TextStyle(
                                    color: Colors.white70, fontSize: 12))
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        //content
        //title
        Text("DETAILS",
            style: TextStyle(
                color: Colors.black87,
                fontSize: 16.0,
                fontWeight: FontWeight.w400)),
        //Separator
        Container(
            margin: new EdgeInsets.symmetric(vertical: 8.0),
            height: 2.0,
            width: 18.0,
            color: Colors.teal[100]),
        SizedBox(
          height: 12,
        ),
        Text(
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur tempor urna massa, eget tristique risus varius vel. Donec tincidunt iaculis est quis ullamcorper. In eget ex tempus, scelerisque neque eget, mollis arcu. Nullam ut nibh eget velit interdum consectetur et quis elit. Aliquam erat volutpat. Sed id justo libero. Aliquam at dolor neque. Praesent vel vulputate sem, vel fermentum purus. Ut sit amet est semper, porta mi in, dapibus mauris. Nullam fringilla magna et orci consequat rutrum. Sed eleifend eros aliquet mi fringilla scelerisque. Vestibulum eget elit quis elit aliquet maximus. Phasellus feugiat dolor ut felis sagittis, a consequat justo ullamcorper. Praesent nec ipsum ante. In tristique leo vitae neque posuere, pharetra feugiat arcu fringilla.",
          style: TextStyle(
              color: Colors.grey[800], height: 1.2, letterSpacing: .5),
        )
      ],
    );
  }
}
