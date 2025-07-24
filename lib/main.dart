import 'package:flutter/material.dart';
import 'package:flutter_hive_todo_app/pages/home_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() {
  Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(colorSchemeSeed: Colors.yellow, useMaterial3: true),
      home: HomePage(),
    );
  }
}
