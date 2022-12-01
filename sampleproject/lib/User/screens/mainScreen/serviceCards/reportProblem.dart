import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import 'package:geolocator/geolocator.dart';
import 'package:sampleproject/APIs/fetchData.dart';
import 'package:sampleproject/Custom_widgets/CustomButton.dart';

import 'package:sampleproject/Custom_widgets/CustomFlatButton_Icon.dart';
import 'package:sampleproject/Custom_widgets/CustomTextField.dart';
import 'package:sampleproject/User/screens/mainScreen/mainScreen.dart';
import 'package:sampleproject/User/screens/mainScreen/widgets/mainScreen_body.dart';
import 'package:sampleproject/bar/buttomNavBar.dart';

import 'package:sampleproject/myadditional_folder/constants.dart';

import '../../../../main.dart';
import '../../chargingPoints/myChargingPoints.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class reportProblemClass extends StatefulWidget {
  @override
  _reportProblemClassState createState() => _reportProblemClassState();
}

class _reportProblemClassState extends State<reportProblemClass> {
  final problem_type_array = [
    "قطع في الاسلاك",
    "تلف العداد",
    "سقوط عامود",
    "تلف في الكابل",
    "انارة غير مضيئة",
    "غير ذلك",
  ];
  final building_type_array = [
    "منزل",
    "محل تجاري",
    "مؤسسة / مكتب",
    "مزرعة",
    "معمل",
    "مركز صحي",
    "غير ذلك",
  ];

  late String ImageData = "";
  late File imageFile;

  late String problemName = "";
  late String problemType = "";
  TextEditingController problemDesc = TextEditingController();

  static final DateTime now = DateTime.now();
  static final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final String formatted = formatter.format(now);

  // for DB ----------->

  // save lat and long from these vars -- > myPosition_lat / myPosition_long

  // ------------

  String? problem_value;
  String? building_value;

  late double Lat;
  late double Long;

  pickImage(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage == null) return;

      setState(() {
        this.imageFile = File(pickedImage.path);
        // print(ImageName);
      });
      ImageData = base64Encode(imageFile.readAsBytesSync());

