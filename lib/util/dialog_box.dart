import 'package:flutter/material.dart';
import 'package:todo_app/util/my_button.dart';

// ignore: must_be_immutable
class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
    });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.blue[300],
      content: Container(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
          //user input
          TextField(
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
              hintText: "Add a new task",
            ),
          ),
          
          //buttons to save and cancel
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            MyButton(text: "Save", onPressed: onSave),

            const SizedBox(width:5),

            MyButton(text: "Cancel", onPressed: onCancel),
          ],)
        ]),)
    );
  }
}