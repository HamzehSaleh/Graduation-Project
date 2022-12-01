import 'dart:convert';
import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:sampleproject/User/screens/mainScreen/serviceCards/myCalc_Folder/myCalc_body.dart';
import 'package:sampleproject/User/screens/mainScreen/serviceCards/myCalc_Folder/widgets/living_Grid.dart';

import 'package:sampleproject/myadditional_folder/constants.dart';

import '../../../../../APIs/fetchData.dart';
import '../../../../../bar/buttomNavBar.dart';
import '../../mainScreen.dart';
import '../../widgets/notification_body.dart';
import 'widgets/kitchen_Grid.dart';
import 'widgets/other_Grid.dart';

class myCalcClass extends StatefulWidget {
  const myCalcClass({Key? key}) : super(key: key);

  @override
  State<myCalcClass> createState() => _myCalcClassState();
}

class _myCalcClassState extends State<myCalcClass> {
  FetchData _fetchData = FetchData();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final double appBarHeight = AppBar().preferredSize.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: myMainColor),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: myMainColor,
          ),
          onPressed: () {
            // resultDialog(
            //     context, living_result + kitchen_result + other_result);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => buttomNavBarClass()),
            );
            // Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: const Text(
          "حاسبتي",
          style: TextStyle(
              fontFamily: "ALMARAI", color: myMainColor, fontSize: 18),
        ),
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
                            //Navigator.push(
                            //  context,
                            //  MaterialPageRoute(
                            //      builder: (context) =>
                            //          employee_noificationClass()),
                            //);

                            resultDialog(context,
                                living_result + kitchen_result + other_result);
                          },
                          icon: Icon(
                            Icons.bookmarks,
                            size: 24,
                          )),
                      const Spacer(),
                    ],
                  )),
                ],
              ),
            ],
          ),
        ],
      ),
      backgroundColor: Color(0xffEFECEC),
      body: myCalcBody(),
    );
  }

  Future<dynamic> resultDialog(BuildContext context, double result) {
    return showDialog(
        context: context,
        builder: (_) => AssetGiffyDialog(
              buttonCancelText: Text(
                "الغاء",
                style: TextStyle(fontFamily: myOtherFont, color: Colors.white),
              ),
              buttonOkText: Text(
                "موافق",
                style: TextStyle(fontFamily: myOtherFont, color: Colors.white),
              ),
              key: keys[5],
              image: Image.network(
                myCalc,
                fit: BoxFit.cover,
              ),
              title: Text(
                'معدل استهلاكك اليومي',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w600,
                    fontFamily: myOtherFont),
              ),
              entryAnimation: EntryAnimation.BOTTOM_RIGHT,
              description: Text(
                'عزيزي المواطن معدل استهلاكك اليومي هو ${result * 0.8 / 1000}  كيلو واط وهو يزداد بشكل ملحوظ الرجاء الترشيد في استهلاكك حتى لا نضطر لقطع التيار الكهربائي في اوقات الذروة وشكرا',
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: myOtherFont),
              ),
              onCancelButtonPressed: () {
                Navigator.of(context).pop();
              },
              onOkButtonPressed: () {
                _fetchData.changeUserData("cunsump", result * 0.024);

                Random random = Random();
                var min = 1;
                var max = 4;

                int randomNumber = min + random.nextInt(max - min);

                switch (randomNumber) {
                  case 1:
                    {
                      title_List.add("ابلاغ بارتفاع الاستهلاك");
                      body_List.add(
                        "عزيزي المواطن استهلاكك مرتفع نسبيا يرجى الترشيد في الاستهلاك لتجنب القطع",
                      );
                    }
                    break;

                  case 2:
                    {
                      title_List.add("تحذير ");
                      body_List.add(
                        "عزيزي المواطن استهلاكك مرتفع نسبيا يرجى الترشيد في الاستهلاك لتجنب القطع",
                      );
                    }
                    break;
                  case 3:
                    {
                      title_List.add("نصائح وارشادات");
                      body_List.add(
                        "عزيزي المواطن استهلاكك مرتفع نسبيا يرجى الترشيد في الاستهلاك لتجنب القطع",
                      );
                    }
                    break;

                  default:
                    {
                      title_List.add(" 2نصائح وارشادات");
                      body_List.add(
                        "عزيزي المواطن استهلاكك مرتفع نسبيا يرجى الترشيد في الاستهلاك لتجنب القطع",
                      );
                    }
                    break;
                }

                notificationsNum++;
                setState(() {});
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => buttomNavBarClass()),
                );
              },
            ));
  }
}
