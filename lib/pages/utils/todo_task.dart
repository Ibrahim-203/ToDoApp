import 'package:first/pages/specific_task.dart';
import 'package:first/pages/utils/dropdrown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoTask extends StatelessWidget {
  final String TaskName;
  final String CreatedDate;
  final int id;
  Function(BuildContext)? delete_task;
  Function()? secure_task;
  Function()? task_detail;
  Function()? edit_task;
  Function()? dialog_pass;
  bool secure;

  ToDoTask({
    super.key,
    required this.TaskName,
    required this.CreatedDate,
    required this.delete_task,
    required this.secure_task,
    required this.task_detail,
    required this.edit_task,
    required this.id,
    required this.dialog_pass,
    required this.secure,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, top: 25.0, right: 25.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: delete_task,
              icon: Icons.delete,
              backgroundColor: Colors.red.shade300,
            )
          ],
        ),
        child: GestureDetector(
          onTap: () {
            if (!secure) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Specifictask(text: TaskName, id: id),
                  ));
            } else {
              dialog_pass?.call();
            }
          },
          child: Container(
            padding: EdgeInsets.all(20.0),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Color(0xff2b3a67),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      TaskName,
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      CreatedDate,
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: secure_task,
                          child: Icon(
                            secure ? Icons.lock : Icons.lock_open,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: task_detail,
                          child: Icon(
                            Icons.details,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: edit_task,
                          child: Icon(
                            Icons.border_color,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                // DropDown()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
