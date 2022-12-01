// ignore_for_file: unnecessary_const

import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:sampleproject/User/screens/mainScreen/serviceCards/myCalc_Folder/widgets/addDevice.dart';

import 'package:sampleproject/myadditional_folder/constants.dart';

import 'widgets/kitchen_Grid.dart';
import 'package:giffy_dialog/giffy_dialog.dart';

import 'widgets/living_Grid.dart';
import 'widgets/other_Grid.dart';

const List<Key> keys = [
  Key("Network"),
  Key("NetworkDialog"),
  Key("Flare"),
  Key("FlareDialog"),
  Key("Asset"),
  Key("AssetDialog")
];

double all_cons = 0;

class myCalcBody extends StatefulWidget {
  myCalcBody({Key? key}) : super(key: key);

  @override
  _myCalcBodyState createState() => _myCalcBodyState();
}

class _myCalcBodyState extends State<myCalcBody> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Stack(
        children: [
          SafeArea(
            child: DefaultTabController(
              length: 3,
              child: Column(
                children: <Widget>[
                  ButtonsTabBar(
                    backgroundColor: myMainColor,
                    unselectedBackgroundColor: Colors.grey[300],
                    unselectedLabelStyle: const TextStyle(
                        color: Colors.black,
                        fontFamily: myOtherFont,
                        fontSize: 12),
                    labelStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: myOtherFont,
                        fontSize: 12),
                    tabs: const [
                      Tab(
                        icon: Icon(Icons.microwave),
                        text: " أجهزة المطبخ",
                      ),
                      Tab(
                        icon: Icon(Icons.desktop_windows),
                        text: "أجهزة غرفة الجلوس",
                      ),
                      Tab(
                        text: "أجهزة اخرى",
                        icon: Icon(Icons.devices_other),
                      ),
                      //Tab(
                      //  icon: Icon(Icons.playlist_add),
                      //  text: " اضافة جهاز",
                      //),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: <Widget>[
                        //Center(
                        //  child: Icon(Icons.directions_car),
                        //),
                        myKitchenGrid(),
                        myLivingGrid(),
                        myOtherGrid(),
                        //addDevice(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // SubNumber_Dialog(),
        ],
      ),
    );
  }
}

class SubNumber_Dialog extends StatelessWidget {
  const SubNumber_Dialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AssetGiffyDialog(
      buttonCancelText: const Text(
        "الغاء",
        style: const TextStyle(fontFamily: myOtherFont, color: Colors.white),
      ),
      buttonOkText: const Text(
        "ادخال رقم الاشتراك",
        style: const TextStyle(fontFamily: myOtherFont, color: Colors.white),
      ),
      key: keys[5],
      image: Image.network(
        dialog_error,
        fit: BoxFit.cover,
      ),
      title: const Text(
        'خطأ في رقم الاشتراك',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.w600,
            fontFamily: myOtherFont),
      ),
      entryAnimation: EntryAnimation.BOTTOM_RIGHT,
      description: const Text(
        'لم يتم العثور على رقم الاشتراك الخاص بك، لا تستطيع الدخول الى هذه الصفحة قبل ادخال رقم الاشتراك',
        textAlign: TextAlign.center,
        style: TextStyle(fontFamily: myOtherFont),
      ),
      onOkButtonPressed: () {
        Navigator.of(context).pop();
      },
    );
  }
}
