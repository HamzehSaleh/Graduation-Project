import 'package:flutter/material.dart';
import 'package:sampleproject/APIs/fetchData.dart';
import 'package:sampleproject/APIs/models/userModel.dart';
import 'package:sampleproject/myadditional_folder/constants.dart';

class customCoverAvatarProfile extends StatefulWidget {
  final double screenWidth;
  final double screenHeight;
  final String name;
  final String email;

  customCoverAvatarProfile(
      {required this.screenWidth,
      required this.screenHeight,
      required this.name,
      required this.email});

  @override
  State<customCoverAvatarProfile> createState() =>
      _customCoverAvatarProfileState();
}

class _customCoverAvatarProfileState extends State<customCoverAvatarProfile> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: widget.screenWidth,
          height: widget.screenHeight * 0.40,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(myProfileCover),
              fit: BoxFit.fill,
              //  colorFilter: ColorFilter.mode(
              //      Colors.black.withOpacity(0.175), BlendMode.dstATop),
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: widget.screenHeight * 0.1,
            ),
            const Align(
              alignment: Alignment.center,
              child: CircleAvatar(
                backgroundImage: NetworkImage(myMenAvatar),
                radius: myMenAvatarRadius,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: mainProfileInfoColor,
                  fontFamily: 'ALMARAI',
                  fontSize: mainProfileInfoFontSize),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              widget.email,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: mainProfileInfoColor,
                  fontFamily: 'ALMARAI',
                  fontSize: mainProfileInfoFontSize),
            ),
          ],
        ),
      ],
    );
  }
}




  // Stack customCoverAvatarProfile(double screenWidth, double screenHeight) {
  //   return Stack(
  //           children: <Widget>[
  //             Container(
  //               width: screenWidth,
  //               height: screenHeight * 0.40,
  //               decoration: const BoxDecoration(
  //                 image: DecorationImage(
  //                   image: NetworkImage(myProfileCover),
  //                   fit: BoxFit.fill,
  //                   //  colorFilter: ColorFilter.mode(
  //                   //      Colors.black.withOpacity(0.175), BlendMode.dstATop),
  //                 ),
  //               ),
  //             ),
  //             Column(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               crossAxisAlignment: CrossAxisAlignment.center,
  //               children: [
  //                 SizedBox(
  //                   height: screenHeight * 0.1,
  //                 ),
  //                 Align(
  //                   alignment: Alignment.center,
  //                   child: CircleAvatar(
  //                     backgroundImage: AssetImage(myMenAvatar),
  //                     radius: myMenAvatarRadius,
  //                   ),
  //                 ),
  //                 SizedBox(
  //                   height: 10,
  //                 ),
  //                 Text(
  //                   "محمد مبسلط",
  //                   textAlign: TextAlign.center,
  //                   style: TextStyle(
  //                       color: mainProfileInfoColor,
  //                       fontFamily: 'ALMARAI',
  //                       fontSize: mainProfileInfoFontSize),
  //                 ),
  //                 SizedBox(
  //                   height: 5,
  //                 ),
  //                 Text(
  //                   "mhmd.mubaslat@gmail.com",
  //                   textAlign: TextAlign.center,
  //                   style: TextStyle(
  //                       color: mainProfileInfoColor,
  //                       fontFamily: 'ALMARAI',
  //                       fontSize: mainProfileInfoFontSize),
  //                 ),
  //               ],
  //             ),
  //           ],
  //         );
  // }