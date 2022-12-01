import 'package:flutter/material.dart';
import 'package:sampleproject/User/screens/mainScreen/serviceCards/myCalc_Folder/myCalc_body.dart';
import 'package:sampleproject/User/screens/mainScreen/serviceCards/newSub_Folder/newSub_body.dart';

import 'package:sampleproject/myadditional_folder/constants.dart';

class newSubClass extends StatelessWidget {
  const newSubClass({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: myMainColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: const Text(
          "طلب اشتراك جديد",
          style: TextStyle(
              fontFamily: "ALMARAI", color: myMainColor, fontSize: 18),
        ),
      ),
      backgroundColor: myBackColor,
      body: newSubBody(),
    );
  }
}
