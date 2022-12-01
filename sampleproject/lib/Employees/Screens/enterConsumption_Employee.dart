import 'dart:convert';

import 'package:draw_graph/draw_graph.dart';
import 'package:draw_graph/models/feature.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';
import 'package:sampleproject/APIs/fetchData.dart';
import 'package:sampleproject/Custom_widgets/CustomTextField.dart';
import 'package:http/http.dart' as http;
import 'package:sampleproject/myadditional_folder/constants.dart';

class enterConsumption_employee extends StatefulWidget {
  const enterConsumption_employee({Key? key}) : super(key: key);

  @override
  State<enterConsumption_employee> createState() =>
      _enterConsumption_employeeState();
}

late int minMonth = 0;

late final List<monthsClass> fromExcel_List = [
  //monthsClass(1, 44333),
  //monthsClass(2, 1533),
  //monthsClass(3, 6533),
  //monthsClass(4, 8033),
  //monthsClass(5, 6533),
  //monthsClass(6, 6533),
  //monthsClass(7, 70533),
  //monthsClass(8, 52533),
  //monthsClass(9, 6933),
  //monthsClass(10, 52533),
  //monthsClass(11, 65433),
  //monthsClass(12, 5533),
];
List<double> dataToFill = [];

class _enterConsumption_employeeState extends State<enterConsumption_employee> {
  late TextEditingController month1;
  late TextEditingController month2;
  late TextEditingController month3;
  late TextEditingController month4;
  late TextEditingController month5;
  late TextEditingController month6;
  late TextEditingController month7;
  late TextEditingController month8;
  late TextEditingController month9;
  late TextEditingController month10;
  late TextEditingController month11;
  late TextEditingController month12;

  final Color darkBlue = Color.fromARGB(255, 15, 28, 42);

  String mostConsMon = "لا يوجد بيانات ( أدخل الاستهلاك وحاول من جديد)";

  SlidingUpPanelController panelController = SlidingUpPanelController();

  late ScrollController scrollController;
  TextEditingController textarea = TextEditingController();

  TextEditingController myController = new TextEditingController();

