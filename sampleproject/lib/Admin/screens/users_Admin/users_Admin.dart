import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sampleproject/Custom_widgets/CustomTextField.dart';
import 'package:sampleproject/myadditional_folder/constants.dart';
import 'package:http/http.dart' as http;

import '../../../APIs/fetchData.dart';
import '../../../APIs/models/userModel.dart';

class users_Admin extends StatefulWidget {
  const users_Admin({Key? key}) : super(key: key);

  @override
  State<users_Admin> createState() => _usersClass_body_employeeState();
}

class _usersClass_body_employeeState extends State<users_Admin> {
  FetchData _fetchData = FetchData();

  sendMessageDialog(BuildContext context) {
    TextEditingController customController = new TextEditingController();

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "ارسال رسالة خاصة",
              style: const TextStyle(fontFamily: myOtherFont, fontSize: 14),
            ),
            content: Container(
              height: 280,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                              width: 200,
                              child: Image.network(
                                sendMessage,
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          TextField(
                            controller: customController,
                            decoration: InputDecoration(
                              hintText: "أدخل نص الرسالة",
                              hintStyle: TextStyle(
                                  fontFamily: 'ALMARAI',
                                  fontSize: 15,
                                  color: TFmyGray),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              MaterialButton(
                elevation: 5.0,
                child: Text(
                  "ارسال",
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
  void initState() {
    // TODO: implement initState
    super.initState();
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
              // myCustomTextField(
              //   hint: "البحث عن مواطن",
              //   icon: Icons.search,
              // ),
              // SizedBox(
              //   height: 15,
              // ),
              // myUsersCard(
              //   "محمد جواد خورشيد مبسلط",
              //   "123654789",
              //   "0595266581",
              // ),
              fetchAllUsers(),

              Spacer(
                flex: 3,
              ),
            ],
          ),
        ))
      ],
    );
  }

  Padding myUsersCard(String name, String Identity, String phone, String _id) {
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
                  // mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Spacer(
                      flex: 3,
                    ),
                    Text(name,
                        style: TextStyle(
                            fontFamily: myOtherFont,
                            fontSize: 13,
                            color: myGray,
                            fontWeight: FontWeight.bold)),
                    const Spacer(
                      flex: 3,
                    ),
                    Text(" رقم الهوية  $Identity",
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
              PopupMenuButton(
                  itemBuilder: (context) => [
                        popupMenu(context, "حذف", _id),
                        popupMenu(context, "ارسال رسالة", _id),
                      ])
            ],
          )),
    );
  }

  PopupMenuItem<int> popupMenu(BuildContext context, String text, String _id) {
    return PopupMenuItem(
      child: Row(
        children: [
          Text(
            text,
            style: TextStyle(fontFamily: myOtherFont, fontSize: 13),
          ),
        ],
      ),
      value: 2,
      onTap: () {
        if (text == "حذف") {
          DeleteUser(_id);
          setState(() {});
        } else if (text == "ارسال رسالة")
          Future<void>.delayed(
            const Duration(),
            () => sendMessageDialog(context),
          );
      },
    );
  }

  Future createDialog(BuildContext context, String title) {
    TextEditingController customController = new TextEditingController();

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              title,
              style: const TextStyle(fontFamily: myOtherFont, fontSize: 14),
            ),
            content: Container(
              height: 260,
              child: Column(
                children: [
                  Container(width: 200, child: Image.network(error_subNum)),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "الدخول الى هذه الصفحة يتطلب منك ادخال رقم الاشتراك الخاص بك لتتمكن من حساب استهلاكك, أدخل رقم الاشتراك وحاول مرة اخرى",
                    style: style(),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              MaterialButton(
                elevation: 5.0,
                child: Text(
                  "موافق",
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

  Widget fetchAllUsers() {
    return FutureBuilder(
        future: _fetchData.allUsers(),
        builder: (contxt, snapchot) {
          var users = snapchot.data as List<userModel>;
          return snapchot.data == null
              ? CircularProgressIndicator(
                  value: 0.8,
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
                )
              : ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: users == null ? 0 : users.length,
                  itemBuilder: (context, index) {
                    return myUsersCard(
                      users[index].Name,
                      users[index].Identity,
                      users[index].phoneNumber,
                      users[index].id,
                    );
                  });
        });
  }

  Future<void> DeleteUser(id) async {
    var userID = FetchData.baseURL + "/users/" + id.toString();
    var res = await http.delete(
      Uri.parse(userID),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print(res.statusCode);
  }

  TextStyle style() {
    return TextStyle(
      fontFamily: myOtherFont,
      fontSize: 14,
    );
  }
}
