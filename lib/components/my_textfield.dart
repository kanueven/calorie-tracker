import 'package:flutter/material.dart';

class MyTextfield extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
   final bool obsecureText;

   MyTextfield({
  super.key,
  required this.hintText,
  required this.obsecureText,
  required this.textEditingController,  
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        
        controller: textEditingController,
        obscureText: obsecureText,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green)
          ),
          focusedBorder: OutlineInputBorder(
             borderSide: BorderSide(color: Colors.green.shade300),
          ),
          hintText: hintText,
        ),
        
        
      ),
    );
  }
}