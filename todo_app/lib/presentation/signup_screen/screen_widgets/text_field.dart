import 'package:flutter/material.dart';
import 'package:todo_app/core/constants/constants.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({super.key, 
    required this.hintText,
    required this.inputType,
    required this.controller,
    required this.onChanged,
  });

  final String hintText;
  final TextInputType inputType;
  final TextEditingController controller;
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        style: kBodyText.copyWith(color: Colors.white),
        keyboardType: inputType,
        controller: controller,
        onChanged: onChanged,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(20),
          hintText: hintText,
          hintStyle: kBodyText,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.grey,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(18),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.white,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(18),
          ),
          errorText: controller.text.isEmpty ? null : onChanged(controller.text),
          // Show error text if onChanged callback returns an error message
        ),
      ),
    );
  }
}
