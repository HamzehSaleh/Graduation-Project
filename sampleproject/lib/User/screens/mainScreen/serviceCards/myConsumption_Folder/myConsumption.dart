import 'package:flutter/material.dart';
import 'package:sampleproject/User/screens/mainScreen/serviceCards/myCalc_Folder/myCalc_body.dart';
import 'package:sampleproject/User/screens/mainScreen/serviceCards/newSub_Folder/newSub_body.dart';

import 'package:sampleproject/myadditional_folder/constants.dart';

import 'myConsumption_body.dart';

final Color darkBlue = Color.fromARGB(255, 18, 32, 47);

class myConsumptionClass extends StatelessWidget {
  const myConsumptionClass({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          "تقارير الاستهلاك",
          style: TextStyle(
              fontFamily: "ALMARAI", color: myMainColor, fontSize: 18),
        ),
      ),
      backgroundColor: myBackColor,
      body: myConsumption_body(),
    );
  }
}
