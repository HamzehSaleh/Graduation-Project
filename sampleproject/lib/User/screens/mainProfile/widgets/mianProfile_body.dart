import 'package:flutter/material.dart';
import 'package:sampleproject/Custom_widgets/CustomCoverAvatarProfile.dart';
import 'package:sampleproject/User/screens/myProfile/screens/Change%20Password/changePass.dart';
import 'package:sampleproject/User/screens/myProfile/screens/personalInfo/personalInfo.dart';
import 'package:sampleproject/myadditional_folder/constants.dart';
import '../../../../APIs/fetchData.dart';
import '../../../../APIs/models/userModel.dart';
import '../../myProfile/screens/Who us/whoUs.dart';

String myID = "";

class mainProfileBody extends StatefulWidget {
  @override
  State<mainProfileBody> createState() => _mainProfileBodyState();
}

class _mainProfileBodyState extends State<mainProfileBody> {
  FetchData _fetchData = FetchData();

  late String sub_number;

  @override
  void initState() {
    super.initState();
    _fetchData.fetchMyAccount();
  }

  createAlertDialog(BuildContext context, String hint, String title) {
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
              height: 250,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                              width: 200, child: Image.network(addSubNum)),
                          SizedBox(
                            height: 20,
                          ),
                          funn(customController)
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
                  _fetchData.changeUserData(
                      "sub_Number", customController.text);
                  print(customController.text.toString());
                  sub_number = customController.text;
                  Navigator.of(context).pop(customController.text.toString());
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return FutureBuilder(
        future: _fetchData.fetchMyAccount(),
        builder: (context, snapchot) {
          userModel data = snapchot.data as userModel;
          data == null ? sub_number = "0" : sub_number = data.sub_Number;
          data == null ? myID = "0" : myID = data.id;
          return snapchot.data == null
              ? Text("جاري التحميل...")
              : CustomScrollView(slivers: [
                  SliverFillRemaining(
                      hasScrollBody: false,
                      child: Column(
                        //  mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                              child: Column(
                            children: [
                              customCoverAvatarProfile(
                                screenWidth: screenWidth,
                                screenHeight: screenHeight,
                                name: data.Name,
                                email: data.Email,
                              ),
                              Spacer(),
                              ProfileCard_MainMethod(
                                  context,
                                  Icons.manage_accounts,
                                  "المعلومات الشخصية",
                                  personalInfoClass(),
                                  Colors.blue),
                              ProfileCard_MainMethod(context, Icons.help,
                                  "رقم الاشتراك", whoUS_Class(), Colors.green),
                              ProfileCard_MainMethod(
                                  context,
                                  Icons.vpn_key,
                                  "تغيير كلمة المرور",
                                  changePassClass(),
                                  Colors.red),
                              Spacer(
                                flex: 3,
                              ),
                            ],
                          ))
                        ],
                      ))
                ]);
        });
  }

  Padding ProfileCard_MainMethod(BuildContext context, IconData icon,
      String text, var nextPage, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Container(
        height: 60,
        child: TextButton(
          onPressed: () {
            if (text == "رقم الاشتراك") {
              createAlertDialog(context, "اضافة $text", text);
            } else
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => nextPage),
              );
          },
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.white)),
          child: Row(
            children: <Widget>[
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
                    color: myGray, fontFamily: myOtherFont, fontSize: 14),
              ),
              const Spacer(),
              const Icon(
                Icons.arrow_forward_ios,
                color: myGray,
                size: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget funn(controller) {
    if (sub_number == "0") {
      return TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: 'ادخل رقم الاشتراك',
          hintStyle:
              TextStyle(fontFamily: 'ALMARAI', fontSize: 15, color: TFmyGray),
        ),
      );
    } else {
      return Text("رقم اشتراكك الحالي هو:  " + sub_number);
    }
  }
}
