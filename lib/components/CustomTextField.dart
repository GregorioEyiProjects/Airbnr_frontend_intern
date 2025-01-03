import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final FocusNode focusNode;

  const CustomTextField({
    Key? key,
    required this.hintText,
    required this.controller,
    required this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: TextField(
        focusNode: focusNode,
        controller: controller,
        textAlign: TextAlign.start,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.pink),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          hintStyle: const TextStyle(
            color: Colors.black54,
          ),
        ),
      ),
    );
  }
}
