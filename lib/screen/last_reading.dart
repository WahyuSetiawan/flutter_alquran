import 'package:flutter/material.dart';

class PageLastReading extends StatefulWidget {
  PageLastReading({Key key}) : super(key: key);

  @override
  _PageLastReadingState createState() => _PageLastReadingState();
}

class _PageLastReadingState extends State<PageLastReading> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ListTile(
            title: Text("Update"),
          )
        ],
      ),
    );
  }
}