      return ImageData;
    } on PlatformException catch (e) {
      print("catch picker");
      return null;
    }
  }

  showImage(String image) {
    return Image.memory(base64Decode(image));
  }

  var locationMessage = "";

  void getCurrentLocation() async {
    var position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    var lastPosition = await Geolocator().getLastKnownPosition();
    // print(lastPosition);

    Lat = position.latitude;
    Long = position.longitude;
    print("$Lat,$Long");

    setState(() {
      locationMessage = "latitude :$Lat , longitude:$Long";
    });
  }

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
          value: item,
          child: Text(
            item,
            style: TextStyle(fontFamily: myOtherFont, fontSize: 14),
          ),
        );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: myBackColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
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
        centerTitle: true,
        title: const Text(
          "الابلاغ عن مشكلة",
          style: TextStyle(
              fontFamily: "ALMARAI", color: myMainColor, fontSize: 18),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                const Spacer(
                  flex: 2,
                ),
                const Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    "تقديم شكوى",
                    style: TextStyle(
                        fontFamily: "ALMARAI",
                        color: myMainColor,
                        fontSize: 19,
                        fontWeight: FontWeight.bold),
                  ),
                ),

                const Spacer(
                  flex: 1,
                ),
                Row(
                  children: [
                    const Text(
                      "موضوع الشكوى",
                      style: TextStyle(
                          fontFamily: "ALMARAI", color: myGray, fontSize: 16),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                            hint: Text("اسلاك مقطوعة", style: style()),
                            items:
                                problem_type_array.map(buildMenuItem).toList(),
                            value: problem_value,
                            onChanged: (value) => {
                                  setState(
                                    () => this.problem_value = value,
                                  ),
                                  problemName = value.toString(),
                                }),
                      ),
                    ),
                    Spacer(
                      flex: 3,
                    ),
                  ],
                ),

                const Spacer(
                  flex: 1,
                ),
                Row(
                  children: [
                    Text(
                      "نوع العقار",
                      style: TextStyle(
                          fontFamily: "ALMARAI", color: myGray, fontSize: 16),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                            items:
                                building_type_array.map(buildMenuItem).toList(),
                            value: building_value,
                            hint: Text(
                              "منزل",
                              style: style(),
                            ),
                            onChanged: (value) => {
                                  setState(() => this.building_value = value),
                                  problemType = value.toString(),
                                }),
                      ),
                    ),
                    Spacer(
                      flex: 3,
                    ),
                  ],
                ),
                const Spacer(
                  flex: 2,
                ),
                const Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    "تفاصيل المشكلة",
                    style: TextStyle(
                        fontFamily: "ALMARAI", color: myGray, fontSize: 16),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                // timeline here
                myCustomTextField(
                  icon: Icons.report_problem,
                  hint: "أدخل تفاصيل المشكلة (اختياري )",
                  controller: problemDesc,
                ),
                const Spacer(
                  flex: 1,
                ),

                //FlatButton(
                //  color: Colors.transparent,
                //  splashColor: Colors.black26,
                //  onPressed: () {
                //    getCurrentLocation();
                //  },
                //  child: Align(
                //      alignment: Alignment.topRight,
                //      child: Row(
                //        children: const [
                //          Icon(
                //            Icons.add_location,
                //            color: myMainColor,
                //          ),
                //          Spacer(),
                //          Text(
                //            "ارسل احداثيات موقعك الحالي",
                //            //textAlign: TextAlign.left,
                //            style: TextStyle(
                //              color: myMainColor,
                //              fontFamily: 'ALMARAI',
                //              fontSize: 13,
                //            ),
                //          ),
                //          Spacer(flex: 15),
                //        ],
                //      )),
                //),

                FlatButton_Picker(
                    "قم بادراج صورة المشكلة", Icons.image, ImageSource.gallery),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                  child: Row(
                    children: [
                      Text(
                        "أو",
                        style: TextStyle(fontFamily: myOtherFont),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),

                FlatButton_Picker("التقاط صورة جديدة", Icons.photo_camera,
                    ImageSource.camera),

                PickedImages(),
                const Spacer(
                  flex: 4,
                ),

                myCustomButton(
                  text: "ارسال الشكوى",
                  toClass: buttomNavBarClass(),
                  Fun: ReportProblem,
                ),

                // ElevatedButton(
                //     onPressed: () async {
                //       //  ReportProblem();
                //     },
                //     child: Text("سجل")),

                const Spacer(
                  flex: 5,
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }

  Widget PickedImages() {
    return ImageData == "" ? Text("لم يتم ادراج صورة") : showImage(ImageData);
  }

  TextStyle style() {
    return TextStyle(fontFamily: "ALMARAI", fontSize: 13);
  }

  FlatButton FlatButton_Picker(String text, IconData icon, ImageSource source) {
    return FlatButton(
      color: Colors.transparent,
      splashColor: Colors.black26,
      onPressed: () {
        pickImage(source);
      },
      child: Align(
          alignment: Alignment.topRight,
          child: Row(
            children: [
              Icon(
                icon,
                color: myMainColor,
              ),
              const Spacer(),
              Text(
                text,
                //textAlign: TextAlign.left,
                style: TextStyle(
                  color: myGray,
                  fontFamily: 'ALMARAI',
                  fontSize: 13,
                ),
              ),
              const Spacer(flex: 15),
            ],
          )),
    );
  }

  Future<void> ReportProblem() async {
    var body1 = jsonEncode({
      "name": problemName,
      "description": problemDesc.text.trim(),
      "problem_type": problemType,
      "photo": ImageData,
      "problem_date": formatted,
      "lat": Lat,
      "long": Long,
    });

    var res = await http.post(Uri.parse(FetchData.baseURL + "/problems"),
        headers: {
          "Authorization": "Bearer " + prefs.get("token").toString(),
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: body1);

    print(res.body);

    if (res.statusCode == 201) {
      print("problem successfully sent");
    } else {
      print("problem can't be sent ");
    }
  }
}
