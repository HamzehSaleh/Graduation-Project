import 'package:flutter/material.dart';
import 'package:sampleproject/Custom_widgets/CustomButton.dart';
import 'package:sampleproject/features/splash/presentation/Auth/presentation/pages/login/loginpage.dart';
import 'package:sampleproject/myadditional_folder/constants.dart';

class checkEmailClass extends StatelessWidget {
  const checkEmailClass({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
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
      //   resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.12),
        child: Center(
          child: Column(
            children: <Widget>[
              const Spacer(),
              Image(
                  image: NetworkImage(checkEmail),
                  height: screenHeight * 0.40,
                  width: screenWidth * 0.67),
              const Spacer(
                //flex: 2,
                flex: 2,
              ),
              const Text(
                "افحص البريد الالكتروني",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: myGray, fontFamily: 'ALMARAI', fontSize: 20),
              ),
              Spacer(
                flex: 2,
              ),
              Text(
                "لقد ارسلنا لك كلمة مرور جديدة",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: myGray.withOpacity(0.6),
                    fontFamily: 'ALMARAI',
                    fontSize: 15),
              ),
              Text(
                "الى بريدك الالكتروني",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: myGray.withOpacity(0.6),
                    fontFamily: 'ALMARAI',
                    fontSize: 15),
              ),
              Spacer(
                flex: 3,
              ),
              myCustomButton(
                text: "تسجيل الدخول",
                Fun: fun,
                toClass: const loginPageClass(),
              ),
              const Spacer(
                flex: 2,
              ),
              //FlatButton(
              //  color: Colors.transparent,
              //  splashColor: Colors.black26,
              //  onPressed: () {
              //    Navigator.push(
              //      context,
              //      MaterialPageRoute(
              //        builder: (context) => loginPageClass(),
              //      ),
              //    );
              //  },
              //  child: const Text(
              //    'الغاء ورجوع',
              //    style: TextStyle(color: myMainColor, fontFamily: 'ALMARAI'),
              //  ),
              //),
              const Spacer(
                flex: 2,
              ),
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
      ),
    );
  }

  void fun() {}
}
