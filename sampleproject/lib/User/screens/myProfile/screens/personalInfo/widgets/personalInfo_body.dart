import 'package:flutter/material.dart';
import 'package:http/retry.dart';
import 'package:sampleproject/APIs/models/userModel.dart';
import 'package:sampleproject/Custom_widgets/CustomButton.dart';
import 'package:sampleproject/Custom_widgets/CustomCoverAvatarProfile.dart';
import 'package:sampleproject/Custom_widgets/CustomProfileCard.dart';
import 'package:sampleproject/bar/buttomNavBar.dart';

import 'package:sampleproject/myadditional_folder/constants.dart';

import '../../../../../../APIs/fetchData.dart';

class personalInfoBody extends StatefulWidget {
  const personalInfoBody({Key? key}) : super(key: key);
  @override
  State<personalInfoBody> createState() => _personalInfoBodyState();
}

class _personalInfoBodyState extends State<personalInfoBody> {
  FetchData _fetchData = FetchData();

  @override
  void initState() {
    super.initState();
    _fetchData.fetchMyAccount();
  }

  createAlertDialog(
      BuildContext context, String hint, String title, String img) {
    TextEditingController customController = new TextEditingController();

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              title,
              style: const TextStyle(fontFamily: myOtherFont, fontSize: 14),
            ),
            content: Container(
              height: 280,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(width: 200, child: Image.network(img)),
                          SizedBox(
                            height: 20,
                          ),
                          TextField(
                            controller: customController,
                            decoration: InputDecoration(
                              hintText: hint,
                              hintStyle: TextStyle(
                                  fontFamily: 'ALMARAI',
                                  fontSize: 15,
                                  color: TFmyGray),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              MaterialButton(
                elevation: 5.0,
                child: Text(
                  "حفظ",
                  style: const TextStyle(
                    fontFamily: myOtherFont,
                  ),
                ),
                onPressed: () {
                  switch (title) {
                    case "البريد الالكتروني":
                      {
                        _fetchData.changeUserData(
                            "email", customController.text);
                      }
                      break;
                    case "رقم الهاتف":
                      {
                        _fetchData.changeUserData(
                            "phoneNumber", customController.text);
                      }
                      break;
                  }
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return myData();
  }

  Padding CustomProfileCard_Details(IconData icon, String text,
      String user_data, BuildContext context, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: GestureDetector(
        onTap: () {
          if (text == "البريد الالكتروني") {
            createAlertDialog(context, "تعديل البريد الالكتروني",
                "البريد الالكتروني", checkEmail);
          } else if (text == "رقم الهاتف") {
            createAlertDialog(context, "تعديل رقم الهاتف", text, phoneNum);
          } else if (text == "رقم الهوية") {
            //createAlertDialog(context, "تعديل رقم الهوية", text);

          }
        },
        child: Container(
          color: Colors.white,
          height: 60,
          child: Column(
            children: [
              Expanded(
                child: Row(
                  children: <Widget>[
                    const SizedBox(
                      width: 10,
                    ),
                    Icon(
                      icon,
                      color: color,
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    Text(
                      text,
                      style: TextStyle(
                          color: myGray,
                          fontFamily: myOtherFont,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    Text(
                      user_data,
                      style: TextStyle(fontSize: 12, color: TFmyGray),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: myGray,
                      size: 15,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget myData() {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return FutureBuilder(
        future: _fetchData.fetchMyAccount(),
        builder: (context, snapchot) {
          userModel data = snapchot.data as userModel;

          return snapchot.data == null
              ? Text("جاري التحميل...")
              : Column(
                  children: [
                    Expanded(
                        child: Column(
                      children: [
                        customCoverAvatarProfile(
                            screenWidth: screenWidth,
                            screenHeight: screenHeight,
                            name: data.Name,
                            email: data.Email),
                        Spacer(),
                        CustomProfileCard_Details(
                            Icons.manage_accounts,
                            "البريد الالكتروني",
                            data.Email,
                            context,
                            Colors.blue),
                        CustomProfileCard_Details(Icons.help, "رقم الهاتف",
                            data.phoneNumber, context, Colors.green),
                        CustomProfileCard_Details(Icons.vpn_key, "رقم الهوية",
                            data.Identity, context, Colors.red),
                        Spacer(
                          flex: 3,
                        ),
                      ],
                    ))
                  ],
                );
        });
  }
}

@override
Widget build(BuildContext context) {
  // TODO: implement build
  throw UnimplementedError();
}
