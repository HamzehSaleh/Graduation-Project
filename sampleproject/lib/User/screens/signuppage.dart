import 'package:flutter/material.dart';
import 'package:sampleproject/APIs/fetchData.dart';
import 'package:sampleproject/Custom_widgets/CustomButton.dart';
import 'package:sampleproject/Custom_widgets/CustomLogo.dart';
import 'package:sampleproject/Custom_widgets/CustomPasswordField.dart';
import 'package:sampleproject/Custom_widgets/CustomTextField.dart';
import 'package:sampleproject/myadditional_folder/constants.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:sampleproject/features/splash/presentation/Auth/presentation/pages/login/loginpage.dart';

// ignore: camel_case_types
class signUpPageClass extends StatefulWidget {
  signUpPageClass({Key? key}) : super(key: key);

  @override
  State<signUpPageClass> createState() => _signUpPageClassState();
}

class _signUpPageClassState extends State<signUpPageClass> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> SignUp() async {
    if (_nameController.text.trim().isEmpty ||
        _phoneController.text.trim().isEmpty ||
        _IdController.text.trim().isEmpty ||
        _PasswordController.text.trim().isEmpty) {
      print("Empty fields");
      return;
    }

    var body1 = jsonEncode({
      'name': _nameController.text,
      'Identity': _IdController.text,
      'password': _PasswordController.text,
      'phoneNumber': _phoneController.text,
    });

    var res = await http.post(Uri.parse(FetchData.baseURL + "/users"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body1);
    print(res.statusCode);
    if (res.statusCode == 201) {
      print("Successfully signed up");
    } else {
      print("faild to signup");
    }
    _clearValues();
    // Navigator.push(
    //     context,
    //     MaterialPageRoute(builder: (context) => loginPageClass()),
    //   );
  }

  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _IdController;
  late TextEditingController _PasswordController;

  void validation() {
    final FormState? _form = _formKey.currentState;

    if (_form!.validate()) {
      print("yes");
    } else
      print("no");
  }

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _IdController = TextEditingController();
    _PasswordController = TextEditingController();
    _phoneController = TextEditingController();
  }

  _clearValues() {
    _nameController.text = "";
    _IdController.text = "";
    _PasswordController.text = "";
    _phoneController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.12),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const Spacer(
                      flex: 4,
                    ),
                    //myCustomLogo(
                    //    screenWidth: screenWidth, fontSize: logoFontSize),

                    Text(
                      "أنشأ حساب جديد الان!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: myMainColor,
                          fontFamily: 'ALMARAI',
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    const Spacer(
                      flex: 3,
                    ),

                    myCustomTextField(
                      controller: _nameController,
                      hint: "أدخل الاسم الرباعي",
                      icon: Icons.person,
                    ),

                    const Spacer(
                      flex: 1,
                    ),
                    myCustomTextField(
                      controller: _phoneController,
                      hint: "رقم الهاتف المحمول",
                      icon: Icons.phone_in_talk,
                      keyboardType: TextInputType.number,
                    ),
                    //const SizedBox(
                    //  height: 15,
                    //),
                    const Spacer(
                      flex: 1,
                    ),
                    myCustomTextField(
                      controller: _IdController,
                      hint: "أدخل رقم الهوية",
                      icon: Icons.fact_check,
                      keyboardType: TextInputType.number,
                    ),

                    const Spacer(
                      flex: 1,
                    ),
                    myCustomPasswordField(
                      controller: _PasswordController,
                      hint: "أدخل كلمة المرور",
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                    myCustomPasswordField(
                      hint: "أعد ادخال كلمة المرور",
                    ),

                    const Spacer(
                      flex: 2,
                    ),

                    // ElevatedButton(onPressed: () async{
                    //   SignUp();
                    // }, child: Text("سجل")),
                    myCustomButton(
                      text: "سجل",
                      toClass: loginPageClass(),
                      Fun: SignUp,
                    ),

                    const Spacer(),
                    Text(
                      "او",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0xff475267).withOpacity(0.6),
                          fontFamily: 'ALMARAI',
                          fontSize: 15),
                    ),
                    const Spacer(),
                    FlatButton(
                      color: Colors.transparent,
                      splashColor: Colors.black26,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const loginPageClass()),
                        );
                      },
                      child: const Text(
                        'تسجيل الدخول الى حسابك',
                        style: TextStyle(
                            color: myMainColor,
                            fontFamily: 'ALMARAI',
                            fontSize: 15),
                      ),
                    ),
                    const Spacer(
                      flex: 2,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        "تطبيق قسم كهرباء بلدية طولكرم",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: TFmyGray,
                            fontFamily: 'ALMARAI',
                            fontSize: 13),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
