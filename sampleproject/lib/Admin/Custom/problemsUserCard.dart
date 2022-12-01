import 'package:flutter/material.dart';
import 'package:sampleproject/bar/buttomNavBar.dart';

import '../../myadditional_folder/constants.dart';

class myProblemsUsersCard extends StatelessWidget {
  final String name;
  //final String city;
  final String title;
  final String type_of_place;
  final String details;
  //final String image;
  var nextPage;

  myProblemsUsersCard(
      {required this.name,
      required this.title,
      // required this.city,
      required this.type_of_place,
      required this.details});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Container(
          color: Colors.white,
          height: screenHeight * 0.11,
          child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => nextPage,
                  ),
                );
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white)),
              child: Row(
                children: [
                  const Spacer(
                    flex: 2,
                  ),
                  CircleAvatar(
                    backgroundImage: NetworkImage(reportProblem),
                    radius: myMenAvatarRadius * 0.7,
                  ),
                  const Spacer(
                    flex: 2,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.center,
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
                        //Text(" المدينة $city",
                        //    style: TextStyle(
                        //      fontFamily: myOtherFont,
                        //      fontSize: 11,
                        //      color: TFmyGray,
                        //    )),
                        const Spacer(
                          flex: 3,
                        ),
                        Text("عنوان المشكلة $title",
                            style: TextStyle(
                              fontFamily: myOtherFont,
                              fontSize: 12,
                              color: TFmyGray,
                            )),
                        const Spacer(
                          flex: 3,
                        ),
                        Text("نوع العقار  $type_of_place",
                            style: TextStyle(
                              fontFamily: myOtherFont,
                              fontSize: 12,
                              color: TFmyGray,
                            )),
                        const Spacer(
                          flex: 7,
                        ),
                        // Text("دائرة العمل  $details",
                        //     style: TextStyle(
                        //       fontFamily: myOtherFont,
                        //       fontSize: 14,
                        //       color: TFmyGray,
                        //     )),
                        // const Spacer(
                        //   flex: 3,
                        // ),
                        // Row(
                        //   children: [
                        //     Icon(Icons.location_on, color: myMainColor),
                        //     Text(address,
                        //         style: TextStyle(
                        //           fontFamily: myOtherFont,
                        //           fontSize: 14,
                        //           color: TFmyGray,
                        //         )),
                        //   ],
                        // ),
                        // const Spacer(
                        //   flex: 3,
                        // ),
                      ],
                    ),
                  ),
                  const Spacer(
                    flex: 9,
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 20.0,
                    color: TFmyGray,
                  ),
                  const Spacer(
                    flex: 3,
                  ),
                ],
              )),
        ));
  }
}
