import 'package:todo_list/models/categorymodel.dart';
import 'package:todo_list/repositories/repository.dart';

class CategoryService {
  late Repository _repository;

  CategoryService() {
    _repository = Repository();
  }

//CREATE CATEGORY...
  savecategory(CategoryModel category) async {
    return await _repository.insertData(
        'categories', category.categoryMapping());
  }

//READ DATA FROM TABLE...
  readCategory() async {
    return await _repository.readData('categories');
  }

  //READ DATA BY ID.....
  readCategoryById(id) async {
    return await _repository.readDataById('categories', id);
  }

//UPDATE CATEGORY.....
  updateCategory(CategoryModel categorymodel) async {
    return await _repository.updateData(
        'categories', categorymodel.categoryMapping());
  }

//DELETE CATEGORY BY ID
  deleteById(id) async {
    return await _repository.deleteData('categories', id);
  }
}
