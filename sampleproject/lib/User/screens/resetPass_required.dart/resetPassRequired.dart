import 'package:flutter/material.dart';

import 'package:sampleproject/myadditional_folder/constants.dart';

import 'widgets/resetPassRequired_body.dart';

class resetPassRequired_Class extends StatelessWidget {
  const resetPassRequired_Class({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: myBackColor,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "تغيير كلمة المرور",
          style: TextStyle(
              fontFamily: "ALMARAI", color: myMainColor, fontSize: 18),
        ),
      ),
      backgroundColor: myBackColor,
      body: resetPassRequired_Body(),
    );
  }
}
