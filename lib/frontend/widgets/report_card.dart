import 'package:flutter/material.dart';

class ReportDashcard extends StatelessWidget {
  const ReportDashcard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
                backgroundImage: AssetImage("assets/images/avator.jpg")),
            title: Text("Admin"),
            subtitle: Text("time"),
            trailing: IconButton(
              icon: Icon(Icons.more_horiz),
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }
}
