import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  SettingPage({Key key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Setting"),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text("Language"),
            trailing: Text("Indonesia"),
            onTap: () {},
          ),
          ListTile(
            title: Text("Theme"),
            trailing: Text("light"),
          )
        ],
      ),
    );
  }
}
