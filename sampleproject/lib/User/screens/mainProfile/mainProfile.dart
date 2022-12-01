import 'package:flutter/material.dart';
import 'package:sampleproject/User/screens/mainProfile/widgets/mianProfile_body.dart';
import 'package:sampleproject/myadditional_folder/constants.dart';

import '../../../bar/buttomNavBar.dart';

class mainProfileClass extends StatelessWidget {
  final int val;

  const mainProfileClass({this.val = 0});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myBackColor,
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: myMainColor,
          ),
          onPressed: () {
            // 0 -> false
            // 1 -> true
            if (val == 1) Navigator.pop(context);
            if (val == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => buttomNavBarClass()),
              );
            }
          },
        ),
        centerTitle: true,
        title: const Text(
          "الملف الشخصي",
          style: TextStyle(
              fontFamily: "ALMARAI", color: myMainColor, fontSize: 18),
        ),
      ),
      body: mainProfileBody(),
    );
  }
}
