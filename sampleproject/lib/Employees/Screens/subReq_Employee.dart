import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';
import 'package:sampleproject/APIs/models/servicesModel.dart';

import '../../APIs/fetchData.dart';
import '../../Custom_widgets/CustomFlatButton_Icon.dart';
import '../../myadditional_folder/constants.dart';
import 'package:geolocator/geolocator.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class subReq_body_Employee extends StatefulWidget {
  const subReq_body_Employee({Key? key}) : super(key: key);

  @override
  State<subReq_body_Employee> createState() => _subReq_body_EmployeeState();
}

class _subReq_body_EmployeeState extends State<subReq_body_Employee> {
  SlidingUpPanelController panelController = SlidingUpPanelController();
  FetchData _fetchData = FetchData();
  late String ID = "";
  late List ImageData;
  late ScrollController scrollController;
  TextEditingController textarea = TextEditingController();

  addProblemStateDialog(BuildContext context, String hint, String title) {
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

  createAlertDialog(
      BuildContext context, String hint, String title, String img) {
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
              height: 280,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(width: 200, child: Image.network(img)),
                          SizedBox(
                            height: 20,
                          ),
                          TextField(
                            controller: customController,
                            decoration: InputDecoration(
                              hintText: hint,
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
  void initState() {
    _fetchData.AllServices();
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

                // ProblemCard(
                //   screenHeight,
                //   context,
                //   "طارق محمود محمد عيسى",
                //   "112233445",
                //   "تبديل عداد الكهرباء",
                // ),
                allSubReq(),
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
                          child: showServiceDetails()),
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

  Column newSubScrollCol(
      BuildContext context, String type, String building, String info) {
    return Column(
      children: [
        const Spacer(),
        sheetRow("اسم صاحب الطلب :", type),
        const Spacer(),
        sheetRow("حالة الطلب:", building),
        const Spacer(),
        sheetRow("نوع الاشتراك :", info),
        const Spacer(),
        showProblemLocationButton(context),
        const Spacer(),
        PickedImages(),
        const Spacer(
          flex: 2,
        ),
        // addProblemStateButton(context),
        const Spacer(
          flex: 2,
        ),
      ],
    );
  }

  FlatButton showProblemLocationButton(BuildContext context) {
    return FlatButton(
      color: Colors.transparent,
      splashColor: Colors.black26,
      onPressed: () {
        createAlertDialog(context, "أدخل نص الرسالة",
            "ارسال رسالة الى صاحب الطلب", sendMessage);
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
                "ارسال رسالة",
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

  Padding ProblemCard(double screenHeight, BuildContext context, String name,
      String date, String subType, String Id) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Container(
          color: Colors.white,
          height: screenHeight * 0.1,
          child: Row(
            children: [
              SizedBox(
                width: 10,
              ),
              CircleAvatar(
                backgroundImage: NetworkImage(
                  newSub,
                ),
                radius: myMenAvatarRadius * 0.5,
                backgroundColor: Colors.white,
              ),
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
                    Text("تاريخ التقديم " + date,
                        style: TextStyle(
                          fontFamily: myOtherFont,
                          fontSize: 12,
                          color: TFmyGray,
                        )),
                    const Spacer(
                      flex: 3,
                    ),
                    Text("نوع الاشتراك: " + subType,
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
                        popupMenu(context, "انهاء الطلب", Id),
                        popupMenu(context, "عرض تفاصيل الطلب", Id),
                      ])
            ],
          )),
    );
  }

  PopupMenuItem<int> popupMenu(BuildContext context, String text, String id) {
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
          case "انهاء الطلب":
            {
              panelController.expand();
            }
            break;
          case "عرض تفاصيل الطلب":
            {
              ID = id;
              panelController.expand();
              setState(() {});
            }
            break;
        }
      },
    );
  }

  Widget imagePart(List Photos) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Text(
                "الوثائق المرفقة",
                style: style(),
              ),
              Spacer()
            ],
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Row(
          children: [
            // ListView.builder(
            //     shrinkWrap: true,
            //     physics: NeverScrollableScrollPhysics(),
            //     itemCount: Photos.length,
            //     itemBuilder: (context, index) {
            //       return Image.memory(base64Decode(Photos.elementAt(index)));
            //     }),
            Image.network(newSubphoto,
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width * 0.4),
          ],
        )
      ],
    );
  }

  Widget showServiceDetails() {
    return FutureBuilder(
      future: _fetchData.adminServiceId(ID),
      builder: (context, snapchot) {
        var selectedService = snapchot.data as ServicesModel;

        if (snapchot.data == null) {
          print("ddddddddddddddddddd");
        } else {
          ImageData = selectedService.photos;
          print(ImageData);
        }

        return snapchot.data == null
            ? Text("ddd")
            : newSubScrollCol(context, selectedService.ownerName,
                selectedService.service_status, selectedService.name);
      },
    );
  }

  Widget PickedImages() {
    return ImageData == [] ? Text("لم يتم ادراج صورة") : imagePart(ImageData);
  }

  Widget allSubReq() {
    return FutureBuilder(
      future: _fetchData.AllServices(),
      builder: (context, snapchot) {
        var services = snapchot.data as List<ServicesModel>;
        return snapchot.data == null
            ? CircularProgressIndicator(
                value: 0.8,
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
              )
            : ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: services == null ? 0 : services.length,
                itemBuilder: (context, index) {
                  return ProblemCard(
                    MediaQuery.of(context).size.height,
                    context,
                    services[index].ownerName,
                    services[index].service_date,
                    services[index].name,
                    services[index].id,
                  );
                });
      },
    );
  }
}
