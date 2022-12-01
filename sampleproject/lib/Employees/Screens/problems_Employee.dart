import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';
import 'package:sampleproject/APIs/fetchData.dart';
import 'package:sampleproject/APIs/models/problemsModel.dart';

import '../../Custom_widgets/CustomFlatButton_Icon.dart';
import '../../myadditional_folder/constants.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';

class problems_body_Employee extends StatefulWidget {
  const problems_body_Employee({Key? key}) : super(key: key);

  @override
  State<problems_body_Employee> createState() => _problems_body_EmployeeState();
}

class _problems_body_EmployeeState extends State<problems_body_Employee> {
  SlidingUpPanelController panelController = SlidingUpPanelController();

  late ScrollController scrollController;
  TextEditingController textarea = TextEditingController();

  FetchData _fetchData = FetchData();
  late String ID = "";
  late String ImageData = "";
  late TextEditingController problemStatusController;

  // DB ------------

  // open DB --> read lat & long --> rhen store values in lat and long in bellow..
  late double lat;
  late double long;

  late final LatLng lat_Lng;

// up to here

  var myMarkers = HashSet<Marker>();
  Set<Marker> markers = {};

  late GoogleMapController googleMapController;
  static const CameraPosition initialCameraPosition =
      CameraPosition(target: LatLng(32.309758, 35.024802), zoom: 17);

