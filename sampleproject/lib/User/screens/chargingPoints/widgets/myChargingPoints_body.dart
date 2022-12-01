import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';
import 'package:sampleproject/APIs/fetchData.dart';
import 'package:sampleproject/APIs/models/chargingPoint.dart';
import 'package:sampleproject/User/screens/mainScreen/widgets/mainScreen_body.dart';
import 'package:sampleproject/features/splash/presentation/splash.dart';
import 'package:sampleproject/myadditional_folder/constants.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../../bar/buttomNavBar.dart';
import '../../../../features/splash/presentation/widgets/splash_body.dart';

class myChargingPointsBody extends StatefulWidget {
  const myChargingPointsBody({Key? key}) : super(key: key);

  @override
  State<myChargingPointsBody> createState() =>
      _chargingPoints_body_adminState();
}

class _chargingPoints_body_adminState extends State<myChargingPointsBody> {
  // db variables  ------>

  late double nearestPoint;

  String openTime_DB = "09:00 صباحا";
  String closeTime_DB = "05:00 مساءا";
  String centerName_DB = "شحن بئر المسناوي";
  String days_DB = "سبت أحد اثنين ثلاثاء اربعاء خميس";

  late List markerText_DB = [
    "حارة السلام",
    "البلدية الرئيسية",
    "شحن سوق الذهب",
    "ذنابة المسجد القديم",
    "شحن بئر المسناوي",
    "المسلخ",
    "شحن الكراجات الجديدة"
  ];

  late List dest_pointsList_Lat = [
    //y values
    32.337320,
    32.337321,
    32.33732,
    32.3134,
    32.337320,
    32.30687,
    32.31754
  ];

  late List dest_pointsList_Long = [
    // x values
    35.04881,
    35.03177,
    35.03177,
    35.04112,
    35.03177,
    35.03324,
    35.02825
  ];

  // up to here ----------

  SlidingUpPanelController panelController = SlidingUpPanelController();

  late ScrollController scrollController;
  int myIndex = 0;

  late GoogleMapController mapController;
  double _originLatitude = myPosition_lat, _originLongitude = myPosition_long;
  late double _destLatitude, _destLongitude;

  Map<MarkerId, Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {};
  late List<LatLng> polylineCoordinates = [
    LatLng(_originLatitude, _originLongitude),
    LatLng(_destLatitude, _destLongitude),
  ];
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPiKey = "AIzaSyDPyXq2VP7rB1qGzAdr7_QTk0xwz1pVYKM";
  bool iosStyle = true;
  String? start_value;
  String? close_value;
  var locationMessage = "";

  FetchData _fetchData = FetchData();

  Future<void> stateMethod() async {
    setState(() {});
  }

  _navigatetohome() async {
    await Future.delayed(Duration(milliseconds: 10000), () {});
    // chargingPointCard("dddddd", "aaaaaaa", "uuuuuuuu", "11111");
    fetchAllPoints();
  }

  @override
  void initState() {
    super.initState();
    _fetchData.allChargingPoints();
    fetchPoint();
    _navigatetohome();

    //  AllPoints();

    //getDataMethod();
    //stateMethod();

    // print(" test " + dest_pointsList_Lat.toString());
    // markerText_DB = _fetchData.PointsName(t1) as List;

    // dest_pointsList_Lat = _fetchData.PointsLat(t2) as List;

    // dest_pointsList_Long =  _fetchData.PointsLong(t3) as List;

    // print(splashClass.list.toString());

    // print( _fetchData.PointsName());
    // _fetchData.PointsName(markerText_DB)
    //     .then((value) => print(value))
    //     .catchError((e) => print(e));
    // _fetchData.PointsLatValues(dest_pointsList_Lat);
    // _fetchData.PointsLongValues(dest_pointsList_Long);

    getShortestPoint();

    /// origin marker
    _addMarker(LatLng(_originLatitude, _originLongitude), "origin",
        BitmapDescriptor.defaultMarker, "موقعك الحالي");

    /// destination marker
    for (int i = 0; i < dest_pointsList_Lat.length; i++) {
      _addMarker(
          LatLng(dest_pointsList_Lat[i], dest_pointsList_Long[i]),
          "destination$i",
          BitmapDescriptor.defaultMarkerWithHue(150),
          markerText_DB[i]);
    }

    _getPolyline();

    //print(" distance: " +
    //    calculateDistance(_originLatitude, _originLongitude, _destLatitude,
    //            _destLongitude)
    //        .toStringAsFixed(2) +
    //    " KM");

    myIndex = 0;
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
  }

