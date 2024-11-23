import 'package:flutter/material.dart';

class TextForm extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;
  final Widget img;
  const TextForm(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obscureText,
      required this.img});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: SizedBox(
        height: 65,
        child: TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))),
            prefixIcon: img,
            fillColor: Colors.grey.shade400,
            filled: true,
            hintText: hintText,
          ),
        ),
      ),
    );
  }
}
