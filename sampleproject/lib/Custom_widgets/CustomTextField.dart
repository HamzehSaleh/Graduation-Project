import "package:flutter/material.dart";
import 'package:sampleproject/myadditional_folder/constants.dart';

class myCustomTextField extends StatefulWidget {
  final String hint;
  final IconData icon;
  final TextEditingController? controller;
  final TextInputType? keyboardType;

  myCustomTextField(
      {required this.icon,
      required this.hint,
      this.keyboardType,
      this.controller});

  @override
  State<myCustomTextField> createState() => _myCustomTextFieldState();
}

class _myCustomTextFieldState extends State<myCustomTextField> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      width: screenWidth,
      child: TextFormField(
        controller: widget.controller,
        decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle:
                TextStyle(fontFamily: 'ALMARAI', fontSize: 13, color: TFmyGray),
            prefixIcon: Icon(
              widget.icon,
              size: 20,
            )),
        validator: (value) {
          if (value == "") {
            return "fill plz";
          } else if (value == " ") {
            return "fill plz";
          }
          return "";
        },
        keyboardType: widget.keyboardType,
      ),

      //child: TextField(
      //  keyboardType: keyboardType,
      //  decoration: InputDecoration(
      //      prefixIcon: Icon(icon),
      //      hintText: hint,
      //      hintStyle: TextStyle(
      //          fontFamily: 'ALMARAI', fontSize: 15, color: TFmyGray)),
      //),
    );
  }
}
