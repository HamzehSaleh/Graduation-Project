import 'package:flutter/material.dart';
import 'package:sampleproject/APIs/fetchData.dart';
import 'package:sampleproject/bar/buttomNavBar.dart';
import 'package:sampleproject/features/splash/presentation/widgets/splash_body.dart';
import 'dart:async';

import 'package:sampleproject/features/splash/presentation/Auth/presentation/pages/login/loginpage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: splashClass(),
    );
  }
}

class splashClass extends StatefulWidget {
  const splashClass({Key? key}) : super(key: key);

  @override
  State<splashClass> createState() => _splashClassState();
}

class _splashClassState extends State<splashClass> {

  @override
  void initState() {
    super.initState();
    _navigatetohome();
  }

  _navigatetohome() async {
    await Future.delayed(Duration(milliseconds: 3000), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => loginPageClass()));
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: spalshBody(),
    );
  }
}
