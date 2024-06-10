import 'package:first/pages/utils/my_button.dart';
import 'package:flutter/material.dart';

class DialogBox extends StatelessWidget {
  final controller;
  final String title;
  final String validText;
  // for the hint text
  final String descriptionText;
  VoidCallback onSaved;
  VoidCallback onCancel;
  DialogBox({
    super.key,
    required this.title,
    required this.validText,
    required this.descriptionText,
    required this.onSaved,
    required this.onCancel,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      backgroundColor: Color(0xff2b3a67),
      content: Container(
        height: 120,
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          TextField(
            controller: controller,
            decoration: InputDecoration(
                border: OutlineInputBorder(), hintText: descriptionText),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MyButton(text: validText, onPressed: onSaved),
              SizedBox(
                width: 8,
              ),
              MyButton(text: "Annuler", onPressed: onCancel),
            ],
          )
        ]),
      ),
    );
  }
}
