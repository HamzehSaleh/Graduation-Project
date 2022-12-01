import 'package:flutter/material.dart';

import 'package:sampleproject/myadditional_folder/constants.dart';

import '../../Employees/Custom/popupMenuItem_Employee.dart';

class myUsersCard extends StatelessWidget {
  final String text;
  final String ID;
  final String phone;
  //final String job;
  //final String address;

  myUsersCard({
    required this.text,
    required this.ID,
    required this.phone,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
          color: Colors.white,
          height: screenHeight * 0.10,
          child: Row(
            children: [
              SizedBox(
                width: 10,
              ),
              CircleAvatar(
                backgroundImage: NetworkImage(myMenAvatar),
                radius: myMenAvatarRadius * 0.5,
              ),
              const Spacer(
                flex: 6,
              ),
              Align(
                alignment: Alignment.topRight,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Spacer(
                      flex: 3,
                    ),
                    Text(text,
                        style: TextStyle(
                            fontFamily: myOtherFont,
                            fontSize: 13,
                            color: myGray,
                            fontWeight: FontWeight.bold)),
                    const Spacer(
                      flex: 3,
                    ),
                    Text(" رقم الهوية  $ID",
                        style: TextStyle(
                          fontFamily: myOtherFont,
                          fontSize: 13,
                          color: TFmyGray,
                        )),
                    const Spacer(
                      flex: 1,
                    ),
                    Text("رقم الهاتف  $phone",
                        style: TextStyle(
                          fontFamily: myOtherFont,
                          fontSize: 13,
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
              popupMenuItems_Custom(),
            ],
          )),
    );
  }
}
