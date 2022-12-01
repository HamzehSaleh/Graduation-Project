import 'package:flutter/material.dart';
import 'package:sampleproject/User/screens/myProfile/screens/Change%20Password/widgets/changePassClass_body.dart';
import 'package:sampleproject/User/screens/myProfile/screens/personalInfo/widgets/personalInfo_body.dart';
import 'package:sampleproject/myadditional_folder/constants.dart';

class changePassClass extends StatelessWidget {
  const changePassClass({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
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
          "تغيير كلمة المرور",
          style: TextStyle(
              fontFamily: "ALMARAI", color: myMainColor, fontSize: 18),
        ),
      ),
      backgroundColor: myBackColor,
      body: changePassBody(),
    );
  }
}
