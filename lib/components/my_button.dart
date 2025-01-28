import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function() ? onTap;
  final String text;
   MyButton({
    super.key,
    required this.onTap,
    required this.text
    });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(25),
        margin: EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: Colors.green.shade200,
         borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(child: Text(text)),
      ),
    );
  }
}