import 'package:first/pages/utils/dialog_box.dart';
import 'package:flutter/material.dart';

class Specifictask extends StatelessWidget {
  final String text;
  const Specifictask({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    //Create a controller
    final _controller = TextEditingController();

    // Function to open dialog box
    void _openDialog() {
      showDialog(
          context: context,
          builder: (context) {
            return DialogBox(
              title: "Ajouter une tâche",
              validText: "Ajouter",
              descriptionText: "Titre tâche",
              onSaved: () {},
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
        title: Text(text),
        backgroundColor: Color(0xff2b3a67),
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
