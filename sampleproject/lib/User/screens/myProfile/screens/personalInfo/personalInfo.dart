import 'package:flutter/material.dart';
import 'package:sampleproject/User/screens/myProfile/screens/personalInfo/widgets/personalInfo_body.dart';
import 'package:sampleproject/myadditional_folder/constants.dart';

class personalInfoClass extends StatelessWidget {
  const personalInfoClass({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 245, 245),
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
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: const Text(
          "المعلومات الشخصية",
          style: TextStyle(
              fontFamily: "ALMARAI", color: myMainColor, fontSize: 18),
        ),
      ),
      body: personalInfoBody(),
    );
  }
}
