import 'package:flutter/material.dart';

void showSnackBar(
  BuildContext context,
  String message, {
  double height = 0,
}) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      margin: EdgeInsets.only(bottom: height),
      content: Text(message),
      behavior: SnackBarBehavior.floating,
    ),
  );
}

void hideSnackbar(BuildContext context) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
}
