import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:sampleproject/User/screens/mainProfile/mainProfile.dart';
import 'package:sampleproject/User/screens/mainScreen/mainScreen.dart';

import 'package:sampleproject/myadditional_folder/constants.dart';

import '../User/screens/ContactUS/contactUS_Main.dart';
import '../User/screens/mainScreen/serviceCards/myCalc_Folder/widgets/test.dart';
import '../User/screens/myProfile/screens/Who us/whoUs.dart';

class buttomNavBarClass extends StatefulWidget {
  const buttomNavBarClass({Key? key}) : super(key: key);

  @override
  _mainTestState createState() => _mainTestState();
}

class _mainTestState extends State<buttomNavBarClass> {
  int _selectedIndex = 0;
  PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          children: <Widget>[
            mainScreenClass(),
            mainProfileClass(),
            whoUS_Class(),
            mainContactUSClass(),
          ],
        ),
        bottomNavigationBar: BottomNavyBar(
          selectedIndex: _selectedIndex,
          showElevation: false,
          onItemSelected: (index) => setState(() {
            _selectedIndex = index;
            _pageController.animateToPage(index,
                duration: Duration(milliseconds: 300), curve: Curves.ease);
          }),
          items: [
            BottomNavyBarItem(
              icon: const Icon(Icons.apps),
              title: const Text(
                'الرئيسية',
                style: TextStyle(fontSize: 13),
              ),
              activeColor: myMainColor,
              inactiveColor: myMainColor,
            ),
            BottomNavyBarItem(
              icon: const Icon(Icons.people),
              title: const Text(
                'الملف الشخصي',
                style: TextStyle(fontSize: 13),
              ),
              activeColor: Colors.green,
              inactiveColor: Colors.green,
            ),
            BottomNavyBarItem(
              icon: const Icon(
                Icons.home_repair_service,
              ),
              title: const Text(
                'من نحن ؟',
                style: TextStyle(fontSize: 13),
              ),
              activeColor: Color.fromARGB(255, 115, 50, 199),
              inactiveColor: Color.fromARGB(255, 115, 50, 199),
            ),
            BottomNavyBarItem(
              icon: const Icon(
                Icons.support_agent,
              ),
              title: const Text(
                'اتصل بنا',
                style: TextStyle(fontSize: 13),
              ),
              activeColor: Colors.red,
              inactiveColor: Colors.red,
            ),
          ],
        ));
  }
}
