import 'package:flutter/material.dart';
import 'package:todo_app/core/constants/constants.dart';

class MyTextButton extends StatelessWidget {
  const MyTextButton({
    required this.buttonName,
    required this.onTap,
    required this.bgColor,
    required this.textColor,
  });

  final String buttonName;
  final Function()? onTap; // Updated type to VoidCallback?
  final Color bgColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(18),
      ),
      child: TextButton(
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.resolveWith(
            (states) => Colors.black12,
          ),
        ),
        onPressed: onTap, // Updated onPressed to onTap
        child: Text(
          buttonName,
          style: kButtonText.copyWith(color: textColor),
        ),
      ),
    );
  }
}
