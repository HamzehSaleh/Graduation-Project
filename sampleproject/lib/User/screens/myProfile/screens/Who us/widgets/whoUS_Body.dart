import 'package:flutter/material.dart';

import 'package:sampleproject/Custom_widgets/CustomCoverAvatarProfile.dart';
import 'package:sampleproject/myadditional_folder/constants.dart';

class whoUS_Body extends StatelessWidget {
  const whoUS_Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: Column(
              children: [
                const Spacer(),
                Image(
                    image: NetworkImage(whoUS),
                    height: screenHeight * 0.42,
                    width: screenWidth * 0.8),
                SizedBox(
                  height: 40,
                ),
                Text(
                  " كهربائي هو مشروع يهدف الى خدمة المواطنين و موظفي قسم الكهرباء في مدينة طولكرم, حيث يوفر المشروع العديد من الخدمات التي تساعد في توفيراستهلاك الكهرباء و الحصول على خدمة جيدة ",
                  style: style(15),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "يتيح المشروع امكانية اسخدام الموقع الالكتروني او تطبيق الهاتف الذكي وذلك لتسهيل الوصول للخدمات",
                  style: style(15),
                ),
                const Spacer(flex: 5),
              ],
            ))
          ],
        ),
      ),
    );
  }

  TextStyle style(double fontSize) =>
      TextStyle(fontFamily: myOtherFont, fontSize: fontSize);
}
