import 'package:flutter/material.dart';
import 'package:sampleproject/myadditional_folder/constants.dart';
import 'package:connectivity/connectivity.dart';

class myCustomButton extends StatelessWidget {
  final String text;
  // final IconData icon;
  var toClass;
  var Fun;

  myCustomButton({
    required this.text,
    required this.toClass,
    this.Fun,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return ElevatedButton(
      onPressed: () {
        Fun();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => toClass),
        );
      },
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: myOtherFont,
        ),
      ),
      style: ElevatedButton.styleFrom(
          shadowColor: Colors.black,
          elevation: 3,
          primary: myMainColor,
          fixedSize: Size(screenWidth, screenWidth * 0.03),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
    );
  }
}
