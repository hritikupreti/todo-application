// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:todo_list/models/categorymodel.dart';
import 'package:todo_list/services/categoryservice.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  void initState() {
    super.initState();
    getAllCategory();
  }

  var category;
  static int idcount = 0;
  var categorymodel = CategoryModel();
  var categoryService = CategoryService();

  //GET ALL CATEGORIES INTO CATEGORY LIST......
  List<CategoryModel> _categoryList = <CategoryModel>[];
  getAllCategory() async {
    _categoryList = <CategoryModel>[];
    var categories = await categoryService.readCategory();
    categories.forEach((category) {
      setState(() {
        var tempCategoryModel = CategoryModel();
        tempCategoryModel.id = category['id'];
        tempCategoryModel.name = category['name'];
        tempCategoryModel.description = category['description'];
        _categoryList.add(tempCategoryModel);
      });
    });
  }

// CONTROLLERS.....
  var _categoryNameController = TextEditingController();
  var _categoryDescriptionController = TextEditingController();
  var _editCategoryNameController = TextEditingController();
  var _editCategoryDescriptionController = TextEditingController();
  var id;

  //EDIT CATEGORY.......
  editCategory(BuildContext context, categoryId) async {
    category = await categoryService.readCategoryById(categoryId);
    setState(() {
      _editCategoryNameController.text = category[0]['name'] ?? 'No Name';
      _editCategoryDescriptionController.text =
          category[0]['description'] ?? 'No Description';
      id = category[0]['id'];
    });
    _editFormDialog(context);
  }

  //Alert diolog box for categories section.....
  _showFormDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (show) {
          return AlertDialog(
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancle')),
              FlatButton(
                  color: Colors.amber,
                  onPressed: () async {
                    categorymodel.name = _categoryNameController.text;
                    categorymodel.description =
                        _categoryDescriptionController.text;
                    await categoryService.savecategory(categorymodel);
                    getAllCategory();
                    Navigator.pop(context);
                  },
                  child: Text('Save')),
            ],
            title: Text('Categories Forms'),
            content: SingleChildScrollView(
              child: Column(children: [
                TextField(
                  controller: _categoryNameController,
                  decoration: InputDecoration(
                      hintText: 'write a categories', labelText: 'Categories'),
                ),
                TextField(
                  controller: _categoryDescriptionController,
                  decoration: InputDecoration(
                      hintText: 'write a description', labelText: 'decription'),
                ),
              ]),
            ),
          );
        });
  }

  //ALERT DIALOG FOR EDIT CATEGORY SECTION......
  _editFormDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (show) {
          return AlertDialog(
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancle')),
              FlatButton(
                  color: Colors.amber,
                  onPressed: () async {
                    CategoryModel cm = CategoryModel();
                    cm.id = category[0]['id'];
                    cm.name = _editCategoryNameController.text;
                    cm.description = _editCategoryDescriptionController.text;
                    await categoryService.updateCategory(cm);
                    getAllCategory();
                    Navigator.pop(context);
                  },
                  child: Text('Update')),
            ],
            title: Text('Categories Forms'),
            content: SingleChildScrollView(
              child: Column(children: [
                TextField(
                  controller: _editCategoryNameController,
                  decoration: InputDecoration(
                      hintText: 'write a categories', labelText: 'Categories'),
                ),
                TextField(
                  controller: _editCategoryDescriptionController,
                  decoration: InputDecoration(
                      hintText: 'write a description', labelText: 'decription'),
                ),
              ]),
            ),
          );
        });
  }

  //DELETE ALERT DIALOG........
  _deleteDialog(BuildContext context, categoryId) {
    return showDialog(
        context: context,
        builder: (show) {
          return AlertDialog(
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancle')),
              FlatButton(
                  color: Colors.amber,
                  onPressed: () async {
                    await categoryService.deleteById(categoryId);
                    getAllCategory();
                    Navigator.pop(context);
                  },
                  child: Text('delete')),
            ],
            title: Text('You want to delete this?'),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('categories'),
        elevation: 0,
      ),
      body: ListView.builder(
          itemCount: _categoryList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
              child: Card(
                elevation: 0,
                child: ListTile(
                  leading: IconButton(
                    onPressed: () {
                      editCategory(context, _categoryList[index].id);
                    },
                    icon: Icon(
                      Icons.edit,
                      color: Colors.amber,
                    ),
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _categoryList[index].name,
                        style: TextStyle(color: Colors.amber),
                      ),
                      IconButton(
                          onPressed: () {
                            _deleteDialog(context, _categoryList[index].id);
                          },
                          icon: Icon(Icons.delete, color: Colors.amber)),
                    ],
                  ),
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        onPressed: () {
          _showFormDialog(context);
        },
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}
