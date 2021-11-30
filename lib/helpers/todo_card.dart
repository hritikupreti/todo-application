// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, prefer_const_constructors

import 'package:flutter/material.dart';

class TodoCard extends StatelessWidget {
  String title;
  String description;
  String category;
  Color? color;
  TodoCard(
      {required this.category,
      required this.title,
      required this.description,
      required this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
              alignment: Alignment(-1, 0),
              child: Text(
                title,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                    fontSize: 17),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 2, horizontal: 12),
              alignment: Alignment(-1, 0),
              child: Text(
                description,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 12),
              ),
            )
          ],
        ),
      ),
    );
  }
}
