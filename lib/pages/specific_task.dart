import 'package:first/database/single_todo.dart';
import 'package:first/pages/utils/dialog_box.dart';
import 'package:first/pages/utils/todo_task_list.dart';
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
  final _myBox = Hive.box('singleList');
  SingleToDo db = SingleToDo();

  @override
  void initState() {
    // TODO: implement initState
    if (_myBox.get("SINGLE") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  void checkboxChange(bool? value, int index) {
    setState(() {
      db.demoTask[index]['status'] = !db.demoTask[index]['status'];
    });
  }

  void deleteTask(int index) {
    setState(() {
      db.demoTask.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    //Create a controller
    final _controller = TextEditingController();
    print(widget.id);

    void onSave(int id) {
      if (_controller.text != "") {
        setState(() {
          db.demoTask[id].add([_controller.text, false]);
          _controller.clear();
        });
        db.updateDatabase();
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
              onSaved: () => onSave(widget.id),
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
      body: ListView.builder(
        itemCount: db.demoTask.length,
        itemBuilder: (context, index) {
          return TaskList(
            TaskName: db.demoTask[widget.id][index][0],
            TaskCompleted: db.demoTask[widget.id][index][1],
            delete_task: (context) => deleteTask(index),
            onChanged: (value) => checkboxChange(value, index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openDialog,
        tooltip: "Ajouter une tâche",
        child: Icon(Icons.add),
        backgroundColor: Color(0xff2b3a67),
      ),
    );
  }
}
