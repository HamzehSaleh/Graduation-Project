import 'package:flutter/material.dart';
import 'package:sampleproject/myadditional_folder/constants.dart';

class CustomFlatButton_Icon extends StatelessWidget {
  var nextClass;
  final String text;
  final IconData icon;
  bool fun;
  var funExecute;
  Color color;

  CustomFlatButton_Icon(
      {required this.text,
      required this.icon,
      this.nextClass,
      this.fun = false,
      this.funExecute,
      this.color = myMainColor});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: Colors.transparent,
      splashColor: Colors.black26,
      onPressed: () {
        if (fun == false) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => nextClass),
          );
        } else if (fun == true) {
          funExecute;
        }
      },
      child: Align(
          alignment: Alignment.topRight,
          child: Row(
            children: [
              Icon(
                icon,
                color: myMainColor,
              ),
              const Spacer(),
              Text(
                text,
                //textAlign: TextAlign.left,
                style: TextStyle(
                  color: color,
                  fontFamily: 'ALMARAI',
                  fontSize: 13,
                ),
              ),
              const Spacer(flex: 15),
            ],
          )),
    );
  }
}
