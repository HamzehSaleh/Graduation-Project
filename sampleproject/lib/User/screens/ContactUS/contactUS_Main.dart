import 'package:flutter/material.dart';
import 'package:sampleproject/User/screens/ContactUS/widgets/contactUS_body.dart';
import 'package:sampleproject/myadditional_folder/constants.dart';

import '../../../bar/buttomNavBar.dart';

class mainContactUSClass extends StatelessWidget {
  const mainContactUSClass({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: myMainColor,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => buttomNavBarClass()),
            );
          },
        ),
        centerTitle: true,
        title: const Text(
          "اتصل بنا",
          style: TextStyle(
              fontFamily: "ALMARAI", color: myMainColor, fontSize: 18),
        ),
      ),
      body: mainContactUSBody(),
    );
  }
}
