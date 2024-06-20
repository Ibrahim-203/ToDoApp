import 'package:first/model/task.dart';
import 'package:first/pages/specific_task.dart';
import 'package:first/pages/utils/dialog_box.dart';
import 'package:first/pages/utils/todo_task.dart';
import 'package:first/services/database_services.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class toDoPage extends StatefulWidget {
  const toDoPage({super.key});

  @override
  State<toDoPage> createState() => _toDoPageState();
}

class _toDoPageState extends State<toDoPage> {
  final _controller = TextEditingController();
  DatabaseServices db = DatabaseServices.instance;

  String password = "password";
// ----------My functions----------------- //
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {});
  }

//__Save Data (create)__//
  void onSave() {
    if (_controller.text != "") {
      db.addTask(_controller.text, GenerateDate());
      setState(() {});
      _controller.clear();
    } else {
      const snackBar = SnackBar(
        content: Text('Veillez remplir le champ'),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    Navigator.of(context).pop();
  }

  void onSaveUp(int id) {
    if (_controller.text != "") {
      db.updateTask(id, _controller.text);
      setState(() {});
      _controller.clear();
    } else {
      const snackBar = SnackBar(
        content: Text('Veillez remplir le champ'),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    Navigator.of(context).pop();
  }

  //__To Generate current date__

  String GenerateDate() {
    final DateFormat formatter = DateFormat('yyyy - MM - dd HH:mm');
    DateTime now = DateTime.now();
    return formatter.format(now);
  }

//__Delete Data__//
  void deleteTask(int id) {
    db.deleteTaskTempo(id, 1);
    setState(() {});
  }

//__Secure Task__//
  void secureTask(int id, int secure) {
    if (secure == 1) {
      showDialog(
          context: context,
          builder: (context) {
            return DialogBox(
              title: "Mot de passe",
              onSaved: () => openTask(id),
              descriptionText: "Mot de passe",
              validText: "Rendre public",
              onCancel: () => Navigator.of(context).pop(),
              controller: _controller,
            );
          });
    } else {
      db.secureTask(id, secure == 0 ? 1 : 0);
      setState(() {});
    }
  }

  //Task detail
  void task_detail(String content, String createdAt, int secure) {
    String status = secure == 0 ? "public" : "privé";
    final snackBar = SnackBar(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Titre : " + content),
          Text("Date : " + createdAt),
          Text("Status : " + status),
        ],
      ),
      backgroundColor: Colors.black,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  //__Open Task__
  void openTask(int id) {
    if (_controller.text == password) {
      db.secureTask(id, 0);
      setState(() {});
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

  void _openEditDialog(int id) {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            title: "Modifier la tâche",
            validText: "Modifier",
            descriptionText: "Titre tâche",
            onSaved: () => onSaveUp(id),
            onCancel: () => Navigator.of(context).pop(),
            controller: _controller,
          );
        });
  }

  void _openPasswordDialog(int id, String content) {
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
                        text: content,
                        id: id,
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

  void _edit_task(int id, String content) {
    setState(() {
      _controller.text = content;
    });
    _openEditDialog(id);
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
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/corbeille');
                  },
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
      body: FutureBuilder(
          future: db.getTasks(1),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Erreur: ${snapshot.error}',
                    style: TextStyle(color: Colors.red, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      // Retry logic here, e.g., call setState() to rebuild the widget
                      // or use a method to fetch data again.
                    },
                    child: Text('Réessayer'),
                  ),
                ],
              );
            } else if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    Tasks task = snapshot.data![index];
                    print(task);
                    return ToDoTask(
                      TaskName: task.content,
                      CreatedDate: task.createdAt,
                      delete_task: (context) => deleteTask(task.id),
                      id: index,
                      secure: task.secure,
                      edit_task: () => _edit_task(task.id, task.content),
                      task_detail: () => task_detail(
                          task.content, task.createdAt, task.secure),
                      dialog_pass: () =>
                          _openPasswordDialog(task.id, task.content),
                      secure_task: () => secureTask(task.id, task.secure),
                    );
                  });
            } else {
              return Text('Aucune donnée disponible');
            }
          })),
      floatingActionButton: FloatingActionButton(
        onPressed: _openDialog,
        tooltip: "Ajouter une tâche",
        child: Icon(Icons.add),
        backgroundColor: Color(0xff2b3a67),
      ),
    );
  }
}
