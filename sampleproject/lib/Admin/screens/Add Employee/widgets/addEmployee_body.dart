import 'package:flutter/material.dart';
import 'package:sampleproject/Custom_widgets/CustomButton.dart';
import 'package:sampleproject/Custom_widgets/CustomLogo.dart';
import 'package:sampleproject/Custom_widgets/CustomPasswordField.dart';
import 'package:sampleproject/Custom_widgets/CustomTextField.dart';
import 'package:sampleproject/myadditional_folder/constants.dart';
import 'package:sampleproject/features/splash/presentation/Auth/presentation/pages/login/loginpage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../../APIs/fetchData.dart';

class addEmployee_body extends StatefulWidget {
  const addEmployee_body({Key? key}) : super(key: key);

  @override
  State<addEmployee_body> createState() => _addEmployee_bodyState();
}

class _addEmployee_bodyState extends State<addEmployee_body> {
  Future<void> AddEmployee() async {
    if (_nameController.text.trim().isEmpty ||
        _phoneController.text.trim().isEmpty ||
        _IdController.text.trim().isEmpty ||
        _PasswordController.text.trim().isEmpty ||
        _jobTitle.text.trim().isEmpty) {
      print("Empty fields");
      return;
    }

    var body1 = jsonEncode({
      'name': _nameController.text,
      'Identity': _IdController.text,
      'password': _PasswordController.text,
      'phoneNumber': _phoneController.text,
      'jobTitle': _jobTitle.text,
    });
    var res = await http.post(Uri.parse(FetchData.baseURL + "/employees"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body1);
    if (res.statusCode == 201) {
      print("Successfully added");
    } else {
      print("faild to add");
    }
    _clearValues();
  }

  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _IdController;
  late TextEditingController _PasswordController;
  late TextEditingController _jobTitle;

  _clearValues() {
    _nameController.text = "";
    _IdController.text = "";
    _PasswordController.text = "";
    _phoneController.text = "";
    _jobTitle.text = "";
  }

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _IdController = TextEditingController();
    _PasswordController = TextEditingController();
    _phoneController = TextEditingController();
    _jobTitle = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.12),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Column(
                    children: [
                      const Spacer(
                        flex: 2,
                      ),
                      myCustomTextField(
                        controller: _nameController,
                        hint: "أدخل الاسم الرباعي",
                        icon: Icons.person,
                      ),
                      // const Spacer(),
                      //myCustomTextField(
                      //  hint: "الاسم الثاني للموظف",
                      //  icon: Icons.person,
                      //),
                      //const Spacer(),
                      //myCustomTextField(
                      //  hint: "الاسم الثالث للموظف",
                      //  icon: Icons.person,
                      //),
                      //const Spacer(),
                      //myCustomTextField(
                      //  hint: "الاسم الرابع للموظف",
                      //  icon: Icons.person,
                      //),
                      const Spacer(),
                      myCustomTextField(
                        controller: _phoneController,
                        hint: "رقم الهاتف المحمول",
                        icon: Icons.phone_in_talk,
                        keyboardType: TextInputType.number,
                      ),
                      const Spacer(),
                      myCustomTextField(
                        controller: _IdController,
                        hint: "أدخل رقم الهوية",
                        icon: Icons.fact_check,
                        keyboardType: TextInputType.number,
                      ),
                      const Spacer(),

                      myCustomPasswordField(
                        controller: _PasswordController,
                        hint: "أدخل كلمة المرور",
                      ),
                      const Spacer(),
                      myCustomTextField(
                        controller: _jobTitle,
                        hint: "أدخل دائرة العمل",
                        icon: Icons.business_center,
                      ),
                      const Spacer(
                        flex: 2,
                      ),

                      ElevatedButton(
                        onPressed: () {
                          AddEmployee();
                        },
                        child: Text(
                          'اضافة',
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

                      const Spacer(
                        flex: 4,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
