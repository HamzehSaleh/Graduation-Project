import 'package:flutter/material.dart';
import 'package:sampleproject/User/screens/myProblems/widgets/myProblem_body.dart';
import 'package:sampleproject/myadditional_folder/constants.dart';

class myProblemClass extends StatelessWidget {
  const myProblemClass({Key? key}) : super(key: key);

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
          "الشكاوي الخاصة بي",
          style: TextStyle(
              fontFamily: "ALMARAI", color: myMainColor, fontSize: 18),
        ),
      ),
      backgroundColor: myBackColor,
      body: myProblemBody(),
    );
  }
}
