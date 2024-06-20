import 'package:first/model/todo.dart';
import 'package:first/pages/utils/dialog_box.dart';
import 'package:first/pages/utils/todo_task_list.dart';
import 'package:first/services/database_services.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Specifictask extends StatefulWidget {
  final String text;
  final int id;

  Specifictask({super.key, required this.text, required this.id});

  @override
  State<Specifictask> createState() => _SpecifictaskState();
}

class _SpecifictaskState extends State<Specifictask> {
  List demoTask = [
    ['test', false],
  ];

  final DatabaseServices _databaseServices = DatabaseServices.instance;

  void checkboxChange(bool? value, int id) {
    var status;
    if (value == false) {
      status = 0;
    } else {
      status = 1;
    }
    _databaseServices.updateSingleTask(id, status);
    setState(() {});
  }

  void deleteTask(int id) {
    _databaseServices.deleteSingleTask(id);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    //Create a controller
    final _controller = TextEditingController();

    void onSave() {
      if (_controller.text != "") {
        _databaseServices.addSingleTask(_controller.text, widget.id);
        setState(() {
          _controller.clear();
        });
      }
      Navigator.of(context).pop();
    }

    // Function to open dialog box
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

    return Scaffold(
      backgroundColor: Color(0xff496a81),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(widget.text),
        backgroundColor: Color(0xff2b3a67),
      ),
      body: FutureBuilder(
          future: _databaseServices.getSingleTasks(widget.id),
          builder: (context, snapshot) {
            return ListView.builder(
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                Todo todo = snapshot.data![index];
                return TaskList(
                    TaskName: todo.content,
                    TaskCompleted: todo.status == 0 ? false : true,
                    delete_task: (context) => deleteTask(todo.id),
                    onChanged: (value) => checkboxChange(value, todo.id));
              },
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
