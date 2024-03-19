import 'package:flutter/material.dart';

class SnackBarMessage{
  void showSnackBar({required String message, required BuildContext context}){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                message,
                style: const TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.grey,
            ));
  }
}