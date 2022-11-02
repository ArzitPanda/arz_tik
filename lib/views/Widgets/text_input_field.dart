import 'package:flutter/material.dart';
import 'package:tik_tok/constants.dart';



class TextInputField extends StatelessWidget {
  final TextEditingController controller;
  final String labeltext;
  final IconData icon;
  final bool isObsecure;
  const TextInputField({Key? key,
    required this.controller,
    required this.labeltext,
    required this.icon,
    required this.isObsecure}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
       labelText: labeltext,
        prefixIcon: Icon(icon,color: buttonColor),
        iconColor: buttonColor,
        focusColor: buttonColor,
        labelStyle: const TextStyle(fontSize: 20.0,color: Colors.redAccent),
        // enabledBorder: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(2.0),
        //   borderSide: const BorderSide(color: Colors.white54),
        //   gapPadding: 10.0
        // ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(2.0),
            borderSide: const BorderSide(color: Colors.white54)
        ),

      ),
      obscureText: isObsecure,
    );
  }
}
