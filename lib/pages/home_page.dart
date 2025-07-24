import 'package:flutter/material.dart';
import 'package:flutter_hive_todo_app/components/dialog_box.dart';
import 'package:flutter_hive_todo_app/components/todo_tile.dart';
import 'package:flutter_hive_todo_app/data/database.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // reference to the Hive box
  final _myBox = Hive.box('myBox');
  // instance of the todo list via DataBase
  ToDoDataBase db = ToDoDataBase();

  void initState() {
    super.initState();
    // if the box is empty, create initial data
    if (_myBox.get('TODOLIST') == null) {
      db.createInitialData();
    } else {
      // there already exists data, load it
      db.loadData();
    }
    // update the database
    db.updateDataBase();
  }

  // text controller
  final _controller = TextEditingController();

  // function to handle checkbox changes
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.todoList[index][1] = value!;
    });
    db.updateDataBase();
  }

  // create a new task
  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            controller: _controller,
            onSave: saveNewTask,
            onCancel: Navigator.of(context).pop,
          );
        });
  }

  // save the new task
  void saveNewTask() {
    setState(() {
      db.todoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  // delete a task
  void deleteTask(int index) {
    setState(() {
      db.todoList.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Task deleted"),
        duration: Duration(seconds: 2),
      ),
    );
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        centerTitle: true,
        title: const Text("TO DO"),
        backgroundColor: Colors.yellow,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: db.todoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: db.todoList[index][0],
            isCompleted: db.todoList[index][1],
            onDelete: (context) => deleteTask(index),
            onChanged: (value) => checkBoxChanged(value, index),
          );
        },
      ),
    );
  }
}