  addProblemStateDialog(BuildContext context, String hint, String title) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              title,
              style: const TextStyle(fontFamily: myOtherFont, fontSize: 14),
            ),
            content: TextField(
              controller: problemStatusController,
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
                  _fetchData.changeStatus(
                      "status", problemStatusController.text, ID);
                  Navigator.of(context)
                      .pop(problemStatusController.text.toString());
                  // print(customController.text);
                },
              ),
            ],
          );
        });
  }

  createAlertDialog(BuildContext context, String hint, String title) {
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
                      mapType: MapType.satellite,
                      initialCameraPosition:
                          CameraPosition(target: LatLng(lat, long), zoom: 17),
                      onMapCreated: (GoogleMapController googleMapController) {
                        setState(() {
                          myMarkers.add(Marker(
                            markerId: MarkerId("1"),
                            position: LatLng(lat, long),
                          ));
                        });
                      },
                      markers: myMarkers,
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              MaterialButton(
                elevation: 5.0,
                child: Text(
                  "اغلاق",
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

  @override
  void initState() {
    // panelController.hide();

    _fetchData.AllProblems();
    problemStatusController = new TextEditingController();

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
                child: Column(
              children: [
                SizedBox(
                  height: 5,
                ),
                // ProblemCard("محمد جواد مبسلط", "عامود ساقط", "منطقة سكنية",
                //     "لقد شاهدسقط وكاد انع وقت"),
                // ProblemCard("محمد جواد مبسلط", "عامود ساقط", "منطقة سكنية",
                //     "لقد شاهدسقط وكاد انع وقت"),
                // ProblemCard("محمد جواد مبسلط", "عامود ساقط", "منطقة سكنية",
                //     "لقد شاهدسقط وكاد انع وقت"),
                allProblems(),
                Spacer(
                  flex: 10,
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
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      // alignment: Alignment.topRight,
                      child: Align(
                        alignment: Alignment.topRight,
                        child: ShowProblemDetails(),
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
        ),
      ],
    );
  }

  FlatButton showProblemLocationButton(BuildContext context) {
    return FlatButton(
      color: Colors.transparent,
      splashColor: Colors.black26,
      onPressed: () {
        createAlertDialog(context, "hint", "موقع الشكوى الذي تم الابلاغ عنها");
      },
      child: Align(
          alignment: Alignment.topRight,
          child: Row(
            children: [
              Icon(
                Icons.location_on_sharp,
                color: myMainColor,
              ),
              const Spacer(),
              Text(
                "عرض موقع الشكوى",
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
    );
  }

  FlatButton addProblemStateButton(BuildContext context) {
    return FlatButton(
      color: Colors.transparent,
      splashColor: Colors.black26,
      onPressed: () {
        addProblemStateDialog(context, "مثلا: غير مقروءة، قيد التنفيذ ..",
            "قم باضافة مسار الشكوى");
      },
      child: Align(
          alignment: Alignment.topRight,
          child: Row(
            children: [
              Icon(
                Icons.help_outline,
                color: myMainColor,
              ),
              const Spacer(),
              Text(
                "اضافة حالة الشكوى",
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
    );
  }

  Row sheetRow(String title, String info) {
    return Row(
      children: [
        const SizedBox(
          width: 20,
        ),
        Text(
          title,
          style: style(),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          info,
          style: sheetInfostyle(),
        ),
        const Spacer(),
      ],
    );
  }

  TextStyle sheetInfostyle() {
    return TextStyle(fontFamily: myOtherFont, fontSize: 15);
  }

  TextStyle style() {
    return TextStyle(
        fontFamily: myOtherFont, fontSize: 16, fontWeight: FontWeight.bold);
  }

  Padding ProblemCard(
      String name, String title, String type_of_place, String _id) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height * 0.1,
          child: Row(
            children: [
              SizedBox(
                width: 10,
              ),
              CircleAvatar(
                backgroundImage: NetworkImage(reportProblem),
                radius: myMenAvatarRadius * 0.7,
              ),
              // const Spacer(
              //   flex: 6,
              // ),
              const SizedBox(
                width: 20,
              ),
              Align(
                alignment: Alignment.topRight,
                child: Column(
                  children: [
                    const Spacer(
                      flex: 7,
                    ),
                    Text(" $name",
                        style: TextStyle(
                            fontFamily: myOtherFont,
                            fontSize: 14,
                            color: myGray,
                            fontWeight: FontWeight.bold)),
                    const Spacer(
                      flex: 4,
                    ),
                    const Spacer(
                      flex: 3,
                    ),
                    Text("موضوع الشكوى: " + title,
                        style: TextStyle(
                          fontFamily: myOtherFont,
                          fontSize: 12,
                          color: TFmyGray,
                        )),
                    const Spacer(
                      flex: 3,
                    ),
                    Text("نوع العقار: " + type_of_place,
                        style: TextStyle(
                          fontFamily: myOtherFont,
                          fontSize: 12,
                          color: TFmyGray,
                        )),
                    const Spacer(
                      flex: 7,
                    ),
                  ],
                ),
              ),
              const Spacer(
                flex: 15,
              ),
              PopupMenuButton(
                  itemBuilder: (context) => [
                        popupMenu("حذف", _id),
                        popupMenu("عرض تفاصيل الشكوى", _id),
                      ])
            ],
          )),
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
              DeleteMyProblem(_id);
              setState(() {});
            }
            break;
          case "عرض تفاصيل الشكوى":
            {
              ID = _id;
              //  ShowProblemDetails(_id);
              panelController.expand();
              setState(() {});
            }
            break;
        }
      },
    );
  }

  Column imagePart(image) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Text(
                "صورة الشكوى: ",
                style: style(),
              ),
              Spacer()
            ],
          ),
        ),
        SizedBox(
          height: 15,
        ),

        PickedImages(),

        // Image.network(noImage),
      ],
    );
  }

  Widget PickedImages() {
    return ImageData == "" ? Text("لم يتم ادراج صورة") : showImage(ImageData);
  }

  showImage(String image) {
    return Image.memory(base64Decode(image));
  }

  Widget ShowProblemDetails() {
    // panelController.expand();
    return FutureBuilder(
        future: _fetchData.adminProblemId(ID),
        builder: (context, snapchot) {
          var SelectedProblem = snapchot.data as ProblemsModel;

          // snapchot.data == null
          //     ? ImageData = ""
          //     : ImageData = SelectedProblem.photo;

          // lat = SelectedProblem.lat;
          // long = SelectedProblem.long;

          if (snapchot.data == null) {
            ImageData = "";
            lat = 32.2585;
            long = 35.3322;
          } else {
            ImageData = SelectedProblem.photo;
            lat = SelectedProblem.lat;
            long = SelectedProblem.long;
          }

          // lat_Lng.latitude=35.989;

          setState() {}

          return snapchot.data == null
              ? Text("جاري التحميل...")
              : ProblemSelected(
                  SelectedProblem.name,
                  SelectedProblem.type,
                  SelectedProblem.desc,
                  SelectedProblem.status,
                  SelectedProblem.photo);
        });
  }

  Widget ProblemSelected(String problemName, String problemType,
      String problemDesc, String problemStatus, String image) {
    return Column(
      children: [
        Expanded(
          child: Column(
            children: [
              const Spacer(),
              sheetRow("موضوع الشكوى :", problemName),
              const Spacer(),
              sheetRow("نوع العقار :", problemType),
              const Spacer(),
              sheetRow("تفاصيل الشكوى :", problemDesc),
              const Spacer(),
              sheetRow("حالة الشكوى :", problemStatus),
              const Spacer(),
              showProblemLocationButton(context),
              const Spacer(),
              imagePart(image),
              const Spacer(
                flex: 2,
              ),
              addProblemStateButton(context),
              const Spacer(
                flex: 2,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget allProblems() {
    return FutureBuilder(
        future: _fetchData.AllProblems(),
        builder: (context, snapchot) {
          var problems = snapchot.data as List<ProblemsModel>;
          snapchot.data == null ? print('s') : print("the problems");
          return snapchot.data == null
              ? CircularProgressIndicator(
                  value: 0.8,
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
                )
              : ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: problems == null ? 0 : problems.length,
                  itemBuilder: (context, index) {
                    return ProblemCard(
                      problems[index].ownerName,
                      problems[index].name,
                      problems[index].type,
                      problems[index].id,
                    );
                  });
        });
  }

  Future<void> DeleteMyProblem(id) async {
    var problemID = FetchData.baseURL + "/problems/" + id.toString();
    var res = await http.delete(
      Uri.parse(problemID),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    print(res.statusCode);
  }
}
