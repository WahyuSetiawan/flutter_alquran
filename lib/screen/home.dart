import 'package:alquran/bloc/bloc_item_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'dashboard.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomeStateState createState() => _HomeStateState();
}

class _HomeStateState extends State<HomePage> {
  BottomNavigationBar bottomNavigation(PageNavigationBar pageNavigationBar) {
    return BottomNavigationBar(
      currentIndex: PageNavigationBar.values.indexOf(pageNavigationBar),
      onTap: (value) {
        context.bloc<NavigationBloc>().add(PageNavigationBar.values[value]);
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.home),
          title: Text("Dashboard"),
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.home),
          title: Text("home"),
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.adobe),
          title: Text("Last Reading"),
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.addressBook),
          title: Text("Setting"),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, PageNavigationBar>(
      builder: (context, pageNavigationBar) => Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: DashboardPage(),
        // bottomNavigationBar: bottomNavigation(pageNavigationBar),
      ),
    );
  }
}
