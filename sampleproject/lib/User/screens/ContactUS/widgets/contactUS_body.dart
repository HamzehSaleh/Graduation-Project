import 'package:flutter/material.dart';

import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:sampleproject/myadditional_folder/constants.dart';

class mainContactUSBody extends StatefulWidget {
  const mainContactUSBody({Key? key}) : super(key: key);

  @override
  State<mainContactUSBody> createState() => _mainContactUSBodyState();
}

class _mainContactUSBodyState extends State<mainContactUSBody> {
  late final String PHnumber;
  @override
  void initState() {
    super.initState();
    PHnumber = "092671015";
  }

  sendMessageDialog(BuildContext context) {
    TextEditingController customController = new TextEditingController();

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "ارسال رسالة خاصة",
              style: const TextStyle(fontFamily: myOtherFont, fontSize: 14),
            ),
            content: Container(
              height: 280,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                              width: 200,
                              child: Image.network(
                                sendMessage,
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          TextField(
                            controller: customController,
                            decoration: InputDecoration(
                              hintText: "أدخل نص الرسالة",
                              hintStyle: TextStyle(
                                  fontFamily: 'ALMARAI',
                                  fontSize: 15,
                                  color: TFmyGray),
                            ),
                          ),
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
                  "ارسال",
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

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            //  mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: Column(
                children: [
                  Image.network(contactUS,
                      height: screenHeight * 0.45, width: screenWidth * 0.75),
                  const Spacer(
                    flex: 2,
                  ),
                  Cards(context, "مكالمة طوارئ", Icons.add_ic_call, Colors.red),
                  const SizedBox(
                    height: 10,
                  ),
                  Cards(context, "ارسال رسالة", Icons.question_answer,
                      Colors.blue),
                  const SizedBox(
                    height: 10,
                  ),
                  // Cards(context, "مراسلة فورية", Icons.reviews, Colors.green),
                  const Spacer(
                    flex: 1,
                  ),
                ],
              ))
            ],
          ),
        ),
      ],
    );
  }

  Padding Cards(BuildContext context, String text, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        //color: Colors.red,
        height: 50,
        child: TextButton(
          onPressed: () async {
            if (text == "مكالمة طوارئ") {
              FlutterPhoneDirectCaller.callNumber(PHnumber);
            } else if (text == "ارسال رسالة") {
              sendMessageDialog(context);
            }
          },
          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(color)),
          child: Row(
            children: <Widget>[
              const SizedBox(
                width: 15,
              ),
              Icon(
                icon,
                color: Colors.white,
              ),
              const SizedBox(
                width: 25,
              ),
              Text(
                text,
                style: TextStyle(
                    color: Colors.white, fontFamily: myOtherFont, fontSize: 16),
              ),
              const Spacer(
                flex: 1,
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                size: 20,
              ),
              const SizedBox(
                width: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
