import 'package:first/pages/reglage.dart';
import 'package:first/pages/todo_page.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
// import 'package:firebase_core/firebase_core.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();

  // await Firebase.initializeApp();
  //initialize the hive
  await Hive.initFlutter();

  var box = await Hive.openBox("todolist");
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: toDoPage(),
      routes: {
        '/option': (context) => Reglage(),
      },
      // theme: ThemeData(primarySwatch: Colors.indigo),
    );
  }
}
