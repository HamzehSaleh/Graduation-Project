import 'package:flutter/material.dart';

import '../../../../myadditional_folder/constants.dart';

class employeeNotification_body extends StatefulWidget {
  const employeeNotification_body({Key? key}) : super(key: key);

  @override
  State<employeeNotification_body> createState() =>
      _employeeNotification_bodyState();
}

late final List<String> title_List_Employee = [];
late final List<String> body_List_Employee = [];

class _employeeNotification_bodyState extends State<employeeNotification_body> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: title_List_Employee.length,
              itemBuilder: (BuildContext context, int index) {
                return notificationCard(screenHeight, screenWidth,
                    title_List_Employee[index], body_List_Employee[index]);
              }),
        ],
      ),
    );
  }

  Widget notificationCard(
      double screenHeight, double screenWidth, String title, String body) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
      child: Container(
        height: screenHeight * 0.13,
        width: screenWidth,
        color: Color.fromARGB(194, 230, 226, 226),
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      Flexible(
                        child: Text(
                          title,
                          style: style(14, FontWeight.bold),
                        ),
                      ),
                      const Spacer(
                        flex: 1,
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    Flexible(
                      child: Text(
                        body,
                        style: style(13, FontWeight.normal),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.05, horizontal: 3),
              child: Icon(
                Icons.fiber_manual_record,
                color: myMainColor,
                size: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextStyle style(
    double fontSize,
    FontWeight fontWeight,
  ) {
    return TextStyle(
        fontFamily: myOtherFont, fontSize: fontSize, fontWeight: fontWeight);
  }
}
