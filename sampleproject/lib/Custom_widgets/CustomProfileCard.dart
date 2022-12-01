import 'package:flutter/material.dart';
import 'package:sampleproject/bar/buttomNavBar.dart';
import 'package:sampleproject/myadditional_folder/constants.dart';

class customProfileCard extends StatelessWidget {
  final IconData icon;
  final String text;
  var myFunction;
  final String user_data;

  customProfileCard(
      {required this.icon,
      required this.text,
      this.myFunction,
      this.user_data = ""});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Container(
        height: 70,
        child: TextButton(
          onPressed: () {
            //   myFunction;
          },
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.white)),
          child: Row(
            children: <Widget>[
              Icon(
                this.icon,
                color: myGray,
              ),
              const SizedBox(
                width: 25,
              ),
              Text(
                this.text,
                style: TextStyle(color: myGray, fontFamily: myOtherFont),
              ),
              const Spacer(),
              Text(
                user_data,
                style: TextStyle(fontSize: 12, color: TFmyGray),
              ),
              const Spacer(),
              const Icon(
                Icons.arrow_forward_ios,
                color: myGray,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
