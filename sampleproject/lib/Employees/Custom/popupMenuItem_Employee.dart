//import 'dart:js';

import 'package:flutter/material.dart';

import '../../myadditional_folder/constants.dart';

class popupMenuItems_Custom extends StatelessWidget {
  const popupMenuItems_Custom({
    Key? key,
  }) : super(key: key);

  createAlertDialog(BuildContext context, String hint, String title) {
    TextEditingController customController = new TextEditingController();

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              title,
              style: const TextStyle(fontFamily: myOtherFont, fontSize: 14),
            ),
            content: TextField(
              controller: customController,
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(
                    fontFamily: 'ALMARAI', fontSize: 15, color: TFmyGray),
              ),
            ),
            actions: <Widget>[
              MaterialButton(
                elevation: 5.0,
                child: Text(
                  "حفظ",
                  style: const TextStyle(
                    fontFamily: myOtherFont,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop(customController.text.toString());
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        itemBuilder: (context) => [
              PopupMenuItem(
                child: Row(
                  children: [
                    Text(
                      'حذف',
                      style: TextStyle(fontFamily: myOtherFont, fontSize: 13),
                    ),
                  ],
                ),
                value: 2,
                onTap: () {
                  print("delteeeeeee");
                },
              ),
              PopupMenuItem(
                child: Row(
                  children: [
                    Text(
                      'ارسااال رسالة',
                      style: TextStyle(fontFamily: myOtherFont, fontSize: 13),
                    ),
                  ],
                ),
                value: 2,
                onTap: () {
                  print("sendddd msgggg");
                  // createAlertDialog(context, "hint", "text");
                },
              ),
            ]);
  }

  
}
