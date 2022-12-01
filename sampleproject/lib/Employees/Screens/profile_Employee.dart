import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';
import 'package:sampleproject/APIs/fetchData.dart';
import 'package:sampleproject/APIs/models/userModel.dart';
import 'package:sampleproject/Admin/screens/Employees/Employees_body_Admin.dart';
import 'package:sampleproject/Employees/Screens/notifications_Employee.dart';
import 'package:sampleproject/Employees/Screens/notifications_body_Employee.dart';
import 'package:sampleproject/features/splash/presentation/Auth/presentation/pages/login/loginpage.dart';

import '../../APIs/models/employeeModel.dart';
import '../../Custom_widgets/CustomCoverAvatarProfile.dart';
import '../../Custom_widgets/CustomFlatButton_Icon.dart';
import '../../Custom_widgets/CustomPasswordField.dart';
import '../../User/screens/myProfile/screens/personalInfo/personalInfo.dart';
import '../../main.dart';
import '../../myadditional_folder/constants.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'enterConsumption_Employee.dart';

class profile_body_Employee extends StatefulWidget {
  const profile_body_Employee({Key? key}) : super(key: key);

  @override
  State<profile_body_Employee> createState() => _profile_body_EmployeeState();
}

class _profile_body_EmployeeState extends State<profile_body_Employee> {
  SlidingUpPanelController panelController = SlidingUpPanelController();
  FetchData _fetchData = FetchData();

  late ScrollController scrollController;
  TextEditingController textarea = TextEditingController();

  @override
  void initState() {
    // panelController.hide();
    _fetchData.fetchEmployeeAccount();

    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.offset >=
              scrollController.position.maxScrollExtent &&
          !scrollController.position.outOfRange) {
        panelController.expand();
      } else if (scrollController.offset <=
              scrollController.position.minScrollExtent &&
          !scrollController.position.outOfRange) {
        panelController.anchor();
      } else {}
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    print(now.hour.toString() +
        ":" +
        now.minute.toString() +
        ":" +
        now.second.toString());

