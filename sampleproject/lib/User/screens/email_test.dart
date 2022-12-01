import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sampleproject/Custom_widgets/CustomButton.dart';
import 'package:sampleproject/features/splash/presentation/Auth/presentation/pages/login/loginpage.dart';
import 'package:sampleproject/features/splash/presentation/Auth/presentation/pages/login/widgets/login_body.dart';

import '../../Custom_widgets/CustomTextField.dart';
import '../../myadditional_folder/constants.dart';
import 'package:http/http.dart';
import 'dart:convert';

class sendEmail extends StatefulWidget {
  const sendEmail({Key? key}) : super(key: key);

  @override
  State<sendEmail> createState() => _sendEmailState();
}

final nameController = TextEditingController();

//Future sendEmailFuture() async {
//  final url = Uri.parse("https://api.emailjs.com/api/v1.0/email/send");
//  const serviceId = "service_yqw6vw2";
//  const templateId = "template_lrzfgui";
//  const userId = "ujmyixgelFKHEAJ6BkDd0";

//  final Response = await http.post(url,
//      headers: {'Content-Type': 'application/json'},
//      body: json.encode({
//        "service_id": serviceId,
//        "template_id": templateId,
//        "user_id": userId,
//        "template_params": {
//          "name": nameController.text,
//        }
//      }));
//}

class _sendEmailState extends State<sendEmail> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            myCustomTextField(
              hint: "أدخل البريد الالكتروني",
              icon: Icons.email,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => loginPageClass()),
                );
              },
              child: Text(
                "text",
                style: const TextStyle(
                  fontFamily: myOtherFont,
                ),
              ),
              style: ElevatedButton.styleFrom(
                  shadowColor: Colors.black,
                  elevation: 3,
                  primary: myMainColor,
                  fixedSize: Size(screenWidth, screenWidth * 0.1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
            )
          ],
        ),
      ),
    );
  }
}
