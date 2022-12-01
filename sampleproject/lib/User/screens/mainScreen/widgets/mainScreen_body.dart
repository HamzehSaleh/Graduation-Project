import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';

//import 'package:firebase_messaging_web/firebase_messaging_web.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sampleproject/Custom_widgets/CustomFlatButton.dart';
import 'package:sampleproject/Custom_widgets/custom_grid.dart';
import 'package:sampleproject/Employees/Screens/Main_Employee.dart';
import 'package:sampleproject/User/screens/mainScreen/widgets/notification_body.dart';
import 'package:sampleproject/myadditional_folder/constants.dart';
import '../../../../features/splash/presentation/Auth/presentation/pages/login/loginpage.dart';

import 'package:geolocator/geolocator.dart';
import '../../../../APIs/fetchData.dart';
import '../../../../APIs/models/userModel.dart';
import 'package:http/http.dart' as http;

import '../../../../main.dart';

late String sub_number;
late List consump;

class mainScreenBody extends StatefulWidget {
  const mainScreenBody({Key? key}) : super(key: key);

  @override
  State<mainScreenBody> createState() => _mainScreenBodyState();
}

late double myPosition_lat = 32.33422;
late double myPosition_long = 35.03577;
Future<void> Logout_fun() async {
  var header = {"Authorization": "Bearer " + prefs.get("token").toString()};

  var res = await http.post(Uri.parse(FetchData.baseURL + "/users/logout"),
      headers: header);
  if (res.statusCode == 200) {
    print("successfully logout");
  }
}

//getMessage() {
//  FirebaseMessaging.onMessage.listen((message) {
//    title_List.add(message.notification!.title.toString());
//    body_List.add(message.notification!.body.toString());
//    // setState(() {});

//    print(message.data['name'] + "  listened");
//    // print(title_List.toString());
//    print(title_List.length);
//  });
//}

class _mainScreenBodyState extends State<mainScreenBody> {
  FetchData _fetchData = FetchData();
  var locationMessage = "";

  void getCurrentLocation() async {
    var position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    var lastPosition = await Geolocator().getLastKnownPosition();
    // print(lastPosition);

    myPosition_lat = position.latitude;
    myPosition_long = position.longitude;

    setState(() {
      myPosition_lat;
      myPosition_long;
      locationMessage =
          "latitude :$myPosition_lat , longitude:$myPosition_long";
      print(locationMessage);
    });
  }

  var fbm = FirebaseMessaging.instance;

  DateTime now = DateTime.now();

