import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sampleproject/myadditional_folder/constants.dart';

import '../../../bar/buttomNavBar.dart';
import 'widgets/myChargingPoints_body.dart';

class myChargingPointsClass extends StatefulWidget {
  myChargingPointsClass({Key? key}) : super(key: key);

  @override
  State<myChargingPointsClass> createState() => _myChargingPointsClassState();
}

class _myChargingPointsClassState extends State<myChargingPointsClass> {
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
            //Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => buttomNavBarClass()),
            );
          },
        ),
        centerTitle: true,
        title: const Text(
          "مراكز الشحن",
          style: TextStyle(
              fontFamily: "ALMARAI", color: myMainColor, fontSize: 18),
        ),
      ),
      backgroundColor: myBackColor,
      body: myChargingPointsBody(),
    );
  }
}
