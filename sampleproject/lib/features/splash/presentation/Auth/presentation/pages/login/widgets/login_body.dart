import 'package:flutter/material.dart';
import 'package:sampleproject/APIs/fetchData.dart';
import 'package:sampleproject/Employees/screens/Main_Employee.dart';
import 'package:sampleproject/Custom_widgets/CustomButton.dart';
import 'package:sampleproject/Custom_widgets/CustomFlatButton.dart';
import 'package:sampleproject/Custom_widgets/CustomLogo.dart';
import 'package:sampleproject/Custom_widgets/CustomTextField.dart';
import 'package:sampleproject/User/screens/forgetpass.dart';
import 'package:sampleproject/User/screens/signuppage.dart';
import 'package:sampleproject/bar/buttomNavBar.dart';
import 'package:sampleproject/myadditional_folder/constants.dart';
import 'package:connectivity/connectivity.dart';
import 'package:connectivity/connectivity.dart';
import 'package:sampleproject/Custom_widgets/CustomPasswordField.dart';
import 'package:sampleproject/sharedPrefs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:motion_toast/motion_toast.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../../../../../../Admin/screens/Main_Admin.dart';
import '../../../../../../../../Custom_widgets/CustomPasswordField.dart';

class loginBody extends StatefulWidget {
  const loginBody({Key? key}) : super(key: key);

  @override
  State<loginBody> createState() => _loginBodyState();
}

class _loginBodyState extends State<loginBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> Login() async {
    int flag = 0;

    if (_IdController.text.trim().isEmpty ||
        _PasswordController.text.trim().isEmpty) {
      print("Empty fields");
      return;
    }

    var body1 = jsonEncode({
      'Identity': _IdController.text,
      'password': _PasswordController.text,
    });

    var res =
        await http.post(Uri.parse(FetchData.baseURL + FetchData.usersLogin),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: body1);

    var res2 =
        await http.post(Uri.parse(FetchData.baseURL + FetchData.employeeLogin),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: body1);
    var res3 =
        await http.post(Uri.parse(FetchData.baseURL + FetchData.adminLogin),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: body1);

    if (res.statusCode == 200) {
      flag = 1; // user
    } else if (res2.statusCode == 200) {
      flag = 2; // employee
    } else if (res3.statusCode == 200) {
      flag = 3;
    }

    if (flag == 1) {
      _clearValues();
      print("User signed in");
      var body = jsonDecode(res.body);
      sharedPrefs.saveToken(body['token']);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => buttomNavBarClass()));
    } else if (flag == 2) {
      _clearValues();
      print("Employee signed in");
      var body = jsonDecode(res2.body);
      sharedPrefs.saveToken(body['token']);

      Navigator.push(context,
          MaterialPageRoute(builder: (context) => mainEmployeeClass()));
    } else if (flag == 3) {
      _clearValues();
      print("Admin login");

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => usersClass()),
      );
    } else {
      print("faild to sign in");
      return;
    }
  }

  late TextEditingController _IdController;
  late TextEditingController _PasswordController;

  void validation() {
    final FormState? _form = _formKey.currentState;

    if (_form!.validate()) {
      print("yes");
    } else
      print("no");
  }

  void _clearValues() {
    _PasswordController.text = "";
    _IdController.text = "";
  }

  void initState() {
    super.initState();
    _PasswordController = TextEditingController();
    _IdController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.12),
      child: Column(
        children: <Widget>[
          Expanded(
              child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Spacer(
                  flex: 2,
                ),
                myCustomLogo(screenWidth: screenWidth, fontSize: logoFontSize),
                const Spacer(),
                const Text(
                  "اذا كان لديك حساب",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: myGray, fontFamily: 'ALMARAI', fontSize: 18),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "قم بتسجيل الدخول الى حسابك",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: myGray, fontFamily: 'ALMARAI', fontSize: 18),
                ),
                const Spacer(),
                myCustomTextField(
                  controller: _IdController,
                  hint: "أدخل رقم الهوية",
                  icon: Icons.fact_check,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(
                  height: 15,
                ),
                myCustomPasswordField(
                  controller: _PasswordController,
                  hint: "أدخل كلمة المرور",
                ),
                const SizedBox(
                  height: 10,
                ),

                //  Spacer(),
                Row(
                  children: [
                    const Spacer(),
                    CustomFlatButton(
                      nextClass: forgetPassClass(),
                      text: "هل نسيت كلمة المرور؟",
                      Fun: login,
                    ),
                  ],
                ),
                Spacer(),

                ElevatedButton(
                  onPressed: () async {
                    final result = await Connectivity().checkConnectivity();
                    int value = showConnectivitySnackBar(result);
                    if (value == 1) {
                      _displayWarningMotionToast();
                    } else {
                      Login();
                    }
                  },
                  child: Text(
                    "استمرار",
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

                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "لا تملك حساب؟ ",
                      //textAlign: TextAlign.center,
                      style: TextStyle(
                          color: myGray.withOpacity(0.6),
                          fontFamily: 'ALMARAI',
                          fontSize: 15),
                    ),
                    CustomFlatButton(
                      text: "سجل من هنا",
                      nextClass: signUpPageClass(),
                      Fun: login,
                    )
                  ],
                ),
                const Spacer(),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    "تطبيق قسم كهرباء بلدية طولكرم",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: TFmyGray, fontFamily: 'ALMARAI', fontSize: 13),
                  ),
                ),
                const SizedBox(
                  height: 40,
                )
              ],
            ),
          ))
        ],
      ),
    );
  }

  int showConnectivitySnackBar(ConnectivityResult result) {
    final hasInternet = result != ConnectivityResult.none;
    final message = hasInternet
        ? "you have a gain ${result.toString()}"
        : "you don't have an internet";
    // print(result);
    if (result.toString() == "ConnectivityResult.wifi") {
      return 0;
    } else if (result.toString() == "ConnectivityResult.mobile") {
      return 0;
    } else {
      return 1;
    }

    //final Color = hasInternet ? Colors.green : Colors.red;
  }

  void _displayWarningMotionToast() {
    MotionToast.warning(
      title: const Text(
        'لا يوجد اتصال بالانترنت',
        style: TextStyle(fontWeight: FontWeight.bold, fontFamily: myOtherFont),
      ),
      description: const Text(
        'افحص اتصالك بالانترنت وحاول مرة اخرى',
        style: TextStyle(fontFamily: myOtherFont, fontSize: 12),
      ),
      animationCurve: Curves.bounceIn,
      borderRadius: 0,
      animationDuration: const Duration(milliseconds: 2000),
    ).show(context);
  }

  void login() async {}
}
