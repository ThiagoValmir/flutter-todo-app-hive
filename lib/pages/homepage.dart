import 'package:flutter/material.dart';
import 'package:flutter_hive_todo_app/components/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      body: ListView.builder(
        itemCount: todoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: todoList[index][0],
            isCompleted: todoList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
          );
        },
      ),
    );
  }
}
