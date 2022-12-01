import 'package:flutter/material.dart';
import 'package:sampleproject/Custom_widgets/CustomLogo.dart';
import 'package:sampleproject/myadditional_folder/constants.dart';
import 'package:http/http.dart' as http;

import '../../../../APIs/fetchData.dart';
import '../../../../APIs/models/chargingPoint.dart';



class spalshBody extends StatefulWidget {
  const spalshBody({Key? key}) : super(key: key);

  @override
  State<spalshBody> createState() => _spalshBodyState();
}

class _spalshBodyState extends State<spalshBody> {
  

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

// Image.asset("assets/images/splash.png"),
    return Scaffold(
      body: Stack(
        children: <Widget>[
          //  Image.asset("assets/images/splash.png"),
          Container(
            width: screenWidth,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(splash_asset),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.175), BlendMode.dstATop),
              ),
            ),
          ),
      
          Expanded(
              child: Column(
            children: [
              const Spacer(
                flex: 2,
              ),
              myCustomLogo(screenWidth: screenWidth, fontSize: logoFontSize),
              const Spacer(
                flex: 6,
              ),
              const Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  "تطبيق قسم كهرباء بلدية طولكرم",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: myMainColor,
                      fontFamily: 'ALMARAI',
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Spacer(),
            ],
          ))
        ],
      ),
    );
  }
}