    if (now.month + 1 == minMonth) {
      title_List_Employee.add("تنبيه من احتمال ارتفاع الاحمال");
      body_List_Employee.add(
          "حسب الاستهلاك المرفق تم اكتشاف ان الاشهر الثلاثة القادمة هي الاعلى استهلاك خلال السنة الماضية يرجى ارسال تنبيهات للمواطنين للحث على الترشيد");

      setState(() {
        notificationsNum_Employee++;
      });
    }

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        Column(
          children: [
            Expanded(
                child: Column(
              children: [
                headerProfile(),
                SizedBox(
                  height: 20,
                ),
                profileCard(
                  context,
                  Icons.manage_accounts,
                  "تغيير كلمة المرور",
                ),
                profileCard(
                  context,
                  Icons.message,
                  "ارسال رسالة الى الادمن",
                ),
                profileCard(
                  context,
                  Icons.logout,
                  "تسجيل الخروج",
                ),
                const Spacer(
                  flex: 1,
                ),
              ],
            ))
          ],
        ),
        SlidingUpPanelWidget(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 0),
            decoration: const ShapeDecoration(
              color: Colors.white,
              shadows: [
                BoxShadow(
                    blurRadius: 5.0,
                    spreadRadius: 2.0,
                    color: Color(0x11000000))
              ],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
              ),
            ),
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  child: Row(
                    children: const <Widget>[
                      Icon(
                        Icons.menu,
                        size: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 8.0,
                        ),
                      ),
                      Text(
                        'اضغط هنا للاغلاق',
                        style: TextStyle(fontFamily: myOtherFont, fontSize: 12),
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                  height: 50.0,
                ),
                Divider(
                  height: 0.5,
                  color: Colors.grey[300],
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      // alignment: Alignment.topRight,
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Column(
                          children: [
                            const Spacer(
                              flex: 1,
                            ),
                            SizedBox(
                              child: Image.network(forgetPass,
                                  height: screenHeight * 0.33,
                                  width: screenWidth * 0.55),
                            ),
                            const Spacer(
                              flex: 1,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                children: [
                                  myCustomPasswordField(
                                    hint: "أدخل كلمة المرور الحالية",
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  myCustomPasswordField(
                                    hint: "أدخل كلمة المرور الجديدة",
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  myCustomPasswordField(
                                    hint: "اعادة ادخال كلمة المرور الجديدة",
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(
                              flex: 5,
                            ),
                            myButton("حفظ واستمرار", context, screenWidth,
                                loginPageClass()),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
              mainAxisSize: MainAxisSize.min,
            ),
          ),
          controlHeight: 0,
          anchor: 0.4,
          panelController: panelController,
          onTap: () {
            ///Customize the processing logic
            if (SlidingUpPanelStatus.expanded == panelController.status) {
              panelController.collapse();
            } else {
              //  panelController.expand();
            }
          },
          enableOnTap: true, //Enable the onTap callback for control bar.
        ),
      ],
    );
  }

  ElevatedButton myButton(
      String text, BuildContext context, double screenWidth, var toClass) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => toClass),
        );
      },
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: myOtherFont,
        ),
      ),
      style: ElevatedButton.styleFrom(
          shadowColor: Colors.black,
          elevation: 3,
          primary: myMainColor,
          fixedSize: Size(screenWidth, screenWidth * 0.03),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
    );
  }

  Row sheetRow(String title, String info) {
    return Row(
      children: [
        const SizedBox(
          width: 20,
        ),
        Text(
          title,
          style: style(),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          info,
          style: sheetInfostyle(),
        ),
        const Spacer(),
      ],
    );
  }

  TextStyle sheetInfostyle() {
    return TextStyle(fontFamily: myOtherFont, fontSize: 15);
  }

  TextStyle style() {
    return TextStyle(
      fontFamily: myOtherFont,
      fontSize: 14,
    );
  }

  Padding profileCard(BuildContext context, IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Container(
        height: 50,
        child: TextButton(
          onPressed: () {
            if (text == "تغيير كلمة المرور") {
              // createDialog(context, "طلب تغيير كلمة المرور");
              panelController.expand();
            } else if (text == "ارسال رسالة الى الادمن") {
              createInputDialog(
                  context, "أدخل نص الرسالة", "ارسال رسالة خاصة الى الادمن");
            } else {
              LogoutAll();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => loginPageClass()),
              );
            }
          },
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.white)),
          child: Row(
            children: <Widget>[
              Icon(
                icon,
                color: myGray,
                size: 20,
              ),
              const SizedBox(
                width: 25,
              ),
              Text(
                text,
                style: TextStyle(
                    color: myGray, fontFamily: myOtherFont, fontSize: 13),
              ),
              const Spacer(),
              const Icon(
                Icons.arrow_forward_ios,
                color: myGray,
                size: 13,
              ),
            ],
          ),
        ),
      ),
    );
  }

  createDialog(BuildContext context, String title) {
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
              height: 270,
              child: Column(
                children: [
                  Container(width: 200, child: Image.network(forgetPass)),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "لقد تم ارسال الطلب بنجاح، سوف يتم تغيير كلمة المرور وابلاغك بها في أسرع وقت ممكن",
                    style: style(),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              MaterialButton(
                elevation: 5.0,
                child: Text(
                  "موافق",
                  style: const TextStyle(
                    fontFamily: myOtherFont,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop(customController.text.toString());
                },
              ),
            ],
          );
        });
  }

  createInputDialog(BuildContext context, String hint, String title) {
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
              height: 270,
              child: Column(
                children: [
                  Container(width: 200, child: Image.network(sendMessage)),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: customController,
                    decoration: InputDecoration(
                      hintText: hint,
                      hintStyle: TextStyle(
                          fontFamily: 'ALMARAI', fontSize: 15, color: TFmyGray),
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
                  Navigator.of(context).pop(customController.text.toString());
                },
              ),
            ],
          );
        });
  }

  Widget headerProfile() {
    return FutureBuilder(
        future: _fetchData.fetchEmployeeAccount(),
        builder: (context, snapchot) {
          emoployeeModel data = snapchot.data as emoployeeModel;
          return snapchot.data == null
              ? Text("جاري التحميل")
              : customCoverAvatarProfile(
                  screenWidth: MediaQuery.of(context).size.width,
                  screenHeight: MediaQuery.of(context).size.height,
                  name: data.Name,
                  email: data.Email,
                );
        });
  }
}

Future<void> LogoutAll() async {
  var header = {"Authorization": "Bearer " + prefs.get("token").toString()};

  var res = await http.post(
      Uri.parse(FetchData.baseURL + "/employees/logoutAll"),
      headers: header);
}
