import 'package:flutter/material.dart';

import 'package:sampleproject/Employees/Screens/chargingPoints_Employee.dart';
import 'package:sampleproject/Employees/Screens/problems_Employee.dart';
import 'package:sampleproject/Employees/Screens/profile_Employee.dart';

import 'package:sampleproject/Employees/Screens/users_body_Employee.dart';
import 'package:sampleproject/myadditional_folder/constants.dart';

import '../../User/screens/mainScreen/mainScreen.dart';
import '../../User/screens/mainScreen/widgets/user_noification.dart';
import 'consumption_Employee.dart';
import 'enterConsumption_Employee.dart';
import 'notifications_Employee.dart';
import 'notifications_body_Employee.dart';
import 'sendNotification_Emplyee.dart';
import 'subReq_Employee.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: mainEmployeeClass(),
    );
  }
}

// ignore: camel_case_types
class mainEmployeeClass extends StatefulWidget {
  const mainEmployeeClass({Key? key}) : super(key: key);

  @override
  State<mainEmployeeClass> createState() => _mainEmployeeClassState();
}

class _mainEmployeeClassState extends State<mainEmployeeClass> {
  @override
  Widget build(BuildContext context) {
    // DateTime now = DateTime.now();
    // print(now.hour.toString() +
    //     ":" +
    //     now.minute.toString() +
    //     ":" +
    //     now.second.toString());

    //if (now.hour.toString() == "13") {
    //  title_List_Employee.add("تنبيه من احتمال ارتفاع الاحمال");
    //  body_List_Employee.add(
    //      "حسب ملف الاستهلاك المرفق تم اكتشاف ان الاشهر الثلاثة القادمة هي الاعلى استهلاك خلال السنة يرجى ارسال تنبيهات للمواطنين للحث على الترشيد");
    //  notificationsNum_Employee++;

    //  //  setState(() {});
    //}

    // print("month" + now.month.toString());
    // if (now.month == 1 + minMonth) {
    //   print("هذا هو الشهر المطلوب");

    //   title_List_Employee.add("تنبيه من احتمال ارتفاع الاحمال");
    //   body_List_Employee.add(
    //       "حسب ملف الاستهلاك المرفق تم اكتشاف ان الاشهر الثلاثة القادمة هي الاعلى استهلاك خلال السنة يرجى ارسال تنبيهات للمواطنين للحث على الترشيد");
    //   notificationsNum_Employee++;

    //   setState(() {});
    // }

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final double appBarHeight = AppBar().preferredSize.height;

    return DefaultTabController(
      length: 8,
      child: Scaffold(
          backgroundColor: myBackColor,
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
                Navigator.pop(context);
              },
            ),
            centerTitle: true,
            title: const Text(
              "لوحة تحكم الموظف",
              style: TextStyle(
                  fontFamily: "ALMARAI", color: myMainColor, fontSize: 18),
            ),
            bottom: TabBar(
                //indicatorColor: myMainColor,
                unselectedLabelColor: myGray,
                labelColor: myMainColor,
                //enableFeedback: true,
                isScrollable: true,
                tabs: [
                  CustomTab("الملف الشخصي", Icons.people_alt_outlined),
                  CustomTab("المواطنين", Icons.groups_rounded),
                  CustomTab("الشكاوي", Icons.sync_problem),
                  CustomTab("مراكز الشحن", Icons.apartment),
                  CustomTab("طلبات الاشتراك", Icons.list_alt),
                  CustomTab("ارسال اشعار", Icons.notification_add_outlined),
                  CustomTab("ادخال الاستهلاك", Icons.note_add),
                  CustomTab("احصائيات", Icons.equalizer),
                ]),
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
                                      builder: (context) =>
                                          employee_noificationClass()),
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
                        "$notificationsNum_Employee",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      )),
                ],
              ),
            ],
          ),
          resizeToAvoidBottomInset: false,
          body: TabBarView(
            children: [
              profile_body_Employee(),
              usersClass_body_employee(),
              problems_body_Employee(),
              chargingPoints_body_admin(),
              subReq_body_Employee(),
              sendNotification_employee(),
              enterConsumption_employee(),
              consumption_employee(),
            ],
          )),
    );
  }

  Tab CustomTab(final String text, final IconData icon) {
    return Tab(
      child: Text(
        text,
        style: TextStyle(fontFamily: myOtherFont, fontSize: 10),
      ),
      icon: Icon(icon),
    );
  }
}
