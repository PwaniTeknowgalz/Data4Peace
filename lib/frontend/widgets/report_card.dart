import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReportDashcard extends StatelessWidget {
  const ReportDashcard(
      {Key? key,
      required this.userImg,
      required this.userTitle,
      required this.timestamp,
      required this.bannerImg,
      required this.caption,
      required this.favourites,
      required this.comments,
      required this.readMoreClick})
      : super(key: key);
  final String userImg,
      userTitle,
      timestamp,
      bannerImg,
      caption,
      favourites,
      comments;
  final VoidCallback readMoreClick;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 3),
      child: Card(
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(backgroundImage: AssetImage(userImg)),
              title: Text(userTitle),
              subtitle: Text(timestamp),
              trailing: IconButton(
                icon: Icon(Icons.more_horiz),
                //TODO: add share, details
                onPressed: () {},
              ),
            ),
            Container(
              width: Get.width,
              height: Get.height * .2,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(bannerImg), fit: BoxFit.cover)),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Text(
                caption,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                alignment: AlignmentDirectional.centerStart,
                child: TextButton(
                    onPressed: readMoreClick,
                    child: Text(
                      "Read more...",
                      style: TextStyle(color: Colors.black54),
                    ))),
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 16,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  //first Row with icon
                  Row(
                    children: [
                      Icon(Icons.favorite, color: Colors.red, size: 18),
                      SizedBox(width: 4),
                      Text(favourites),
                    ],
                  ),
                  SizedBox(width: 20),
                  //second Row with icon
                  Row(
                    children: [
                      Icon(Icons.message, color: Colors.grey, size: 18),
                      SizedBox(width: 4),
                      Text(comments),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}