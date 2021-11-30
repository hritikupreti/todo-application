// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:todo_list/helpers/drawer.dart';
import 'package:todo_list/models/todo_model.dart';
import 'package:todo_list/screens/todoscreen.dart';
import 'package:todo_list/services/todo_service.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _todoList = <TodoModel>[];

  getAllTodos() async {
    var _todoService = TodoService();
    var allTodos = _todoService.readTodo();
    allTodos.forEach((todos) {
      var todoModel = TodoModel();
      todoModel.description = allTodos['id'];
      todoModel.title = allTodos['title'];
      todoModel.description = allTodos['description'];
      todoModel.category = allTodos['category'];
      todoModel.isFilled = allTodos['isFilled'];
      _todoList.add(todoModel);
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
      body: const Center(child: Text('Welcome Home')),
      backgroundColor: Colors.white38,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => TodoScreen()));
        },
        child: Icon(Icons.add, color: Colors.amber),
      ),
    );
  }
}
