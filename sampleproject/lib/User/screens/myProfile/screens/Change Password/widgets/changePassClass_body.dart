import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sampleproject/APIs/models/userModel.dart';
import 'package:sampleproject/Custom_widgets/CustomButton.dart';
import 'package:sampleproject/Custom_widgets/CustomCoverAvatarProfile.dart';
import 'package:sampleproject/Custom_widgets/CustomPasswordField.dart';

import '../../../../../../APIs/fetchData.dart';
import '../../../../mainScreen/widgets/mainScreen_body.dart';
import 'package:http/http.dart' as http;

class changePassBody extends StatefulWidget {
  const changePassBody({Key? key}) : super(key: key);

  @override
  State<changePassBody> createState() => _changePassBodyState();
}

class _changePassBodyState extends State<changePassBody> {
  static String myId = "";

  FetchData _fetchData = FetchData();
  late TextEditingController lastPass_controller;
  late TextEditingController newPass_controller;
  late TextEditingController rePass_controller;

  @override
  void initState() {
    super.initState();
    _fetchData.fetchMyAccount();
    lastPass_controller = TextEditingController();
    newPass_controller = TextEditingController();
    rePass_controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: Column(
                children: [
                  userData(),
                  Spacer(),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: const [
                              //background color of box
                              BoxShadow(
                                //color: Colors.white,
                                color: Color.fromARGB(77, 211, 206, 206),
                                blurRadius: 20.0, // soften the shadow
                                spreadRadius: 1.0, //extend the shadow
                                offset: Offset(
                                  2.0, // Move to right 10  horizontally
                                  2.0, // Move to bottom 10 Vertically
                                ),
                              )
                            ],
                            borderRadius: BorderRadius.circular(15),
                            color: Color(0xffFBFDFF),
                          ),
                          width: screenWidth * 0.9,
                          height: screenHeight * 0.4,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Column(
                              children: [
                                Spacer(
                                  flex: 1,
                                ),
                                myCustomPasswordField(
                                  controller: lastPass_controller,
                                  hint: "أدخل كلمة المرور الحالية",
                                ),
                                Spacer(
                                  flex: 1,
                                ),
                                myCustomPasswordField(
                                  controller: newPass_controller,
                                  hint: "أدخل كلمة المرور الجديدة",
                                ),
                                Spacer(
                                  flex: 1,
                                ),
                                myCustomPasswordField(
                                  controller: rePass_controller,
                                  hint: "أعد ادخال كلمة المرور الجديدة",
                                ),
                                Spacer(
                                  flex: 1,
                                ),
                                myCustomButton(
                                  text: "حفظ ومتابعة",
                                  Fun: changePass,
                                  toClass: mainScreenBody(),
                                ),
                                Spacer(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Spacer(
                    flex: 3,
                  ),
                ],
              ))
            ],
          ),
        ),
      ],
    );
  }

  Widget userData() {
    return FutureBuilder(
        future: _fetchData.fetchMyAccount(),
        builder: (context, snapchot) {
          userModel data = snapchot.data as userModel;
          data == null ? myId = "" : myId = data.id;
          return snapchot.data == null
              ? Text("جاري التحميل...")
              : customCoverAvatarProfile(
                  screenWidth: MediaQuery.of(context).size.width,
                  screenHeight: MediaQuery.of(context).size.height,
                  name: data.Name.toString(),
                  email: data.Email.toString(),
                );
        });
  }

  Future<void> changePass() async {
    print(myId);

    if (newPass_controller.text.trim().isEmpty ||
        rePass_controller.text.trim().isEmpty ||
        lastPass_controller.text.trim().isEmpty) {
      print("empty fields");
      return;
    } else if (newPass_controller.text.trim() !=
        rePass_controller.text.trim()) {
      print("check your new password");
      return;
    } else {
      _fetchData.changeUserPass(newPass_controller.text);
      showSnackBar();
    }
  }

  SnackBar showSnackBar() {
    return SnackBar(
      content: const Text("تم تغيير كلمة المرور بنجاح"),
      action: SnackBarAction(
        label: 'رجوع',
        onPressed: () {},
      ),
    );
  }
}
