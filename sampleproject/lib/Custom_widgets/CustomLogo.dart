import 'package:flutter/material.dart';
import 'package:sampleproject/myadditional_folder/constants.dart';

class myCustomLogo extends StatelessWidget {
  //const myCustomLogo({Key? key}) : super(key: key);

  final double screenWidth;
  final double fontSize;

  myCustomLogo({required this.screenWidth, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Text(
      "كهربائي",
      style: TextStyle(
          color: myMainColor, fontFamily: myLogoFont, fontSize: fontSize),
    );
  }
}
