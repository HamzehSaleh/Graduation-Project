import 'package:flutter/material.dart';
import 'package:sampleproject/Employees/Screens/Main_Employee.dart';

import 'package:sampleproject/myadditional_folder/constants.dart';

import '../../../../bar/buttomNavBar.dart';
import 'notifications_body_Employee.dart';

// ignore: camel_case_types
class employee_noificationClass extends StatefulWidget {
  const employee_noificationClass({Key? key}) : super(key: key);

  @override
  State<employee_noificationClass> createState() =>
      _employee_noificationClassState();
}

int notificationsNum_Employee = 0;

class _employee_noificationClassState extends State<employee_noificationClass> {
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
            notificationsNum_Employee = 0;
            setState(() {});
            //Navigator.push(
            //  context,
            //  MaterialPageRoute(builder: (context) => mainEmployeeClass()),
            //);
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: const Text(
          "الاشعارات",
          style: TextStyle(
              fontFamily: "ALMARAI", color: myMainColor, fontSize: 18),
        ),
      ),
      body: employeeNotification_body(),
    );
  }
}
