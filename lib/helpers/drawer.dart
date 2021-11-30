// ignore_for_file: use_key_in_widget_constructors, avoid_unnecessary_containers, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:todo_list/screens/categories.dart';
import 'package:todo_list/screens/home.dart';

class DrawerNavigator extends StatefulWidget {
  @override
  _DrawerNavigatorState createState() => _DrawerNavigatorState();
}

class _DrawerNavigatorState extends State<DrawerNavigator> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        elevation: 0,
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.person,
                  size: 40,
                ),
              ),
              accountName: Text(
                'Baka',
                //style: TextStyle(color: Colors.yellow),
              ),
              accountEmail: Text(
                'stupidbak@gmail.com',
                //style: TextStyle(color: Colors.yellow),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => Home()));
              },
              leading: Icon(
                Icons.home,
                color: Colors.amber,
              ),
              title: Text(
                'Home',
                style: TextStyle(color: Colors.amber),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => Categories()));
              },
              leading: Icon(
                Icons.list_outlined,
                color: Colors.amber,
              ),
              title: Text(
                'Categories',
                style: TextStyle(color: Colors.amber),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
