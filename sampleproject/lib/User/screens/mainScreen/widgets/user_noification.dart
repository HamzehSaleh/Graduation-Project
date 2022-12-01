import 'package:flutter/material.dart';
import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';
import 'package:sampleproject/User/screens/mainScreen/widgets/mainScreen_body.dart';

import 'package:sampleproject/myadditional_folder/constants.dart';

import 'package:sampleproject/bar/navbar.dart';

import '../../../../bar/buttomNavBar.dart';
import '../mainScreen.dart';
import 'notification_body.dart';

// ignore: camel_case_types
class user_noificationClass extends StatefulWidget {
  const user_noificationClass({Key? key}) : super(key: key);

  @override
  State<user_noificationClass> createState() => _user_noificationClassState();
}

class _user_noificationClassState extends State<user_noificationClass> {
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
            notificationsNum = 0;
            setState(() {});
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => buttomNavBarClass()),
            );
          },
        ),
        centerTitle: true,
        title: const Text(
          "الاشعارات",
          style: TextStyle(
              fontFamily: "ALMARAI", color: myMainColor, fontSize: 18),
        ),
      ),
      body: userNotification_body(),
    );
  }
}
