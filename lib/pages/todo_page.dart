import 'package:first/pages/specific_task.dart';
import 'package:first/pages/utils/dialog_box.dart';
import 'package:first/pages/utils/todo_task.dart';
import 'package:flutter/material.dart';

class toDoPage extends StatefulWidget {
  const toDoPage({super.key});

  @override
  State<toDoPage> createState() => _toDoPageState();
}

class _toDoPageState extends State<toDoPage> {
  final _controller = TextEditingController();
  // TextEditingController myController = TextEditingController();
  List todolist = [
    {'title': 'Jouer au basket', 'date': '2024-06-02', 'secure': false},
    {'title': 'Apprendre à coder', 'date': '2024-06-01', 'secure': true},
    {
      'title': 'Finir l\'application mobile',
      'date': '2024-06-01',
      'secure': false
    },
  ];

  String password = "password";
// ----------My functions----------------- //

//__Save Data__//
  void onSave() {
    if (_controller.text != "") {
      setState(() {
        todolist.add([_controller.text, "20-01-2023"]);
        _controller.clear();
      });
    }
    Navigator.of(context).pop();
  }

//__Delete Data__//
  void deleteTask(int index) {
    setState(() {
      todolist.removeAt(index);
    });
  }

//__Secure Task__//
  void secureTask(int index) {
    setState(() {
      if (todolist[index]['secure']) {
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
        todolist[index]['secure'] = !todolist[index]['secure'];
      }
    });
  }

  //__Open Task__
  void openTask(int index) {
    if (_controller.text == password) {
      setState(() {
        todolist[index]['secure'] = !todolist[index]['secure'];
      });
      Navigator.of(context).pop();
      _controller.clear();
    }
  }

//__Open Dialog Box__//
  void _openDialog() {
    print("abc");
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
                      builder: (context) =>
                          Specifictask(text: todolist[index]['title']),
                    ));
                _controller.clear();
              } else {
                print("Faux");
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
      _controller.text = todolist[index]['title'];
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
      body: ListView.builder(
          itemCount: todolist.length,
          itemBuilder: (context, index) {
            return ToDoTask(
              TaskName: todolist[index]['title'],
              CreatedDate: todolist[index]['date'],
              delete_task: (context) => deleteTask(index),
              secure: todolist[index]['secure'],
              edit_task: () => _edit_task(index),
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
