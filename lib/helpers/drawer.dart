// ignore_for_file: use_key_in_widget_constructors, avoid_unnecessary_containers, prefer_const_constructors, unused_field, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:todo_list/screens/categories.dart';
import 'package:todo_list/screens/home.dart';
import 'package:todo_list/services/categoryservice.dart';

class DrawerNavigator extends StatefulWidget {
  @override
  _DrawerNavigatorState createState() => _DrawerNavigatorState();
}

class _DrawerNavigatorState extends State<DrawerNavigator> {
  var _categoryList = <String>[];

  @override
  void initState() {
    super.initState();
    getCategory();
  }

  getCategory() async {
    var _categoryService = CategoryService();
    var categories = await _categoryService.readCategory();
    categories.forEach((category) {
      setState(() {
        _categoryList.add(category['name']);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        backgroundColor: Colors.black,
        elevation: 0,
        child: ListView(
          children: [
            /*UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.person,
                  size: 40,
                ),
              ),  
            ),*/
            Container(
              height: 200,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage("assets/images/night2.jpg"),
                fit: BoxFit.cover,
              )),
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
            Divider(
              thickness: 1,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 6, left: 10),
              child:
                  Text('Categories', style: TextStyle(color: Colors.white30)),
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: _categoryList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_categoryList[index],
                        style: TextStyle(color: Colors.amber)),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
