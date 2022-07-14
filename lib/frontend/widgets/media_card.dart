import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/app_constants.dart';

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
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: AppConst.tealMainColor,
                borderRadius: BorderRadius.all(Radius.circular(20)),
                boxShadow: <BoxShadow>[
                   BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10.0,
                    offset:  Offset(0.0, 10.0),
                  ),
                ],
              ),
              //Content
              child: Row(
                children: [
                  Container(
                    height: 150,
                    width: 80,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),child: FadeInImage(image: NetworkImage(img), placeholder: const NetworkImage('https://via.placeholder.com/600x853/000000/FFFFFF/?text=Data4Peace'),),),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(height: 4.0),
                        Text(title,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600)),
                        //Separator
                        Container(
                            margin: new EdgeInsets.symmetric(vertical: 8.0),
                            height: 2.0,
                            width: 18.0,
                            color: Colors.teal[100]),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(subTitle,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w400)),

                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: [
                            //icon and text
                            Row(
                              children: [
                                const Icon(
                                  Icons.file_upload,
                                  color: Colors.white70,
                                  size: 16,
                                ),
                                const SizedBox(width: 5),
                                Text(files,
                                    style: const TextStyle(
                                        color: Colors.white70, fontSize: 12))
                              ],
                            ),
                            const SizedBox(width: 20),
                            //icon and text
                            Row(
                              children: [
                                const Icon(
                                  Icons.download,
                                  color: Colors.white70,
                                  size: 16,
                                ),
                                const SizedBox(width: 5),
                                Text(views,
                                    style: const TextStyle(
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
