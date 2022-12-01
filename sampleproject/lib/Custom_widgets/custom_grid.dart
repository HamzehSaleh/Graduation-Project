import 'package:flutter/material.dart';
import 'package:sampleproject/Custom_widgets/CustomCardService.dart';
import 'package:sampleproject/User/screens/mainScreen/serviceCards/reportProblem.dart';
import 'package:sampleproject/User/screens/myProblems/myProblem.dart';
import '../Admin/screens/Main_Admin.dart';
import '../User/screens/chargingPoints/myChargingPoints.dart';
import '../User/screens/mainScreen/serviceCards/myCalc_Folder/myCalc.dart';
import '../User/screens/mainScreen/serviceCards/myConsumption_Folder/myConsumption.dart';
import '../User/screens/mainScreen/serviceCards/newSub_Folder/newSub.dart';
import '../myadditional_folder/constants.dart';

class CustomGrid extends StatefulWidget {
  const CustomGrid({Key? key}) : super(key: key);

  @override
  _CustomGridState createState() => _CustomGridState();
}

class _CustomGridState extends State<CustomGrid> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: screenHeight / 2,
      child: GridView.count(
          shrinkWrap: true,
          //  primary: false,
          padding: const EdgeInsets.all(10),
          crossAxisCount: 3,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          // maxCrossAxisExtent: screenHeight * 0.17,
          children: <Widget>[
            CustomCardService(
              img: myConsumption,
              text: "استهلاكي",
              // color: Colors.red.withOpacity(0.5),
              nextClass: myConsumptionClass(),
            ),
            CustomCardService(
              img: chargingPoints,
              text: "مراكز الشحن",
              //  color: Color.fromARGB(255, 26, 36, 177).withOpacity(0.5),
              nextClass: myChargingPointsClass(),
            ),
            CustomCardService(
              img: reportProblemMain,
              text: "الابلاغ عن مشكلة",
              //  color: Color.fromARGB(255, 169, 42, 219).withOpacity(0.5),
              nextClass: reportProblemClass(),
            ),
            CustomCardService(
              img: myProblemsMain,
              text: "الشكاوي الخاصة بي",
              // color: Color.fromARGB(255, 112, 202, 38).withOpacity(0.5),
              nextClass: myProblemClass(),
            ),
            CustomCardService(
              img: newSub,
              // color: Color.fromARGB(255, 187, 39, 120).withOpacity(0.5),
              text: "طلب اشتراك جديد",
              nextClass: newSubClass(),
            ),
            CustomCardService(
              img: myCalc,
              // color: Color.fromARGB(255, 33, 182, 28).withOpacity(0.5),
              text: "حاسبتي",
              nextClass: myCalcClass(),
            ),
          ]),
    );
  }
}
