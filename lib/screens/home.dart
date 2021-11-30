// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_final_fields, missing_required_param, unnecessary_new

import 'package:flutter/material.dart';
import 'package:todo_list/helpers/drawer.dart';
import 'package:todo_list/helpers/todo_card.dart';
import 'package:todo_list/models/todo_model.dart';
import 'package:todo_list/screens/todoscreen.dart';
import 'package:todo_list/services/todo_service.dart';
import 'package:colorlizer/colorlizer.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _todoList = <TodoModel>[];
  ColorLizer _colorlizer = ColorLizer();

  @override
  void initState() {
    super.initState();
    getAllTodos();
  }

  getAllTodos() async {
    var _todoService = TodoService();
    var allTodos = await _todoService.readTodo();
    allTodos.forEach((todos) {
      setState(() {
        var todoModel = TodoModel();
        todoModel.id = todos['id'];
        todoModel.title = todos['title'];
        todoModel.description = todos['description'];
        todoModel.category = todos['category'];
        //todoModel.isFilled = todos['isFilled'];
        _todoList.add(todoModel);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TodoList'),
        elevation: 0,
      ),
      drawer: DrawerNavigator(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: StaggeredGridView.countBuilder(
          shrinkWrap: true,
          crossAxisCount: 4,
          itemCount: _todoList.length,
          itemBuilder: (BuildContext context, int index) {
            return TodoCard(
              title: _todoList[index].title,
              description: _todoList[index].description,
              category: _todoList[index].category,
              color: _colorlizer.getSpecialFiledColor([
                Colors.blue[200],
                Colors.red[300],
                Colors.green,
                Colors.amber[200],
                Colors.pink[300],
                Colors.teal[200],
                Colors.deepOrange[200],
                Colors.white,
                Colors.blueGrey,
                Colors.brown,
              ]),
            );
          },
          staggeredTileBuilder: (int index) =>
              StaggeredTile.count(2, index.isEven ? 2.2 : 1.5),
          mainAxisSpacing: 15.0,
          crossAxisSpacing: 15.0,
        ),
      ),
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => TodoScreen()));
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
