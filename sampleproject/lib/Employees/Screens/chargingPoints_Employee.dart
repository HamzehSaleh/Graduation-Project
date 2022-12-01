import 'dart:collection';
//import 'dart:ffi';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:day_picker/day_picker.dart';
import 'package:day_picker/model/day_in_week.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sampleproject/APIs/fetchData.dart';
import 'package:sampleproject/Custom_widgets/CustomFlatButton_Icon.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:day_night_time_picker/lib/constants.dart';
import 'package:sampleproject/myadditional_folder/constants.dart';
import 'package:http/http.dart' as http;
import '../../APIs/models/chargingPoint.dart';

class chargingPoints_body_admin extends StatefulWidget {
  const chargingPoints_body_admin({Key? key}) : super(key: key);

  @override
  State<chargingPoints_body_admin> createState() =>
      _chargingPoints_body_adminState();
}

class _chargingPoints_body_adminState extends State<chargingPoints_body_admin> {
  FetchData _fetchData = FetchData();

  List<DayInWeek> _days = [
    DayInWeek(
      "سبت",
      isSelected: true,
    ),
    DayInWeek(
      "أحد",
      isSelected: true,
    ),
    DayInWeek(
      "اثنين",
      isSelected: true,
    ),
    DayInWeek(
      "ثلاثاء",
      isSelected: true,
    ),
    DayInWeek(
      "اربعاء",
      isSelected: true,
    ),
    DayInWeek("خميس", isSelected: true),
    DayInWeek("جمعة", isSelected: false),
  ];

  TimeOfDay open_time = TimeOfDay.now().replacing(hour: 11, minute: 30);
  TimeOfDay close_time = TimeOfDay.now().replacing(hour: 11, minute: 30);
  bool iosStyle = true;

  String? start_value;
  String? close_value;

  var locationMessage = "";
  double lat = 32.309758;
  double long = 35.024802;

  late GoogleMapController gmc;

  static const CameraPosition initialCameraPosition =
      CameraPosition(target: LatLng(32.309758, 35.024802), zoom: 17);

