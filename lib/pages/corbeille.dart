import 'package:first/model/task.dart';
import 'package:first/pages/utils/todo_task.dart';
import 'package:first/services/database_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Corbeille extends StatefulWidget {
  Corbeille({super.key});

  @override
  State<Corbeille> createState() => _CorbeilleState();
}

class _CorbeilleState extends State<Corbeille> {
  DatabaseServices db = DatabaseServices.instance;

  void deleteTask(int id) {
    db.deleteTaskTempo(id, 0);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff496a81),
      appBar: AppBar(
        backgroundColor: Color(0xff2b3a67),
        title: Text("Corbeille"),
        actions: [
          IconButton(
            onPressed: () {
              db.deleteAllTask();
              setState(() {});
            },
            icon: Icon(Icons.delete),
          )
        ],
      ),
      body: FutureBuilder(
          future: db.getTasks(0),
          builder: ((context, snapshot) {
            return ListView.builder(
                itemCount: snapshot.data?.length ?? 0,
                itemBuilder: (context, index) {
                  Tasks task = snapshot.data![index];
                  print(task);
                  return Padding(
                    padding: const EdgeInsets.only(
                      left: 8.0,
                      top: 8.0,
                      right: 8.0,
                    ),
                    child: Slidable(
                      endActionPane: ActionPane(
                        motion: StretchMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context) => deleteTask(task.id),
                            icon: Icons.delete,
                            backgroundColor: Colors.red.shade300,
                          )
                        ],
                      ),
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Color(0xff2b3a67),
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              task.content,
                              style: TextStyle(color: Colors.white),
                            ),
                            IconButton(
                              onPressed: () {
                                db.restoreTask(task.id);
                                setState(() {});
                              },
                              icon: Icon(Icons.restore, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          })),
    );
  }
}
