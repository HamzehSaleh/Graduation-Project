import 'package:flutter/material.dart';
import 'package:sampleproject/myadditional_folder/constants.dart';

import '../../../../../bar/buttomNavBar.dart';
import 'widgets/whoUS_Body.dart';

class whoUS_Class extends StatelessWidget {
  const whoUS_Class({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: myMainColor,
          ),
          onPressed: () {
            //   Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => buttomNavBarClass()),
            );
          },
        ),
        centerTitle: true,
        title: const Text(
          "من نحن",
          style: TextStyle(
              fontFamily: "ALMARAI", color: myMainColor, fontSize: 18),
        ),
      ),
      backgroundColor: Colors.white,
      body: whoUS_Body(),
    );
  }
}
