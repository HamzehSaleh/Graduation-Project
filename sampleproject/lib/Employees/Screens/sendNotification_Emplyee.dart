import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:sampleproject/Custom_widgets/CustomTextField.dart';

import 'package:sampleproject/myadditional_folder/constants.dart';
import 'package:http/http.dart' as http;

import '../../User/screens/mainScreen/mainScreen.dart';
import '../../User/screens/mainScreen/serviceCards/myConsumption_Folder/myConsumption.dart';
import '../../User/screens/mainScreen/widgets/notification_body.dart';

class sendNotification_employee extends StatefulWidget {
  const sendNotification_employee({Key? key}) : super(key: key);

  @override
  State<sendNotification_employee> createState() =>
      _sendNotification_employeeState();
}

var serverToken =
    "AAAAfEJLHTk:APA91bGXZ6ux_SEvLmlko8ZQn-52T7s3NwJbs0sX2ECNdfPa9AhuRZFuL_9g9QCW4fyFciEUwQbpWZlvRVAtYhrLsNQCYcFCugUXs_9Ba87HTyRVZs6UVlTJ_ab1WCktJgiSXwntQNYn";
sendNotfiy(String title, String body, String id) async {
  await http.post(
    Uri.parse("https://fcm.googleapis.com/fcm/send"),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'key=$serverToken',
    },
    body: jsonEncode(
      <String, dynamic>{
        'notification': <String, dynamic>{
          'body': body.toString(),
          'title': title.toString()
        },
        'priority': 'high',
        'data': <String, dynamic>{
          'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          //'id': id.toString(),
          'name': 'hamzeh',
          'lastname': 'saleh',
          'status': 'done'
        },
        'to':
            //"e2otq0vIQdyydnPXPHWC0J:APA91bEBYMk8VbVjhGNMv19MhXLGreekTCK4Wvr7lDqBgIm8mcreLfx0Jo2xZnSLi9P9mJrnTropFzEjUnM9MFDMe1Ttyao9-xk1QJ6xZgFELOmn-leOjByWVD82kN6fcBkMrZdMG9DL"
            "dBaDZUWSTKefSZP9psEkP7:APA91bGldTqxypKTnpyfd-N1MCNlIYRZbCpukWbMG5DoHbCn4tct5YYkrr4QZ66Dw2tVwca94J9HqpiBXC9Y22wE51AQiHNyASy5_N59SlOXWMb_Fa0-R1qG5ImA8b2yRhw3zqIZf-l5"
        // "cF1XT8HaROqvRU5Y4c0Div:APA91bHYvWxUTTezetkqlmgex3zqM_UWXH-k636wDdDpcLq7zaugcA4HoyZtVqByNuNf5-6QtJgmxkQjLTSfC-QZJv2g7SfE2y_hdvo7uiQjwjdJ8uKzooD0sOjCuHA33_FqEwSE6oze",
        //await FirebaseMessaging.instance.getToken()
      },
    ),
  );
}

class _sendNotification_employeeState extends State<sendNotification_employee> {
  late TextEditingController NotificationTitle;
  late TextEditingController NotificationBody;

  getMessage() {
    FirebaseMessaging.onMessage.listen((message) {
      title_List.add(message.notification!.title.toString());
      body_List.add(message.notification!.body.toString());
      // setState(() {});

      print(message.data['name'] + " ++ listened");
      // print(title_List.toString());
      print(title_List.length);
    });

    //notificationsNum++;
    //setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    NotificationTitle = new TextEditingController();
    NotificationBody = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "عزيزي الموظف\nمن هنا تستطيع ارسال اشعار الى جميع المستخدمين.",
                  style: TextStyle(
                    fontFamily: myOtherFont,
                    color: darkBlue,
                  ),
                ),
                const Spacer(
                  flex: 1,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      myCustomTextField(
                          controller: NotificationTitle,
                          icon: Icons.border_color,
                          hint: "أدخل عنوان الاشعار"),
                      const SizedBox(
                        height: 20,
                      ),
                      myCustomTextField(
                          controller: NotificationBody,
                          icon: Icons.textsms,
                          hint: "أدخل نص الاشعار"),
                    ],
                  ),
                ),
                const Spacer(
                  flex: 10,
                ),
                ElevatedButton(
                  onPressed: () async {
                    print(NotificationBody.text);
                    print(NotificationTitle.text);

                    await sendNotfiy(
                        NotificationTitle.text, NotificationBody.text, "3");
                    getMessage();
                    ++notificationsNum;
                    setState(() {
                      // _clearText();
                    });
                  },
                  child: Text(
                    "ارسال الاشعار",
                    style: const TextStyle(
                      fontFamily: myOtherFont,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                      shadowColor: Colors.black,
                      elevation: 3,
                      primary: myMainColor,
                      fixedSize: Size(screenWidth, screenWidth * 0.03),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),

                const SizedBox(
                  height: 20,
                ),
                //const Spacer(
                //  flex: 10,
                //),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _clearText() {
    NotificationTitle.text = "";
    NotificationBody.text = "";
  }
}
