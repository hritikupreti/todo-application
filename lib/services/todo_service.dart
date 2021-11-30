import 'package:todo_list/models/todo_model.dart';
import 'package:todo_list/repositories/repository.dart';

class TodoService {
  late Repository _repository;

  TodoService() {
    _repository = Repository();
  }

  // ignore: todo
  //INSERTION DATA INTO TODO TABLE
  saveTodo(TodoModel todoModel) async {
    return await _repository.insertData('todo', todoModel.mapping());
  }

  // ignore: todo
  //READ DATA FROM TODO TABLE
  readTodo() async {
    return await _repository.readData('todo');
  }
}
