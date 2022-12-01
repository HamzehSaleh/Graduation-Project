import 'package:flutter/material.dart';
import 'package:sampleproject/features/splash/presentation/Auth/presentation/pages/login/widgets/login_body.dart';

// ignore: camel_case_types
class loginPageClass extends StatelessWidget {
  const loginPageClass({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      //  resizeToAvoidBottomInset: false,
      body: loginBody(),
    );
  }
}
