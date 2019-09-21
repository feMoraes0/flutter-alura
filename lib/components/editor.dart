import 'package:flutter/material.dart';

class Editor extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final String tip;
  final IconData icon;

  Editor({this.controller, this.title, this.tip, this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
      child: TextField(
        controller: controller,
        style: TextStyle(
          fontSize: 20.0,
        ),
        decoration: InputDecoration(
          icon: (icon != null) ? Icon(icon) : null,
          labelText: title,
          hintText: tip,
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}