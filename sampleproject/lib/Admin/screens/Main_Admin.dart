import 'package:flutter/material.dart';
import 'package:sampleproject/Admin/screens/Add%20Employee/widgets/addEmployee_body.dart';
import 'package:sampleproject/Admin/screens/Rate/rate_Admin.dart';
import 'package:sampleproject/Admin/screens/Employees/Employees_body_Admin.dart';
import 'package:sampleproject/myadditional_folder/constants.dart';

import 'changePass/changePass.dart';
import 'users_Admin/users_Admin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: usersClass(),
    );
  }
}

// ignore: camel_case_types
class usersClass extends StatefulWidget {
  const usersClass({Key? key}) : super(key: key);

  @override
  State<usersClass> createState() => _usersClassState();
}

class _usersClassState extends State<usersClass> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return DefaultTabController(
      length: 5,
      child: Scaffold(
          backgroundColor: myBackColor,
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
              "لوحة تحكم الادمن",
              style: TextStyle(
                  fontFamily: "ALMARAI", color: myMainColor, fontSize: 18),
            ),
            bottom: TabBar(
                //indicatorColor: myMainColor,
                unselectedLabelColor: myGray,
                labelColor: myMainColor,
                isScrollable: true,
                tabs: [
                  CustomTab("اضافة موظف", Icons.person_add),
                  CustomTab("الموظفين", Icons.engineering_rounded),
                  CustomTab("المواطنين", Icons.groups_rounded),
                  CustomTab("التقييم", Icons.hotel_class),
                  CustomTab("تغيير كلمة المرور", Icons.vpn_key),
                ]),
          ),
          // resizeToAvoidBottomInset: false,
          body: TabBarView(
            children: [
              addEmployee_body(),
              employeesClass_body_admin(),
              users_Admin(),
              rate_body_admin(),
              changePass(),
            ],
          )),
    );
  }

  Tab CustomTab(final String text, final IconData icon) {
    return Tab(
      child: Text(
        text,
        style: TextStyle(fontFamily: myOtherFont, fontSize: 9),
      ),
      icon: Icon(icon),
    );
  }
}
