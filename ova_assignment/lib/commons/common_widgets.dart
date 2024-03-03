import 'package:flutter/material.dart';

class inputTextFiled extends StatelessWidget {
  const inputTextFiled(
      {super.key,
      required this.controller,
      required this.maxline,
      required this.hint});
  final TextEditingController controller;
  final maxline;
  final String hint;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxline,
      decoration: InputDecoration(
          hintText: hint,
          fillColor: Colors.grey,
          filled: true,
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black54))),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Enter your $hint';
        }
        return null;
      },
    );
  }
}

void showsnackbar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
}
