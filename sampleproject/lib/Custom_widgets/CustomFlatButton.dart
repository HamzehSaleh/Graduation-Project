import 'package:flutter/material.dart';
import 'package:sampleproject/myadditional_folder/constants.dart';

class CustomFlatButton extends StatelessWidget {
  var nextClass;
  final String text;
  double fontSize;
  var Fun;

  CustomFlatButton(
      {required this.text,
      required this.nextClass,
      this.fontSize = 13,
      this.Fun});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: Colors.transparent,
      splashColor: Colors.black26,
      onPressed: () {
        Fun();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => nextClass),
        );
      },
      child: Align(
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Text(
                text,
                //textAlign: TextAlign.left,
                style: TextStyle(
                  color: myMainColor,
                  fontFamily: 'ALMARAI',
                  fontSize: fontSize,
                ),
              ),
            ],
          )),
    );
  }
}
