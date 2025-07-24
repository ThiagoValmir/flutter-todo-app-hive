import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase {
  // list of todo tasks
  List todoList = [];

  // reference to the Hive box
  final _myBox = Hive.box('myBox');

  // create initial database method, only occurs once ever, the first time app runs
  void createInitialData() {
    todoList = [
      ["Make tutorial", false],
      ["Buy groceries", true],
      ["Walk the dog", false],
      ["Read a book", true],
    ];
  }

  // load data from the database
  void loadData() {
    todoList = _myBox.get('TODOLIST');
  }

  // update the datavase
  void updateDataBase() {
    _myBox.put('TODOLIST', todoList);
  }
}
