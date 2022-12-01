import 'package:flutter/material.dart';

import 'package:sampleproject/Custom_widgets/CustomCoverAvatarProfile.dart';
import 'package:sampleproject/features/splash/presentation/Auth/presentation/pages/login/loginpage.dart';

import '../../../../Custom_widgets/CustomButton.dart';
import '../../../../Custom_widgets/CustomPasswordField.dart';
import '../../../../myadditional_folder/constants.dart';

class resetPassRequired_Body extends StatelessWidget {
  const resetPassRequired_Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      //mainAxisAlignment: MainAxisAlignment.center,
      child: Column(
        children: [
          Expanded(
              child: Column(
            children: [
              const Spacer(
                flex: 1,
              ),
              SizedBox(
                child: Image.asset(forgetPass,
                    height: screenHeight * 0.33, width: screenWidth * 0.55),
              ),
              const Spacer(
                flex: 1,
              ),
              const Text(
                "تعيين كلمة مرور جديدة",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: myGray, fontFamily: 'ALMARAI', fontSize: 20),
              ),
              const Spacer(
                flex: 10,
              ),
              Text(
                "يجب عليك تعيين كلمة مرور جديدة حتى تتمكن",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: myGray.withOpacity(0.6),
                    fontFamily: 'ALMARAI',
                    fontSize: 15),
              ),
              Text(
                "حتى تتمكن من الدخول الى حسابك",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: myGray.withOpacity(0.6),
                    fontFamily: 'ALMARAI',
                    fontSize: 15),
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
                        //  color: Color(0xffFBFDFF),
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
                            const Spacer(
                              flex: 1,
                            ),
                            Column(
                              children: [
                                Container(
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          const Spacer(
                                            flex: 2,
                                          ),
                                          myButton(
                                              "حفظ",
                                              context,
                                              screenWidth * 0.3,
                                              loginPageClass()),
                                          Spacer(),
                                          myButton(
                                              "الغاء ورجوع",
                                              context,
                                              screenWidth * 0.3,
                                              loginPageClass()),
                                          const Spacer(
                                            flex: 2,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(
                flex: 20,
              ),
            ],
          ))
        ],
      ),
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
          fixedSize: Size(screenWidth, screenWidth * 0.1),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
    );
  }
}
