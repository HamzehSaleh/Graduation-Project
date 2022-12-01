import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sampleproject/User/screens/mainScreen/serviceCards/myCalc_Folder/myCalc_body.dart';
import 'package:giffy_dialog/giffy_dialog.dart';

import 'package:numberpicker/numberpicker.dart';
import 'package:sampleproject/User/screens/mainScreen/serviceCards/myCalc_Folder/widgets/kitchen_Grid.dart';

import '../../../../../../Custom_widgets/CustomButton.dart';
import '../../../../../../Custom_widgets/CustomTextField.dart';
import '../../../../../../bar/buttomNavBar.dart';
import '../../../../../../features/splash/presentation/Auth/presentation/pages/login/loginpage.dart';
import '../../../../../../myadditional_folder/constants.dart';
import 'living_Grid.dart';

//List of Cards with size

class addDevice extends StatefulWidget {
  @override
  State<addDevice> createState() => _addDeviceState();
}

class _addDeviceState extends State<addDevice> {
  File? image;

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemorary = File(image.path);

      setState(() => this.image = imageTemorary);
    } on PlatformException catch (e) {
      print("catch picker");
    }
  }

  int _currentHorizontalIntValue = 10;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.12),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Column(
                    children: [
                      const Spacer(
                        flex: 1,
                      ),
                      myCustomTextField(
                        hint: "أدخل اسم الجهاز",
                        icon: Icons.person,
                      ),
                      const Spacer(
                        flex: 1,
                      ),
                      myCustomTextField(
                        hint: "أدخل استهلاك الجهاز (كيلو واط / ساعة)",
                        icon: Icons.person,
                      ),
                      const Spacer(
                        flex: 1,
                      ),
                      FlatButton_Picker("قم بادراج صورة الجهاز", Icons.image,
                          ImageSource.gallery),
                      const Spacer(
                        flex: 4,
                      ),
                      myCustomButton(
                        text: "اضافة",
                        toClass: loginPageClass(),
                      ),
                      const Spacer(
                        flex: 2,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  FlatButton FlatButton_Picker(String text, IconData icon, ImageSource source) {
    return FlatButton(
      color: Colors.transparent,
      splashColor: Colors.black26,
      onPressed: () {
        pickImage(source);
      },
      child: Align(
          alignment: Alignment.topRight,
          child: Row(
            children: [
              Icon(
                icon,
                color: myMainColor,
              ),
              const Spacer(),
              Text(
                text,
                //textAlign: TextAlign.left,
                style: TextStyle(
                  color: myGray,
                  fontFamily: 'ALMARAI',
                  fontSize: 13,
                ),
              ),
              const Spacer(flex: 15),
            ],
          )),
    );
  }
}
