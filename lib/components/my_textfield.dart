import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final bool autoFill;
  final bool autocorrect;
  final TextEditingController controller;
  const MyTextField(
      {super.key,
      required this.hintText,
      required this.controller,
      this.obscureText = false,
      this.autoFill = true,
      this.autocorrect = true});

  @override
  Widget build(BuildContext context) {
    return TextField(
      autocorrect: autocorrect,
      enableSuggestions: autoFill,
      obscureText: obscureText,
      obscuringCharacter: "*",
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        hintText: hintText,
      ),
    );
  }
}
