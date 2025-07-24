import 'package:flutter/material.dart';
import 'package:flutter_hive_todo_app/components/dialog_box.dart';
import 'package:flutter_hive_todo_app/components/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // text controller
  final _controller = TextEditingController();

  // list of todo tasks
  List todoList = [
    ["Make tutorial", false],
    ["Buy groceries", true],
    ["Walk the dog", false],
    ["Read a book", true],
  ];

  // function to handle checkbox changes
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      todoList[index][1] = value!;
    });
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
      todoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
  }

  // delete a task
  void deleteTask(int index) {
    setState(() {
      todoList.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Task deleted"),
        duration: Duration(seconds: 2),
      ),
    );
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
        itemCount: todoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: todoList[index][0],
            isCompleted: todoList[index][1],
            onDelete: (context) => deleteTask(index),
            onChanged: (value) => checkBoxChanged(value, index),
          );
        },
      ),
    );
  }
}
