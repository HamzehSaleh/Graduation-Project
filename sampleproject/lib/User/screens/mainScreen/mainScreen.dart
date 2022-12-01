import 'package:flutter/material.dart';
import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';
import 'package:sampleproject/User/screens/mainScreen/widgets/mainScreen_body.dart';

import 'package:sampleproject/myadditional_folder/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:sampleproject/bar/navbar.dart';

import 'widgets/notification_body.dart';
import 'widgets/user_noification.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: mainScreenClass(),
    );
  }
}

int notificationsNum = 0;

// ignore: camel_case_types
class mainScreenClass extends StatefulWidget {
  const mainScreenClass({Key? key}) : super(key: key);

  @override
  State<mainScreenClass> createState() => _mainScreenClassState();
}

class _mainScreenClassState extends State<mainScreenClass> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: myBackColor,
      drawer: navBar(),
      appBar: appBar(context, screenHeight),
      body: mainScreenBody(),
    );
  }

  AppBar appBar(BuildContext context, double screenHeight) {
    final double appBarHeight = AppBar().preferredSize.height;

    return AppBar(
      iconTheme: IconThemeData(color: myMainColor),
      centerTitle: true,
      title: const Text(
        "كهربائي",
        style: TextStyle(
            fontFamily: myLogoFont,
            fontSize: logoFontSize_AppBar,
            color: myMainColor),
      ),
      backgroundColor: Colors.white, // 1
      //  elevation: 0
      actions: [
        Stack(
          children: [
            Column(
              children: [
                Expanded(
                    child: Column(
                  children: [
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => user_noificationClass()),
                          );
                        },
                        icon: Icon(
                          Icons.notifications_rounded,
                          size: 28,
                        )),
                    const Spacer(),
                  ],
                )),
              ],
            ),
            Padding(
                padding: EdgeInsets.symmetric(
                    vertical: (appBarHeight / 2) - 8, horizontal: 8),
                child: Container(
                  height: 17,
                  width: 17,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.red,
                    ),
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                )),
            Padding(
                padding: EdgeInsets.symmetric(
                    vertical: (appBarHeight / 2) - 6, horizontal: 12),
                child: Text(
                  "$notificationsNum",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                )),
          ],
        ),
      ],
    );
  }
}
