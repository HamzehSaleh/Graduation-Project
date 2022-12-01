import 'dart:convert';

import 'package:draw_graph/draw_graph.dart';
import 'package:draw_graph/models/feature.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:sampleproject/APIs/fetchData.dart';
import 'package:sampleproject/APIs/models/userModel.dart';
import 'package:sampleproject/User/screens/mainScreen/serviceCards/myCalc_Folder/myCalc.dart';
import 'package:sampleproject/myadditional_folder/constants.dart';
import 'package:http/http.dart' as http;

class consumption_employee extends StatefulWidget {
  const consumption_employee({Key? key}) : super(key: key);

  @override
  State<consumption_employee> createState() => _newSubBodyState();
}

class _newSubBodyState extends State<consumption_employee> {
  // Future ConsumpData() async {
  //   var res = await http.get(Uri.parse(FetchData.baseURL + "/users"));
  //   var body = jsonDecode(res.body) as List<dynamic>;
  //   body.map((data) => {
  //     userModel.fromJson(data),

  //   });

  //   print(body);
  // }

  final Color darkBlue = Color.fromARGB(255, 15, 28, 42);

  final List<double> fromDB_List = [
    20339248,
    26339248,
    28339248,
    18423942,
    34358232,
    45232153,
    43537989,
    25339248,
    9334523,
    9663213,
    8235234,
    8398723,
  ];
  List<double> convert_List = [];

  void convertFun() {
    double result = 0;
    int retval = 1;
    int x = 10;
    for (int i = 0; i < 6; i++) {
      retval *= x;
    }
    // double tst;
    for (int i = 0; i < fromDB_List.length; i++) {
      convert_List.add((fromDB_List.elementAt(i) / retval) / 55);
      //  tst = (fromDB_List.elementAt(i) / retval) / 55;
      // print(tst);
    }

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // ConsumpData();
    convertFun();
  }

  late final List<Feature> features = [
    Feature(
      title: "الاستهلاك الشهري لجميع الاشتراكات",
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
                  "عزيزي الموظف\nيظهر هنا استهلاك الكهرباء لجميع الاشتراكات كل شهر على حدا.",
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
                      "6",
                      "12",
                      "18",
                      "24",
                      "30",
                      "36",
                      "42",
                      "",
                      "جيجا واط",
                    ],
                    showDescription: true,
                    graphColor: darkBlue,
                    graphOpacity: 0.4,
                    verticalFeatureDirection: true,
                    descriptionHeight: 130,
                    fontFamily: myOtherFont,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
