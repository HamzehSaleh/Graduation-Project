import 'package:flutter/material.dart';
import 'package:http/retry.dart';
import 'package:sampleproject/APIs/models/RatingModel.dart';

import '../../../Custom_widgets/CustomTextField.dart';
import '../../../myadditional_folder/constants.dart';
import 'package:sampleproject/APIs/fetchData.dart';
import 'package:http/http.dart' as http;

class rate_body_admin extends StatefulWidget {
  const rate_body_admin({Key? key}) : super(key: key);

  @override
  State<rate_body_admin> createState() => _rate_body_adminState();
}

class _rate_body_adminState extends State<rate_body_admin> {
  FetchData _fetchData = FetchData();

  @override
  void initState() {
    super.initState();
    _fetchData.allRatings();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Column(
      //  mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              SizedBox(
                height: 5,
              ),

              // myRateCard(screenHeight, 1, "-"),

              fetchAllRatings(),

              Spacer(
                flex: 3,
              ),
            ],
          ),
        ))
      ],
    );
  }

  Padding myRateCard(int rateLevel, String additionalNotes, String id) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height * 0.10,
          child: Row(
            children: [
              SizedBox(
                width: 10,
              ),
              CircleAvatar(
                backgroundImage: NetworkImage(myMenAvatar),
                radius: myMenAvatarRadius * 0.5,
              ),
              const SizedBox(
                width: 20,
              ),
              Align(
                alignment: Alignment.topRight,
                child: Column(
                  children: [
                    const Spacer(
                      flex: 3,
                    ),
                    Text("تقييم من مجهول",
                        style: TextStyle(
                            fontFamily: myOtherFont,
                            fontSize: 13,
                            color: myGray,
                            fontWeight: FontWeight.bold)),
                    const Spacer(
                      flex: 3,
                    ),
                    Text(" درجة التقييم: " + rateLevelFun(rateLevel),
                        style: TextStyle(
                          fontFamily: myOtherFont,
                          fontSize: 13,
                          color: TFmyGray,
                        )),
                    const Spacer(
                      flex: 2,
                    ),
                    Text("ملاحظات اضافية: " + additionalNotes,
                        style: TextStyle(
                          fontFamily: myOtherFont,
                          fontSize: 13,
                          color: TFmyGray,
                        )),
                    const Spacer(
                      flex: 2,
                    ),
                  ],
                ),
              ),
              const Spacer(
                flex: 9,
              ),
              PopupMenuButton(
                  itemBuilder: (context) => [
                        popupMenu(context, "حذف", id),
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
      value: 1,
      onTap: () {
        if (text == 'حذف') {
          DeleteRating(id);
          setState(() {});
        }
      },
    );
  }

  String rateLevelFun(int level_int) {
    switch (level_int) {
      case 1:
        {
          return "سيء جدا";
        }

      case 2:
        {
          return "سيء";
        }
      case 3:
        {
          return "جيد";
        }
      case 4:
        {
          return "جيد جدا";
        }
      case 5:
        {
          return "ممتاز";
        }

      default:
        {
          return "لم يتم التقييم";
        }
    }
  }

  Widget fetchAllRatings() {
    return FutureBuilder(
        future: _fetchData.allRatings(),
        builder: (context, snapchot) {
          var ratings = snapchot.data as List<RatingModel>;
          return snapchot.data == null
              ? CircularProgressIndicator(
                  value: 0.8,
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
                )
              : ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: ratings == null ? 0 : ratings.length,
                  itemBuilder: (context, index) {
                    return myRateCard(ratings[index].index, ratings[index].note,
                        ratings[index].id);
                  });
        });
  }

  Future<void> DeleteRating(id) async {
    var RatingID = FetchData.baseURL + "/rating/" + id.toString();
    var res = await http.delete(
      Uri.parse(RatingID),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
  }
}
