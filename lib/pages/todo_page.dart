import 'package:first/database/todo_db.dart';
import 'package:first/pages/specific_task.dart';
import 'package:first/pages/utils/dialog_box.dart';
import 'package:first/pages/utils/todo_task.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class toDoPage extends StatefulWidget {
  const toDoPage({super.key});

  @override
  State<toDoPage> createState() => _toDoPageState();
}

class _toDoPageState extends State<toDoPage> {
  final _controller = TextEditingController();
  ToDoDatabase db = ToDoDatabase();

  final _myBox = Hive.box('todolist');
  // TextEditingController myController = TextEditingController();
  @override
  void initState() {
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    // TODO: implement initState
    super.initState();
  }

  String password = "password";
// ----------My functions----------------- //

//__Save Data__//
  void onSave() {
    if (_controller.text != "") {
      setState(() {
        db.todolist.add({
          'title': _controller.text,
          'date': GenerateDate(),
          'secure': false
        });
        _controller.clear();
      });

      // await todoDB.create(title: title);
      // if (!mounted) return;
      // fetchTodos();
      // print(futureTodos);
    } else {
      const snackBar = SnackBar(
        content: Text('Veillez remplir le champ'),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    Navigator.of(context).pop();
    db.updateDatabase();
  }

  //__To Generate current date__

  String GenerateDate() {
    final DateFormat formatter = DateFormat('yyyy - MM - dd');
    DateTime now = DateTime.now();
    return formatter.format(now);
  }

//__Delete Data__//
  void deleteTask(int index) {
    setState(() {
      db.todolist.removeAt(index);
    });
    db.updateDatabase();
  }

//__Secure Task__//
  void secureTask(int index) {
    setState(() {
      if (db.todolist[index]['secure']) {
        showDialog(
            context: context,
            builder: (context) {
              return DialogBox(
                title: "Mot de passe",
                onSaved: () => openTask(index),
                descriptionText: "Mot de passe",
                validText: "Rendre public",
                onCancel: () => Navigator.of(context).pop(),
                controller: _controller,
              );
            });
      } else {
        db.todolist[index]['secure'] = !db.todolist[index]['secure'];
        db.updateDatabase();
      }
    });
  }

  //Task detail
  void task_detail(int index) {
    String title = db.todolist[index]['title'];
    String dateDeCreation = db.todolist[index]['date'];
    String securite = db.todolist[index]['secure'] ? "Privé" : "Public";
    final snackBar = SnackBar(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Titre : " + title),
          Text("Date : " + dateDeCreation),
          Text("Status : " + securite),
        ],
      ),
      backgroundColor: Colors.black,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  //__Open Task__
  void openTask(int index) {
    if (_controller.text == password) {
      setState(() {
        db.todolist[index]['secure'] = !db.todolist[index]['secure'];
      });
      Navigator.of(context).pop();
      _controller.clear();
    }
  }

//__Open Dialog Box__//
  void _openDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            title: "Ajouter une tâche",
            validText: "Ajouter",
            descriptionText: "Titre tâche",
            onSaved: onSave,
            onCancel: () => Navigator.of(context).pop(),
            controller: _controller,
          );
        });
  }

  void _openPasswordDialog(int index) {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            title: "Mot de passe requis",
            descriptionText: "Entrez le mot de passe",
            validText: "Ouvrir",
            onSaved: () {
              if (_controller.text == password) {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Specifictask(
                        text: db.todolist[index]['title'],
                        id: index,
                      ),
                    ));
                _controller.clear();
              } else {
                final snackBar = SnackBar(
                  content: Text('Mot de passe incorrect'),
                  backgroundColor: Colors.red,
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            },
            onCancel: () => Navigator.of(context).pop(),
            controller: _controller,
          );
        });
  }

//__edit task__

  void _edit_task(int index) {
    setState(() {
      _controller.text = db.todolist[index]['title'];
    });
    _openDialog();
  }

// ----------My functions----------------- //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff496a81),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text("Mes tâches"),
        backgroundColor: Color(0xff2b3a67),
      ),
      drawer: Drawer(
        backgroundColor: Color(0xff2b3a67),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                DrawerHeader(
                    child: Text(
                  "Menu",
                  style: TextStyle(fontSize: 30),
                )),
                ListTile(
                  leading: Icon(
                    Icons.settings,
                    color: Colors.white,
                  ),
                  title: Text(
                    "Réglage",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    // go to reglage page
                    Navigator.pushNamed(context, '/option');
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.delete_outline,
                    color: Colors.white,
                  ),
                  title: Text(
                    "Corbeille",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            //Quitter l'application
            ListTile(
              leading: Icon(
                Icons.exit_to_app,
                color: Colors.white,
              ),
              title: Text(
                "Quitter",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
      body: _myBox.get("TODOLIST") == null
          ? Center(
              child: Text("Aucune tâche à réaliser"),
            )
          : ListView.builder(
              itemCount: db.todolist.length,
              itemBuilder: (context, index) {
                return ToDoTask(
                  TaskName: db.todolist[index]['title'],
                  CreatedDate: db.todolist[index]['date'],
                  delete_task: (context) => deleteTask(index),
                  id: index,
                  secure: db.todolist[index]['secure'],
                  edit_task: () => _edit_task(index),
                  task_detail: () => task_detail(index),
                  dialog_pass: () => _openPasswordDialog(index),
                  secure_task: () => secureTask(index),
                );
              }),
      floatingActionButton: FloatingActionButton(
        onPressed: _openDialog,
        tooltip: "Ajouter une tâche",
        child: Icon(Icons.add),
        backgroundColor: Color(0xff2b3a67),
      ),
    );
  }
}
