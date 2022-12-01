import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sampleproject/APIs/fetchData.dart';
import 'package:sampleproject/Custom_widgets/CustomTextField.dart';
import 'package:sampleproject/myadditional_folder/constants.dart';

import '../../../Custom_widgets/CustomButton.dart';
import '../../../Custom_widgets/CustomPasswordField.dart';

class changePass extends StatefulWidget {
  const changePass({Key? key}) : super(key: key);

  @override
  State<changePass> createState() => _changePassState();
}

class _changePassState extends State<changePass> {
  late TextEditingController adminLastPass;
  late TextEditingController adminNewPass;
  late TextEditingController adminRePass2;

  FetchData _fetchData = FetchData();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    adminLastPass = new TextEditingController();
    adminNewPass = new TextEditingController();
    adminRePass2 = new TextEditingController();
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
                  const Spacer(
                    flex: 1,
                  ),
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
                            // color: Color(0xffFBFDFF),
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
                                  controller: adminLastPass,
                                  hint: "أدخل كلمة المرور الحالية",
                                ),
                                Spacer(
                                  flex: 1,
                                ),
                                myCustomPasswordField(
                                  controller: adminNewPass,
                                  hint: "أدخل كلمة المرور الجديدة",
                                ),
                                Spacer(
                                  flex: 1,
                                ),
                                myCustomPasswordField(
                                  controller: adminRePass2,
                                  hint: "أعد ادخال كلمة المرور الجديدة",
                                ),
                                Spacer(
                                  flex: 4,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    changePass();
                                  },
                                  child: Text(
                                    "حفظ ومتابعة",
                                    style: const TextStyle(
                                      fontFamily: myOtherFont,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      shadowColor: Colors.black,
                                      elevation: 3,
                                      primary: myMainColor,
                                      fixedSize:
                                          Size(screenWidth, screenWidth * 0.03),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
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

  void changePass() {
    _fetchData.changeAdminPass(adminNewPass.text);
  }

  void _clear() {
    adminNewPass.text = "";
    adminLastPass.text = "";
    adminRePass2.text = "";
  }
}