  @override
  void initState() {
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.offset >=
              scrollController.position.maxScrollExtent &&
          !scrollController.position.outOfRange) {
        panelController.expand();
      } else if (scrollController.offset <=
              scrollController.position.minScrollExtent &&
          !scrollController.position.outOfRange) {
        panelController.anchor();
      } else {}
    });
    dataToFill = [];

    // getMostMonths(fromExcel_List);
    month1 = new TextEditingController();
    month2 = new TextEditingController();
    month3 = new TextEditingController();
    month4 = new TextEditingController();
    month5 = new TextEditingController();
    month6 = new TextEditingController();
    month7 = new TextEditingController();
    month8 = new TextEditingController();
    month9 = new TextEditingController();
    month10 = new TextEditingController();
    month11 = new TextEditingController();
    month12 = new TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        Column(
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
                      "عزيزي الموظف\nقم بادخال بيانات الاستهلاك الخاصة بالسنة الماضية لتحليل النتائج، حتى يقوم النظام بتوفير حلول بناءا عليها.",
                      style: TextStyle(
                        fontFamily: myOtherFont,
                        color: darkBlue,
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      "أعلى اشهر استهلاك هي: $mostConsMon ",
                      style: TextStyle(
                        fontFamily: myOtherFont,
                        color: darkBlue,
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    FlatButton(
                      color: Colors.transparent,
                      splashColor: Colors.black26,
                      onPressed: () {
                        panelController.expand();
                      },
                      child: Align(
                          alignment: Alignment.topRight,
                          child: Row(
                            children: [
                              Icon(
                                Icons.equalizer,
                                color: myMainColor,
                              ),
                              const Spacer(),
                              Text(
                                "اضغط هنا لادخال معدلات الاستهلاك",
                                //textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: myMainColor,
                                  fontFamily: 'ALMARAI',
                                  fontSize: 13,
                                ),
                              ),
                              const Spacer(flex: 15),
                            ],
                          )),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        SlidingUpPanelWidget(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 0),
            decoration: const ShapeDecoration(
              color: Colors.white,
              shadows: [
                BoxShadow(
                    blurRadius: 5.0,
                    spreadRadius: 2.0,
                    color: Color(0x11000000))
              ],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
              ),
            ),
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  child: Row(
                    children: const <Widget>[
                      Icon(
                        Icons.menu,
                        size: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 8.0,
                        ),
                      ),
                      Text(
                        'اغلاق النافذة',
                        style: TextStyle(fontFamily: myOtherFont, fontSize: 12),
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                  height: 50.0,
                ),
                Divider(
                  height: 0.5,
                  color: Colors.grey[300],
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      // alignment: Alignment.topRight,
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Column(
                          children: [
                            sliderRow(
                                screenWidth, "شهر 1", "شهر 2", month1, month2),
                            sliderRow(
                                screenWidth, "شهر 3", "شهر 4", month3, month4),
                            sliderRow(
                                screenWidth, "شهر 5", "شهر 6", month5, month6),
                            sliderRow(
                                screenWidth, "شهر 7", "شهر 8", month7, month8),
                            sliderRow(screenWidth, "شهر 9", "شهر 10", month9,
                                month10),
                            sliderRow(screenWidth, "شهر 11", "شهر 12", month11,
                                month12),
                            const Spacer(),
                            ElevatedButton(
                              onPressed: () {
                                // mostConsMon = "شهر 6 + شهر 7 + شهر 8";
                                // setState(() {});
                                SaveConsump();
                                panelController.collapse();

                                // panelController.hide();
                              },
                              child: Text(
                                'حفظ واغلاق',
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
                                      borderRadius: BorderRadius.circular(10))),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
              mainAxisSize: MainAxisSize.min,
            ),
          ),
          controlHeight: 0,
          anchor: 0.4,
          panelController: panelController,
          onTap: () {
            ///Customize the processing logic
            if (SlidingUpPanelStatus.expanded == panelController.status) {
              panelController.collapse();
            } else {
              //  panelController.expand();
            }
          },
          enableOnTap: true, //Enable the onTap callback for control bar.
          //dragDown: (details) {
          //  print('dragDown');
          //},
          //dragStart: (details) {
          //  print('dragStart');
          //},
          //dragCancel: () {
          //  print('dragCancel');
          //},
          //dragUpdate: (details) {
          //  print(
          //      'dragUpdate,${panelController.status == SlidingUpPanelStatus.dragging ? 'dragging' : ''}');
          //},
          //dragEnd: (details) {
          //  print('dragEnd');
          //},
        ),
      ],
    );
  }

  Row sliderRow(double screenWidth, String month1, String month2, controller1,
      controller2) {
    return Row(
      children: [
        myTextField(screenWidth * 0.4, month1, controller1),
        SizedBox(
          width: 20,
        ),
        myTextField(screenWidth * 0.4, month2, controller2)
      ],
    );
  }

  SizedBox myTextField(
      double screenWidth, String hint, TextEditingController _contoroller) {
    switch (hint) {
      case 'شهر 1':
    }

    return SizedBox(
      width: screenWidth,
      child: TextFormField(
        decoration: InputDecoration(
            hintText: hint,
            hintStyle:
                TextStyle(fontFamily: 'ALMARAI', fontSize: 13, color: TFmyGray),
            prefixIcon: Icon(
              Icons.equalizer,
              size: 20,
            )),
        validator: (value) {
          if (value == "") {
            return "fill plz";
          } else if (value == " ") {
            return "fill plz";
          }
          return "";
        },
        controller: _contoroller,
        keyboardType: TextInputType.number,
      ),

      //child: TextField(
      //  keyboardType: keyboardType,
      //  decoration: InputDecoration(
      //      prefixIcon: Icon(icon),
      //      hintText: hint,
      //      hintStyle: TextStyle(
      //          fontFamily: 'ALMARAI', fontSize: 15, color: TFmyGray)),
      //),
    );
  }

  void getMostMonths(List<monthsClass> Excel_List) {
    monthsClass months_Class;

    Excel_List.sort((a, b) => a.cons.compareTo(b.cons));
    print(Excel_List.elementAt(0).getMonth());
    mostConsMon = "${Excel_List.elementAt(9).getMonth()}+ "
        "${Excel_List.elementAt(10).getMonth()} "
        "+${Excel_List.elementAt(11).getMonth()} ";

    minMonth = Excel_List.elementAt(9).getMonth();
    print(minMonth);
    setState(() {});
  }

  Future<void> SaveConsump() async {
    dataToFill.add(double.parse(month1.text));
    dataToFill.add(double.parse(month2.text));
    dataToFill.add(double.parse(month3.text));
    dataToFill.add(double.parse(month4.text));
    dataToFill.add(double.parse(month5.text));
    dataToFill.add(double.parse(month6.text));
    dataToFill.add(double.parse(month7.text));
    dataToFill.add(double.parse(month8.text));
    dataToFill.add(double.parse(month9.text));
    dataToFill.add(double.parse(month10.text));
    dataToFill.add(double.parse(month11.text));
    dataToFill.add(double.parse(month12.text));

    print(dataToFill);

    for (int i = 1; i < 13; i++) {
      fromExcel_List.add(monthsClass(i, dataToFill.elementAt(i - 1)));
    }
    getMostMonths(fromExcel_List);

    fromExcel_List.clear();

    var consumpValues = [
      month1.text,
      month2.text,
      month3.text,
      month4.text,
      month5.text,
      month6.text,
      month7.text,
      month8.text,
      month9.text,
      month10.text,
      month11.text,
      month12.text,
    ];

    var body1 = jsonEncode(
        {'allConsump': consumpValues, 'minMonth': minMonth.toString()});

    var res = await http.post(Uri.parse(FetchData.baseURL + "/consump"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body1);

    print(res.statusCode);

    Clear();
  }

  void Clear() {
    month1.text = "";
    month2.text = "";
    month3.text = "";
    month4.text = "";
    month5.text = "";
    month6.text = "";
    month7.text = "";
    month8.text = "";
    month9.text = "";
    month10.text = "";
    month11.text = "";
    month12.text = "";
  }
}

class monthsClass {
  late int month;
  late double cons;

  monthsClass(this.month, this.cons);

  int getMonth() {
    return month;
  }

  double getCons() {
    return cons;
  }
}
