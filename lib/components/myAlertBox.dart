import 'package:flutter/material.dart';

class MyAlertBox extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const MyAlertBox({
    super.key,
    required this.controller,
    required this.hintText,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.only(top: 20, left: 10, right: 10),
      backgroundColor: Colors.grey[850],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      content: TextField(
        controller: controller,
        style: const TextStyle(color: Colors.white, fontSize: 14),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.green),
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.green,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: onSave,
          child: const Text(
            "Save",
            style: TextStyle(color: Colors.white),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.grey[700],
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: onCancel,
          child: const Text(
            "Cancel",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
