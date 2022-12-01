import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:sampleproject/APIs/models/userModel.dart';
import 'package:sampleproject/myadditional_folder/constants.dart';

import '../APIs/fetchData.dart';
import '../User/screens/mainScreen/widgets/mainScreen_body.dart';

class CustomCardService extends StatefulWidget {
  final String img;
  var nextClass;
  final String text;
  final Color? color;

  CustomCardService(
      {required this.img,
      required this.text,
      required this.nextClass,
      this.color});

  @override
  State<CustomCardService> createState() => _CustomCardServiceState();
}

class _CustomCardServiceState extends State<CustomCardService> {
  FetchData _fetchData = FetchData();

  @override
  void initState() {
    super.initState();
    _fetchData.fetchMyAccount();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: GestureDetector(
        onTap: () {
          if (widget.text == "حاسبتي") {
            // SubNumb();
            print("++++++++++++++++" + sub_number);

            if (sub_number == "0") {
              //createDialog(context, "رقم الاشتراك مطلوب");
              _displayWarningMotionToast();
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => widget.nextClass),
              );
            }
          } else
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => widget.nextClass),
            );
        },
        child: Container(
          width: screenWidth / 6,
          height: screenWidth / 6,

          decoration: BoxDecoration(
            boxShadow: const [
              //background color of box
              BoxShadow(
                color: Color.fromARGB(152, 241, 241, 241),
                blurRadius: 0.0, // soften the shadow
                spreadRadius: 1.0, //extend the shadow
                offset: Offset(
                  2.0, // Move to right 10  horizontally
                  2.0, // Move to bottom 10 Vertically
                ),
              )
            ],
            borderRadius: BorderRadius.circular(15),
            //color: Color.fromARGB(74, 219, 218, 218),
          ),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(
                flex: 4,
              ),
              Image.network(
                widget.img,
                height: 55,
                width: 60,
              ),
              Spacer(
                flex: 4,
              ),
              Text(
                widget.text,
                style: TextStyle(
                    fontFamily: myOtherFont,
                    fontSize: 11,
                    color: myGray,
                    fontWeight: FontWeight.bold),
              ),
              Spacer(
                flex: 4,
              ),
            ],
          ),

          //  color: myMainColor,
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
              height: 260,
              child: Column(
                children: [
                  Container(width: 200, child: Image.network(error_subNum)),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "الدخول الى هذه الصفحة يتطلب منك ادخال رقم الاشتراك الخاص بك لتتمكن من حساب استهلاكك, أدخل رقم الاشتراك وحاول مرة اخرى",
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

  TextStyle style() {
    return TextStyle(
      fontFamily: myOtherFont,
      fontSize: 14,
    );
  }

  void _displayWarningMotionToast() {
    MotionToast.error(
      title: const Text(
        'رقم الاشتراك مطلوب',
        style: TextStyle(fontWeight: FontWeight.bold, fontFamily: myOtherFont),
      ),
      description: const Text(
        "الدخول الى هذه الصفحة يتطلب منك ادخال رقم الاشتراك، أدخل رقم الاشتراك وحاول مرة اخرى",
        style: TextStyle(fontFamily: myOtherFont, fontSize: 12),
      ),
      animationCurve: Curves.easeIn,
      borderRadius: 0,
      animationDuration: const Duration(milliseconds: 2000),
    ).show(context);
  }
}