  void getCurrentLocation() async {
    var position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    var lastPosition = await Geolocator().getLastKnownPosition();
    // print(lastPosition);

    _originLatitude = position.latitude;
    _originLongitude = position.longitude;

    setState(() {
      _originLatitude;
      _originLongitude;
      locationMessage =
          "latitude :$_originLatitude , longitude:$_originLongitude";
      print(locationMessage);
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
          value: item,
          child: Text(
            item,
            style: TextStyle(fontFamily: myOtherFont, fontSize: 13),
          ),
        );
    return Stack(
      children: <Widget>[
        Column(
          //  mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: Stack(
              children: [
                Container(
                    width: screenWidth,
                    height: screenHeight * 0.6,
                    child: Stack(
                      children: [
                        GoogleMap(
                          initialCameraPosition: CameraPosition(
                              target: LatLng(_originLatitude, _originLongitude),
                              zoom: 17),
                          myLocationEnabled: true,
                          tiltGesturesEnabled: true,
                          compassEnabled: true,
                          scrollGesturesEnabled: true,
                          zoomGesturesEnabled: true,
                          mapType: MapType.satellite,
                          myLocationButtonEnabled: true,
                          onMapCreated: _onMapCreated,
                          markers: Set<Marker>.of(markers.values),
                          polylines: Set<Polyline>.of(polylines.values),
                        ),
                        showAllChargingPointsButton(screenWidth),
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: screenHeight * 0.31,
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
                            "تظهر هنا تفاصيل اقرب مركز لموقعك الحالي",
                            style: TextStyle(
                                fontFamily: myOtherFont,
                                fontSize: 16,
                                color: myMainColor),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                const Spacer(
                                  flex: 2,
                                ),
                                nameRow(centerName_DB),
                                const Spacer(
                                  flex: 2,
                                ),
                                Row(
                                  children: [
                                    Start_and_END_Method(screenWidth,
                                        "وقت الفتح", openTime_DB, Colors.white),
                                    Start_and_END_Method(
                                        screenWidth,
                                        "وقت الاغلاق",
                                        closeTime_DB,
                                        Color.fromARGB(63, 22, 115, 191))
                                  ],
                                ),
                                const Spacer(
                                  flex: 2,
                                ),
                                daysRow(days_DB),
                                const Spacer(
                                  flex: 2,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              buttomNavBarClass()),
                                    );
                                  },
                                  child: Text(
                                    "رجوع",
                                    style: const TextStyle(
                                      fontFamily: myOtherFont,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      shadowColor: Colors.black,
                                      elevation: 3,
                                      primary: myMainColor,
                                      fixedSize: Size(screenWidth * 0.9,
                                          screenWidth * 0.03),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                ),
                                const Spacer(
                                  flex: 3,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ))
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
                        'اضغط هنا للاغلاق',
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
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      // alignment: Alignment.topRight,
                      child: Align(
                        alignment: Alignment.topRight,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              fetchAllPoints(),
                            ],
                          ),
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

  Widget fetchAllPoints() {
    return FutureBuilder(
        future: _fetchData.allChargingPoints(),
        builder: (context, snapchot) {
          var points = snapchot.data as List<chargingPointModel>;

          return snapchot.data == null
              ? Text("لا يوجد نقاط شحن")
              : ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: points == null ? 0 : points.length,
                  itemBuilder: (context, index) {
                    // markerText_DB.add(points[index].name);
                    // dest_pointsList_Lat.add(points[index].lat);
                    // dest_pointsList_Long.add(points[index].long);

                    // stateMethod();
                    // print("++++++++++++++++++++++++++++++" +
                    //     markerText_DB.toString());
                    // print("++++++++++++++++++++++++++++++" +
                    //     dest_pointsList_Lat.toString());
                    // print("++++++++++++++++++++++++++++++" +
                    //     dest_pointsList_Long.toString());

                    return chargingPointCard(
                        points[index].name,
                        points[index].open,
                        points[index].close,
                        points[index].days);
                  });
        });
  }

  Padding nameRow(String name) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Text(
            "اسم المركز ",
            style: DaysStyle(color: myMainColor),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            name,
            style: DaysStyle(),
          )
        ],
      ),
    );
  }

  Padding daysRow(String days) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Text(
            "أيام الدوام: ",
            style: DaysStyle(color: myMainColor),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            days,
            style: DaysStyle(),
          )
        ],
      ),
    );
  }

  TextStyle DaysStyle({Color color = Colors.black}) {
    return TextStyle(fontFamily: myOtherFont, fontSize: 13, color: color);
  }

  Padding showAllChargingPointsButton(double screenWidth) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: ElevatedButton(
          onPressed: () {
            panelController.expand();
          },
          child: Text(
            "عرض جميع مراكز الشحن",
            style: const TextStyle(
              fontFamily: myOtherFont,
            ),
          ),
          style: ElevatedButton.styleFrom(
              shadowColor: Colors.black,
              elevation: 3,
              primary: myMainColor,
              fixedSize: Size(screenWidth * 0.5, screenWidth * 0.03),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
        ),
      ),
    );
  }

  GestureDetector Start_and_END_Method(
      double screenWidth, String title, String time, Color color) {
    return GestureDetector(
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

  Padding chargingPointCard(
      String centerName, String startTime, String closeTime, String days) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
          color: Color.fromARGB(69, 208, 203, 203),
          height: MediaQuery.of(context).size.height * 0.12,
          child: Row(
            children: [
              const Spacer(
                flex: 2,
              ),
              Container(
                height: 60,
                child: Image.network(chargingPoints),
              ),
              const Spacer(
                flex: 6,
              ),
              Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Spacer(
                      flex: 3,
                    ),
                    Text(centerName,
                        style: TextStyle(
                            fontFamily: myOtherFont,
                            fontSize: 14,
                            color: myGray,
                            fontWeight: FontWeight.bold)),
                    const Spacer(
                      flex: 1,
                    ),
                    Row(
                      children: [
                        Text("وقت الفتح: " + startTime,
                            style: TextStyle(
                              fontFamily: myOtherFont,
                              fontSize: 13,
                              color: TFmyGray,
                            )),
                        SizedBox(
                          width: 30,
                        ),
                        Text("وقت الاغلاق: " + closeTime,
                            style: TextStyle(
                              fontFamily: myOtherFont,
                              fontSize: 13,
                              color: TFmyGray,
                            )),
                      ],
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                    Text("أيام الدوام: " + days,
                        style: TextStyle(
                          fontFamily: myOtherFont,
                          fontSize: 12,
                          color: TFmyGray,
                        )),
                    const Spacer(
                      flex: 3,
                    ),
                  ],
                ),
              ),
              const Spacer(
                flex: 9,
              ),
              const SizedBox(
                width: 2,
              )
            ],
          )),
    );
  }

  LatLng getShortestPoint() {
    double min = calculateDistance(_originLatitude, _originLongitude,
        dest_pointsList_Lat[0], dest_pointsList_Long[0]);
    double result;
    int latlong_index = 0;

    for (int i = 0; i < dest_pointsList_Lat.length; i++) {
      result = calculateDistance(_originLatitude, _originLongitude,
          dest_pointsList_Lat[i], dest_pointsList_Long[i]);
      print(
          "reult: ************ $i => => " + result.toStringAsFixed(2) + "  KM");

      if (result < min) {
        min = result;
        latlong_index = i;
      }
    }
    print("lat = ${dest_pointsList_Lat[latlong_index]} " +
        "long = ${dest_pointsList_Long[latlong_index]}  ");
    setState(() {
      nearestPoint = dest_pointsList_Lat[latlong_index];
      _destLatitude = dest_pointsList_Lat[latlong_index];
      _destLongitude = dest_pointsList_Long[latlong_index];
    });
    return LatLng(dest_pointsList_Lat[latlong_index],
        dest_pointsList_Long[latlong_index]);
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
  }

  _addMarker(LatLng position, String id, BitmapDescriptor descriptor,
      String markerText) {
    MarkerId markerId = MarkerId(id);
    Marker marker = Marker(
      markerId: markerId,
      icon: descriptor,
      infoWindow: InfoWindow(title: markerText),
      position: position,
    );
    markers[markerId] = marker;
  }

  _addPolyLine() {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id, color: Colors.green, points: polylineCoordinates);
    polylines[id] = polyline;
    setState(() {});
  }

  _getPolyline() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleAPiKey,
        PointLatLng(_originLatitude, _originLongitude),
        PointLatLng(_destLatitude, _destLongitude),
        travelMode: TravelMode.bicycling,
        wayPoints: [PolylineWayPoint(location: "Sabo, Yaba ")]);
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    _addPolyLine();
  }

  void fetchPoint() async {
    await ShowPoint();
    setState(() {});
  }

  Future ShowPoint() async {
    var Point = await _fetchData.pointLat(nearestPoint);
    print("66666666666666666666666666");
    setState(() {
      openTime_DB = Point.open;
      closeTime_DB = Point.close;
      centerName_DB = Point.name;
      days_DB = Point.days;
    });
  }
}
