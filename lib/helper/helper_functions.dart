import 'package:flutter/material.dart';

void displayMessageToUser(String message, BuildContext context) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text(message),
          ));
}

SizedBox getSizedBox({double width = 0, double height = 0}) {
  return SizedBox(
    width: width,
    height: height,
  );
}
