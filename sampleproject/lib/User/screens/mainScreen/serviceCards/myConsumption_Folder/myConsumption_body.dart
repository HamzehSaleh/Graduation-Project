import 'package:draw_graph/draw_graph.dart';
import 'package:draw_graph/models/feature.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:sampleproject/User/screens/mainScreen/serviceCards/myCalc_Folder/myCalc.dart';
import 'package:sampleproject/myadditional_folder/constants.dart';

import '../../widgets/mainScreen_body.dart';

class myConsumption_body extends StatefulWidget {
  const myConsumption_body({Key? key}) : super(key: key);

  @override
  State<myConsumption_body> createState() => _newSubBodyState();
}

class _newSubBodyState extends State<myConsumption_body> {
  final Color darkBlue = Color.fromARGB(255, 15, 28, 42);

  List<double> convert_List = [];

  void convertFun() {
    double result = 0;
    for (int i = 0; i < consump.length; i++) {
      convert_List.add(consump.elementAt(i) / 3000);
    }
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    convertFun();
  }

  late final List<Feature> features = [
    Feature(
      title: "الاستهلاك الشهري",
      color: Color.fromARGB(255, 1, 124, 186),
      data: convert_List,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  "عزيزي المواطن:\nالمعدل العام لاستهلاك الاسرة في الشهر هو 821 كيلو واط وتظهر هنا تقارير على هذا الاساس، لتعديل هذه البيانات والحصول على نتائج أدق يرجى التوجه الى صفحة حاسبتي.",
                  style: TextStyle(
                    fontFamily: myOtherFont,
                    color: darkBlue,
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: LineGraph(
                    features: features,
                    size: Size(screenWidth, screenHeight * 0.6),
                    labelX: [
                      "1",
                      "2",
                      "3",
                      "4",
                      "5",
                      "6",
                      "7",
                      "8",
                      "9",
                      "10",
                      "11",
                      "12",
                      "    الشهر"
                    ],
                    labelY: [
                      "300",
                      "600",
                      "900",
                      "1200",
                      "1500",
                      "1800",
                      "2100",
                      "2400",
                      "2700",
                      "3000",
                      "",
                      "كيلو واط",
                    ],
                    showDescription: true,
                    graphColor: darkBlue,
                    graphOpacity: 0.4,
                    verticalFeatureDirection: true,
                    descriptionHeight: 130,
                    fontFamily: myOtherFont,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (sub_number == "0") {
                      //createDialog(context, "رقم الاشتراك مطلوب");
                      _displayWarningMotionToast();
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => myCalcClass()),
                      );
                    }

                    //Navigator.push(
                    //  context,
                    //  MaterialPageRoute(builder: (context) => myCalcClass()),
                    //);
                  },
                  child: Text(
                    "الانتقال الى صفحة حاسبتي",
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
                )
              ],
            ),
          ),
        ),
      ],
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