  addNameDialog(BuildContext context, String hint, String title) {
    TextEditingController customController = new TextEditingController();

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              title,
              style: const TextStyle(fontFamily: myOtherFont, fontSize: 14),
            ),
            content: TextField(
              controller: customController,
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(
                    fontFamily: 'ALMARAI', fontSize: 15, color: TFmyGray),
              ),
            ),
            actions: <Widget>[
              MaterialButton(
                elevation: 5.0,
                child: Text(
                  "حفظ",
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

  createAlertDialog(BuildContext context, String hint, String title) {
    Set<Marker> mymarker = {
      Marker(
        visible: true,
        markerId: MarkerId("1"),
        infoWindow: InfoWindow(
            title: "1",
            onTap: () {
              print("2");
            }),
        position: LatLng(lat, long),
      )
    };

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    TextEditingController customController = new TextEditingController();

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              title,
              style: const TextStyle(
                  fontFamily: myOtherFont, fontSize: 14, color: myMainColor),
            ),
            content: Container(
              height: screenHeight * 0.4,
              child: Column(
                children: [
                  Container(
                    width: screenWidth,
                    height: screenHeight * 0.4,
                    child: GoogleMap(
                      markers: mymarker,
                      mapType: MapType.satellite,
                      initialCameraPosition:
                          CameraPosition(target: LatLng(lat, long), zoom: 17),
                      onTap: (LatLng) {
                        print(mymarker);
                        Marker marker = mymarker.firstWhere(
                            (marker) => marker.markerId.value == "1");
                        setState(() {
                          mymarker.remove(marker);
                        });

                        mymarker.add(
                            Marker(markerId: MarkerId("1"), position: LatLng));
                        setState(() {
                          lat = LatLng.latitude;
                          long = LatLng.longitude;
                        });
                      },
                      onMapCreated: (GoogleMapController controller) {
                        gmc = controller;
                      },
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              MaterialButton(
                elevation: 5.0,
                child: Text(
                  "حفظ",
                  style: const TextStyle(
                      fontFamily: myOtherFont, color: myMainColor),
                ),
                onPressed: () {
                  Navigator.of(context).pop(customController.text.toString());
                },
              ),
            ],
          );
        });
  }

  addChargingPointsDialog(BuildContext context, String title) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    TextEditingController customController = new TextEditingController();

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              title,
              style: const TextStyle(
                  fontFamily: myOtherFont, fontSize: 14, color: myMainColor),
            ),
            content: Container(
              height: screenHeight * 0.6,
              width: screenWidth,
              child: Column(
                children: [
                  Expanded(
                      child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // chargingPointsCard(
                        //     screenHeight,
                        //     screenWidth,
                        //     "مركز طولكرم",
                        //     "09:00 AM",
                        //     "04:00 PM",
                        //     " احد اثنين ثلاثاء ارعباء خميس"),
                        fetchAllPoints(),
                      ],
                    ),
                  )),
                ],
              ),
            ),
            actions: <Widget>[
              MaterialButton(
                elevation: 5.0,
                child: Text(
                  "حفظ",
                  style: const TextStyle(
                      fontFamily: myOtherFont, color: myMainColor),
                ),
                onPressed: () {
                  Navigator.of(context).pop(customController.text.toString());
                },
              ),
            ],
          );
        });
  }

  Padding chargingPointsCard(
      String name, String openTime, String closeTime, String days, String _id) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.19,
        width: MediaQuery.of(context).size.width,
        color: Color.fromARGB(155, 243, 240, 240),
        child: Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Row(
              children: [
                Column(
                  children: [
                    Spacer(),
                    Text(
                      "اسم المركز: " + name,
                      style: chargingPointsStyle(),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      "وقت الفتح: " + openTime,
                      style: chargingPointsStyle(),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      "وقت الاغلاق: " + closeTime,
                      style: chargingPointsStyle(),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      "الايام: " + days,
                      style: chargingPointsStyle(),
                    ),
                    Spacer(),
                  ],
                ),
                Spacer(
                  flex: 1,
                ),
                PopupMenuButton(
                    itemBuilder: (context) => [
                          popupMenu("حذف", _id),
                          popupMenu("تعديل وقت الفتح", _id),
                          popupMenu("تعديل وقت الاغلاق", _id),
                          popupMenu("تعديل ايام الدوام", _id),
                        ])
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextStyle chargingPointsStyle() =>
      TextStyle(fontFamily: myOtherFont, fontSize: 13);

  void onTimeChanged_open(TimeOfDay newTime) {
    setState(() {
      open_time = newTime;
    });
  }

  void onTimeChanged_close(TimeOfDay newTime) {
    setState(() {
      close_time = newTime;
    });
  }

  void getCurrentLocation() async {
    var position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    var lastPosition = await Geolocator().getLastKnownPosition();
    print(lastPosition);

    double n_lat = position.latitude;
    double n_long = position.longitude;
    print("$lat,$long");

    setState(() {
      lat = n_lat;
      long = n_long;
      locationMessage = "latitude :$lat , longitude:$long";
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchData.allChargingPoints();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    Set<Marker> mymarker = {
      Marker(
        visible: true,
        markerId: MarkerId("1"),
        infoWindow: InfoWindow(
            title: "1",
            onTap: () {
              print("2");
            }),
        position: LatLng(lat, long),
      )
    };

    DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
          value: item,
          child: Text(
            item,
            style: TextStyle(fontFamily: myOtherFont, fontSize: 14),
          ),
        );
    return Column(
      //  mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
            child: Stack(
          children: [
            Container(
              width: screenWidth,
              height: screenHeight * 0.35,
              child: GoogleMap(
                mapType: MapType.satellite,
                initialCameraPosition:
                    CameraPosition(target: LatLng(lat, long), zoom: 17),
                onMapCreated: (GoogleMapController googleMapController) {
                  setState(() {
                    mymarker.add(Marker(
                      markerId: MarkerId("1"),
                      position: LatLng(lat, long),
                    ));
                  });
                },
                markers: mymarker,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: screenHeight * 0.48,
                  width: screenWidth,

                  decoration: const BoxDecoration(
                    boxShadow: [
                      //background color of box
                      BoxShadow(
                        color: Color.fromARGB(77, 160, 157, 157),
                        blurRadius: 20.0, // soften the shadow
                        spreadRadius: 1.0, //extend the shadow
                        offset: Offset(
                          2.0, // Move to right 10  horizontally
                          2.0, // Move to bottom 10 Vertically
                        ),
                      )
                    ],
                    //borderRadius: BorderRadius.circular(0),
                    color: Color(0xffFBFDFF),
                  ),

                  // color: Color(0xffFBFDFF),
                  // color: Colors.red,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "اضافة مركز جديد",
                        style: TextStyle(
                            fontFamily: myOtherFont,
                            fontSize: 18,
                            color: myMainColor),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            const Spacer(
                              flex: 1,
                            ),
                            addChargingPointNameButton(context),
                            Row(
                              children: [
                                Start_and_END_Method(screenWidth, "وقت الفتح",
                                    open_time.format(context), Colors.white),
                                Start_and_END_Method(
                                    screenWidth,
                                    "وقت الاغلاق",
                                    close_time.format(context),
                                    Color.fromARGB(63, 22, 115, 191))
                              ],
                            ),
                            const Spacer(
                              flex: 3,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Container(
                                height: screenHeight * 0.1,
                                child: SelectWeekDays(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  days: _days,
                                  border: false,
                                  boxDecoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30.0),
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      // 10% of the width, so there are ten blinds.
                                      colors: [
                                        myMainColor,
                                        myMainColor.withOpacity(0.7)
                                      ], // whitish to gray
                                      tileMode: TileMode
                                          .repeated, // repeats the gradient over the canvas
                                    ),
                                  ),
                                  onSelect: (values) {
                                    print(values);
                                  },
                                ),
                              ),
                            ),
                            const Spacer(
                              flex: 1,
                            ),
                            showChargingPointsButton(context),
                            const Spacer(
                              flex: 1,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                //Navigator.push(
                                //  context,
                                //  MaterialPageRoute(builder: (context) => toClass),
                                //);
                              },
                              child: Text(
                                "تأكيد و حفظ",
                                style: const TextStyle(
                                  fontFamily: myOtherFont,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                  shadowColor: Colors.black,
                                  elevation: 3,
                                  primary: myMainColor,
                                  fixedSize: Size(
                                      screenWidth * 0.9, screenWidth * 0.03),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  0, 0, screenWidth * 0.15, (screenHeight * 0.48 - 30)),
              child: Align(
                alignment: Alignment.bottomRight,
                child: GestureDetector(
                  onTap: () {
                    createAlertDialog(
                        context, "hint", "تحديد موقع مركز الشحن الجديد");
                  },
                  child: Container(
                    width: 60.0,
                    height: 60.0,
                    decoration: new BoxDecoration(
                      color: Color(0xff7591FF),
                      shape: BoxShape.circle,
                    ),
                    child: Column(children: const [
                      Spacer(),
                      Icon(
                        Icons.near_me,
                        color: Colors.white,
                        size: 35,
                      ),
                      Spacer(),
                    ]),
                  ),
                ),
              ),
            ),
          ],
        ))
      ],
    );
  }

  FlatButton addChargingPointNameButton(BuildContext context) {
    return FlatButton(
      color: Colors.transparent,
      splashColor: Colors.black26,
      onPressed: () {
        addNameDialog(context, "أدخل اسم المركز", "اضافة اسم مركز الشحن");
      },
      child: Align(
          alignment: Alignment.topRight,
          child: Row(
            children: const [
              Icon(
                Icons.drive_file_rename_outline,
                color: myMainColor,
              ),
              Spacer(),
              Text(
                "اضافة اسم مركز الشحن",
                //textAlign: TextAlign.left,
                style: TextStyle(
                  color: Color.fromARGB(173, 36, 35, 35),
                  fontFamily: 'ALMARAI',
                  fontSize: 13,
                ),
              ),
              Spacer(flex: 15),
            ],
          )),
    );
  }

  FlatButton showChargingPointsButton(BuildContext context) {
    return FlatButton(
      color: Colors.transparent,
      splashColor: Colors.black26,
      onPressed: () {
        addChargingPointsDialog(context, "تعديل مركز موجود");
      },
      child: Align(
          alignment: Alignment.topRight,
          child: Row(
            children: [
              Icon(
                Icons.apartment,
                color: myMainColor,
              ),
              const Spacer(),
              Text(
                "عرض مراكز الشحن الموجودة",
                //textAlign: TextAlign.left,
                style: TextStyle(
                  color: Color.fromARGB(173, 36, 35, 35),
                  fontFamily: 'ALMARAI',
                  fontSize: 13,
                ),
              ),
              const Spacer(flex: 15),
            ],
          )),
    );
  }

  GestureDetector Start_and_END_Method(
      double screenWidth, String title, String time, Color color) {
    return GestureDetector(
      onTap: () {
        if (title == "وقت الفتح") {
          Navigator.of(context).push(
            showPicker(
              context: context,

              value: open_time,
              onChange: onTimeChanged_open,
              minuteInterval: MinuteInterval.FIVE,
              // Optional onChange to receive value as DateTime
              onChangeDateTime: (DateTime dateTime) {
                print(dateTime);
              },
            ),
          );
        } else if (title == "وقت الاغلاق") {
          Navigator.of(context).push(
            showPicker(
              context: context,

              value: close_time,
              onChange: onTimeChanged_close,
              minuteInterval: MinuteInterval.FIVE,
              // Optional onChange to receive value as DateTime
              onChangeDateTime: (DateTime dateTime) {
                print(dateTime);
              },
            ),
          );
        }
      },
      child: Container(
        width: screenWidth / 2,
        color: color,
        child: Column(children: [
          //Spacer(),
          SizedBox(
            height: 10,
          ),
          Text(
            title,
            style: TextStyle(
                fontFamily: myOtherFont, color: Colors.blue, fontSize: 13),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            time,
            style: TextStyle(
                fontFamily: myOtherFont, color: Colors.black, fontSize: 13),
          ),

          SizedBox(
            height: 10,
          )
          //Spacer(),
        ]),
      ),
    );
  }

  PopupMenuItem<int> popupMenu(String text, String _id) {
    return PopupMenuItem(
      child: Row(
        children: [
          Text(
            text,
            style: TextStyle(fontFamily: myOtherFont, fontSize: 13),
          ),
        ],
      ),
      value: 2,
      onTap: () {
        switch (text) {
          case "حذف":
            {
              DeletePoint(_id);
              setState(() {});
            }
            break;
        }
      },
    );
  }

  Widget fetchAllPoints() {
    return FutureBuilder(
      future: _fetchData.allChargingPoints(),
      builder: (context, snapchot) {
        var points = snapchot.data as List<chargingPointModel>;
        return snapchot.data == null
            ? Text("جاري التحميل")
            : ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: points == null ? 0 : points.length,
                itemBuilder: (context, index) {
                  return chargingPointsCard(
                      points[index].name,
                      points[index].open,
                      points[index].close,
                      points[index].days,
                      points[index].id);
                });
      },
    );
  }

  Future<void> DeletePoint(id) async {
    var pointID = FetchData.baseURL + "/chargingPoint/" + id.toString();
    var res = await http.delete(
      Uri.parse(pointID),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print(res.statusCode);
  }
}
