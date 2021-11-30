// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_collection_literals, deprecated_member_use, prefer_final_fields, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:todo_list/models/todo_model.dart';
import 'package:todo_list/services/categoryservice.dart';
import 'package:todo_list/services/todo_service.dart';

class TodoScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  var _categories = List<DropdownMenuItem>.empty(growable: true);
  var _selectedValue;
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _loadcategory();
  }

  //CONTROLLERS......
  var todoTitleController = TextEditingController();
  var todoDescriptionController = TextEditingController();

  //GET CATEGORIES FOR DROPDOWN LIST......
  _loadcategory() async {
    var _categoryService = CategoryService();
    var categories = await _categoryService.readCategory();
    categories.forEach((category) {
      setState(() {
        _categories.add(DropdownMenuItem(
          child: Text(category['name']),
          value: category['name'],
        ));
      });
    });
  }

  //SNACKBAR......
  _showSnackBar(message) {
    var snackBar = SnackBar(
      content: message,
    );
    _globalKey.currentState?.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        title: const Text('Create Todu'),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              TextField(
                controller: todoTitleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  hintText: 'write todo title',
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                controller: todoDescriptionController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  labelText: 'Description',
                  hintText: 'write description',
                ),
              ),
              SizedBox(
                height: 15,
              ),
              DropdownButtonFormField<dynamic>(
                items: _categories,
                value: _selectedValue,
                hint: Text('Categories'),
                onChanged: (value) {
                  setState(() {
                    _selectedValue = value;
                  });
                },
              ),
              SizedBox(
                height: 150,
              ),
              RaisedButton(
                color: Colors.amber,
                onPressed: () async {
                  TodoService _todoService = TodoService();
                  TodoModel _todoModel = TodoModel();
                  _todoModel.title = todoTitleController.text;
                  _todoModel.description = todoDescriptionController.text;
                  _todoModel.category = _selectedValue.toString();
                  _todoModel.isFilled = 0;
                  var result = await _todoService.saveTodo(_todoModel);
                  print(result);
                  if (result > 0) {
                    _showSnackBar(Text('Created'));
                  }
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
