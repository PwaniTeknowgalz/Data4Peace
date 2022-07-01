import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MediaCard extends StatelessWidget {
  const MediaCard(
      {Key? key,
      required this.img,
      required this.title,
      required this.subTitle,
      required this.files,
      required this.views,
      required this.onclick})
      : super(key: key);
  final String img, title, subTitle, files, views;
  final VoidCallback onclick;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onclick,
      child: Container(
        child: Stack(
          children: [
            Container(
              height: 150,
              width: Get.width,
              padding: EdgeInsets.all(8),
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
              child: Row(
                children: [
                  Container(
                    height: 150,
                    width: 80,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        image: DecorationImage(
                            image: AssetImage(img), fit: BoxFit.cover)),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(height: 4.0),
                        Text(title,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600)),
                        //Separator
                        Container(
                            margin: new EdgeInsets.symmetric(vertical: 8.0),
                            height: 2.0,
                            width: 18.0,
                            color: Colors.teal[100]),
                        SizedBox(
                          height: 12,
                        ),
                        Text(subTitle,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white70,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w400)),

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
                                Text(files,
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
                                Text(views,
                                    style: TextStyle(
                                        color: Colors.white70, fontSize: 12))
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
