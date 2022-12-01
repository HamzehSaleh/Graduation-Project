import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';
import 'package:sampleproject/APIs/fetchData.dart';
import 'package:sampleproject/APIs/models/problemsModel.dart';

import '../../../../myadditional_folder/constants.dart';
import 'package:http/http.dart' as http;

class myProblemBody extends StatefulWidget {
  myProblemBody({Key? key}) : super(key: key);

  @override
  State<myProblemBody> createState() => _myProblemBodyState();
}

late String ID = "";

class _myProblemBodyState extends State<myProblemBody> {
  // Whether the green box should be visible or invisible

  SlidingUpPanelController panelController = SlidingUpPanelController();

  FetchData _fetchData = FetchData();

  late ScrollController scrollController;
  TextEditingController textarea = TextEditingController();

  ///The controller of sliding up panel
  @override
  void initState() {
    // panelController.hide();
    _fetchData.fetchMyProblems();

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
      children: <Widget>[
        Center(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 10),
            children: <Widget>[
              //Padding(
              //  padding: EdgeInsets.only(top: 50.0),
              //),
              //RaisedButton(
              //  child: Text('Show panel'),
              //  onPressed: () {
              //    panelController.expand();
              //  },
              //),
              //Padding(
              //  padding: EdgeInsets.only(top: 50.0),
              //),
              //RaisedButton(
              //  child: Text('Anchor panel'),
              //  onPressed: () {
              //    panelController.anchor();
              //  },
              //),
              SizedBox(
                height: 5,
              ),

              // myProblemsCard( "وجود اسلاك مقطوعة",
              //     " 25/02/2022 تاريخ الشكوى", "حالة الشكوى غير مقروءة"),
              // myProblemsCard("وجود اسلاك مقطوعة",
              //     " 25/02/2022 تاريخ الشكوى", "حالة الشكوى غير مقروءة"),
              MyProblems(),

              //Padding(
              //  padding: EdgeInsets.only(top: 50.0),
              //),
              //RaisedButton(
              //  child: Text('Expand panel'),
              //  onPressed: () {
              //    panelController.expand();
              //  },
              //),
              //Padding(
              //  padding: EdgeInsets.only(top: 50.0),
              //),
              //RaisedButton(
              //  child: Text('Collapse panel'),
              //  onPressed: () {
              //    panelController.collapse();
              //  },
              //),
              //Padding(
              //  padding: EdgeInsets.only(top: 50.0),
              //),
              //RaisedButton(
              //  child: Text('Hide panel'),
              //  onPressed: () {
              //    panelController.hide();
              //  },
              //),
            ],
          ),
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
                        'تتبع تفاصيل الشكوى',
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

  Padding myProblemsCard(String text, String date, String state, String _id) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height * 0.12,
          child: Row(
            children: [
              SizedBox(
                width: 10,
              ),

              //const Icon(
              //  Icons.sync_problem,
              //  size: 40.0,
              //),

              Image.network(myProblems
                  // height: screenHeight * 0.30, width: screenWidth * 0.5
                  ),

              const SizedBox(
                width: 20,
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
                    Text(text,
                        style: TextStyle(
                            fontFamily: myOtherFont,
                            fontSize: 15,
                            color: myGray,
                            fontWeight: FontWeight.bold)),
                    const Spacer(
                      flex: 1,
                    ),
                    Text(date,
                        style: TextStyle(
                          fontFamily: myOtherFont,
                          fontSize: 12,
                          color: TFmyGray,
                        )),
                    const Spacer(
                      flex: 1,
                    ),
                    Text(state,
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
              PopupMenuButton(
                  itemBuilder: (context) => [
                        popupMenu("حذف", _id),
                        popupMenu("تتبع حالة الشكوى", _id),
                      ]),
              const SizedBox(
                width: 2,
              )
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
          case "تتبع حالة الشكوى":
            {
              ID = _id;
              // ShowProblemDetails(_id);
              panelController.expand();
              setState(() {});
            }
            break;
        }
      },
    );
  }

  TextStyle sheetInfostyle() {
    return TextStyle(fontFamily: myOtherFont, fontSize: 15);
  }

  TextStyle style() {
    return TextStyle(
        fontFamily: myOtherFont, fontSize: 16, fontWeight: FontWeight.bold);
  }

  Widget ShowProblemDetails() {
    return FutureBuilder(
        future: _fetchData.findProblemById(ID),
        builder: (context, snapchot) {
          var SelectedProblem = snapchot.data as ProblemsModel;
          // snapchot.data == null
          //     ? print("+++++++++++++ problem not fount")
          //     : print("++++++++++++++++++++ problem");
          return snapchot.data == null
              ? Text("جاري التحميل")
              : ProblemSelected(SelectedProblem.name, SelectedProblem.date,
                  SelectedProblem.status);
        });
  }

  Widget ProblemSelected(
      String problemName, String problemDate, String ProblemStatus) {
    return Column(
      children: [
        const Spacer(),
        sheetRow("نوع الشكوى :", problemName),
        const Spacer(),
        sheetRow("تاريخ الشكوى :", problemDate),
        const Spacer(),
        sheetRow("حالة الشكوى :", ProblemStatus),
        const Spacer(),
        TextField(
          controller: textarea,
          keyboardType: TextInputType.multiline,
          maxLines: 4,
          decoration: const InputDecoration(
              hintText: "ارسال رسالة (اختياري)",
              hintStyle: TextStyle(fontFamily: myOtherFont, fontSize: 13),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: myMainColor))),
        ),
        const Spacer(),
        ElevatedButton(
          onPressed: () {
            panelController.collapse();
            // panelController.hide();
          },
          child: Text(
            "اغلاق النافذة",
            style: const TextStyle(
              fontFamily: myOtherFont,
            ),
          ),
          style: ElevatedButton.styleFrom(
              shadowColor: Colors.black,
              elevation: 3,
              primary: myMainColor,
              fixedSize: Size(MediaQuery.of(context).size.width,
                  MediaQuery.of(context).size.height * 0.03),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
        ),
        const Spacer(),
      ],
    );
  }

  Widget MyProblems() {
    return FutureBuilder(
        future: _fetchData.fetchMyProblems(),
        builder: (context, snapchot) {
          var problems = snapchot.data as List<ProblemsModel>;
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
                    return myProblemsCard(
                        problems[index].name,
                        problems[index].date,
                        problems[index].status,
                        problems[index].id);
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
