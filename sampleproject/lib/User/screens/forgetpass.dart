import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sampleproject/Custom_widgets/CustomButton.dart';
import 'package:sampleproject/Custom_widgets/CustomTextField.dart';
import 'package:sampleproject/User/screens/checkEmail.dart';
import 'package:sampleproject/myadditional_folder/constants.dart';
import 'package:sampleproject/APIs/fetchData.dart';
import 'package:sampleproject/features/splash/presentation/Auth/presentation/pages/login/loginpage.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: forgetPassClass(),
    );
  }
}

// ignore: camel_case_types
class forgetPassClass extends StatefulWidget {
  const forgetPassClass({Key? key}) : super(key: key);

  @override
  State<forgetPassClass> createState() => _forgetPassClassState();
}

class _forgetPassClassState extends State<forgetPassClass> {
  late TextEditingController Identity;
  late TextEditingController email;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Identity = TextEditingController();
    email = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: myMainColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: false,
        title: const Text(
          "رجوع",
          style: TextStyle(
              fontFamily: "ALMARAI", color: myMainColor, fontSize: 15),
        ),
      ),
      // resizeToAvoidBottomInset: false,
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.12),
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        const Spacer(),
                        SizedBox(
                          child: Image.network(forgetPass,
                              height: screenHeight * 0.36,
                              width: screenWidth * 0.60),
                        ),
                        const Spacer(
                          flex: 1,
                        ),
                        const Text(
                          "هل نسيت كلمة المرور؟",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: myGray,
                              fontFamily: 'ALMARAI',
                              fontSize: 20),
                        ),
                        const Spacer(),
                        Text(
                          "قم بإدخال أي بريد الكتروني خاص بك للحصول",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: myGray.withOpacity(0.6),
                              fontFamily: 'ALMARAI',
                              fontSize: 15),
                        ),
                        Text(
                          "على كلمة مرور جديدة",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: myGray.withOpacity(0.6),
                              fontFamily: 'ALMARAI',
                              fontSize: 15),
                        ),
                        const Spacer(
                          flex: 1,
                        ),
                        myCustomTextField(
                          hint: "أدخل رقم الهوية",
                          icon: Icons.fact_check,
                          keyboardType: TextInputType.number,
                          controller: Identity,
                        ),
                        const Spacer(
                          flex: 1,
                        ),
                        myCustomTextField(
                          hint: "أدخل البريد الالكتروني",
                          icon: Icons.email,
                          controller: email,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        myCustomButton(
                          text: "استمرار",
                          toClass: checkEmailClass(),
                          Fun: check,
                        ),
                        const Spacer(),
                        const Spacer(),
                        Text(
                          "تطبيق قسم كهرباء بلدية طولكرم",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: myGray.withOpacity(0.4),
                              fontFamily: 'ALMARAI',
                              fontSize: 12),
                        ),
                        const SizedBox(
                          height: 40,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void check() async {
    var res = await http.post(
      Uri.parse(FetchData.baseURL + "/usersSendEmail/" + email.text),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
  }
}