  @override
  initState() {
    // getMessage();

    fbm.getToken().then((token) {
      print(token);
    });
    _fetchData.fetchMyAccount();
    //if (now.hour.toString() + ":" + now.minute.toString() == "17:59") {
    //  sendNotfiy("the title", "the body", "1");
    //}

    getCurrentLocation();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: <Widget>[
                    const Spacer(),
                    Row(
                      children: [
                        // const Spacer(),
                        const Text(
                          "حساب نشط",
                          style: TextStyle(
                              fontFamily: myOtherFont,
                              fontSize: 13,
                              color: myGray),
                        ),
                        const Spacer(
                          flex: 7,
                        ),
                        CustomFlatButton(
                          text: "تسجيل الخروج",
                          nextClass: loginPageClass(),
                          fontSize: 11,
                        )
                      ],
                    ),
                    const Spacer(),
                    Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: const [
                              //background color of box
                              BoxShadow(
                                color: Color.fromARGB(77, 160, 157, 157),
                                blurRadius: 20.0, // soften the shadow
                                spreadRadius: 1.0, //extend the shadow
                                offset: Offset(
                                  2.0, // Move to right 10  horizontally
                                  2.0, // Move to bottom 10 Vertically
                                ),
                              )
                            ],
                            color: Color.fromARGB(219, 248, 248, 248),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          height: screenHeight * 0.25,
                          width: screenWidth,
                          child: Column(
                            children: [
                              const Spacer(),
                              Row(
                                children: [
                                  const Spacer(
                                    flex: 4,
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        width: 70,
                                        height: 70,
                                        child: CircleAvatar(
                                          backgroundImage:
                                              NetworkImage(myMenAvatar),
                                          radius: myMenAvatarRadius,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  headerProfileCard(),
                                  const Spacer(
                                    flex: 4,
                                  ),
                                ],
                              ),
                              const Spacer(
                                flex: 1,
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  //Navigator.push(
                                  //  context,
                                  //  MaterialPageRoute(
                                  //      builder: (context) => mainProfileClass(
                                  //            val: 1,
                                  //          )),
                                  //);

                                  //Navigator.push(
                                  //  context,
                                  //  MaterialPageRoute(
                                  //      builder: (context) => usersClass()),
                                  //);
                                  DateTime now = DateTime.now();
                                  print(now.hour.toString() +
                                      ":" +
                                      now.minute.toString() +
                                      ":" +
                                      now.second.toString());

                                  //await sendNotfiy(
                                  //    "the title", "the body", "1");
                                },
                                child: Text(
                                  "زيارة الملف الشخصي",
                                  style: const TextStyle(
                                    fontFamily: myOtherFont,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                    shadowColor: Colors.black,
                                    elevation: 3,
                                    primary: myMainColor,
                                    fixedSize: Size(
                                        screenWidth * 0.8, screenWidth * 0.03),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Column(
                              children: [
                                Icon(
                                  Icons.military_tech,
                                  size: 30,
                                  color: Color.fromARGB(255, 227, 212, 81),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    const Spacer(
                      flex: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Row(
                        children: [
                          // const Spacer(),
                          const Text(
                            "الخدمات السريعة",
                            style: TextStyle(
                                fontFamily: myOtherFont,
                                fontSize: 13,
                                color: myGray),
                          ),
                          const Spacer(
                            flex: 7,
                          ),
                          CustomFlatButton(
                            text: "استعراض الكل",
                            nextClass: mainEmployeeClass(),
                            fontSize: 11,
                          )
                        ],
                      ),
                    ),

                    CustomGrid(),
                    const Spacer(
                      flex: 1,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: const [
                          //background color of box
                          BoxShadow(
                            color: Color.fromARGB(77, 160, 157, 157),
                            blurRadius: 20.0, // soften the shadow
                            spreadRadius: 1.0, //extend the shadow
                            offset: Offset(
                              2.0, // Move to right 10  horizontally
                              2.0, // Move to bottom 10 Vertically
                            ),
                          )
                        ],
                        color: Color.fromARGB(219, 248, 248, 248),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      height: screenHeight * 0.08,
                      width: screenWidth,
                      child: Row(children: [
                        const Spacer(),
                        CircleAvatar(
                          backgroundImage: NetworkImage(light),
                          radius: myMenAvatarRadius * 0.4,
                          backgroundColor: Color.fromARGB(219, 248, 248, 248),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "نحاول من خلال هذا التطبيق تنظيم استهلاك الكهرباء \n في مدينة طولكرم عن طريق ادارة فترة استخدام الاجهزة  ",
                          style: TextStyle(
                              fontFamily: myOtherFont,
                              fontSize: 13,
                              color: myGray),
                        ),
                        const Spacer(),
                      ]),
                    ),

                    //myCustomButton(text: "text", toClass: PinTestClass()),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget headerProfileCard() {
    return FutureBuilder(
      future: _fetchData.fetchMyAccount(),
      builder: (context, snapchot) {
        userModel data = snapchot.data as userModel;
        data == null ? sub_number = "0" : sub_number = data.sub_Number;
        data == null ? consump = [] : consump = data.arr;
        return snapchot.data == null
            ? Text("جاري التحميل...")
            : Column(
                children: [
                  Text(
                    data.Name,
                    style: TextStyle(
                        color: myMainColor,
                        fontFamily: 'ALMARAI',
                        fontSize: mainProfileInfoFontSize,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(
                    data.Email,
                    style: TextStyle(
                        color: myMainColor,
                        fontFamily: 'ALMARAI',
                        fontSize: 13),
                  ),
                  SizedBox(height: 5),
                  Text(
                    " رقم الاشتراك" + " : " + data.sub_Number,
                    style: TextStyle(
                        color: myMainColor,
                        fontFamily: 'ALMARAI',
                        fontSize: 13),
                  ),
                ],
              );
      },
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
