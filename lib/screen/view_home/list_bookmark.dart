import 'package:flutter/material.dart';

class ListBookmarkPage extends StatefulWidget {
  ListBookmarkPage({Key key}) : super(key: key);

  @override
  _ListBookmarkPageState createState() => _ListBookmarkPageState();
}

class _ListBookmarkPageState extends State<ListBookmarkPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List Bookmark"),
      ),
    );
  }
}
