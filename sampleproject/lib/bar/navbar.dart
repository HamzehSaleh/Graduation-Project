import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:sampleproject/APIs/models/userModel.dart';
import 'package:sampleproject/User/screens/mainProfile/mainProfile.dart';

import 'package:sampleproject/User/screens/myProfile/screens/Change%20Password/changePass.dart';
import 'package:sampleproject/features/splash/presentation/Auth/presentation/pages/login/loginpage.dart';
import 'package:sampleproject/myadditional_folder/constants.dart';

import 'package:emoji_feedback/emoji_feedback.dart';
import '../APIs/fetchData.dart';
import '../User/screens/ContactUS/contactUS_Main.dart';
import '../User/screens/mainScreen/serviceCards/reportProblem.dart';
import 'package:http/http.dart' as http;

import '../main.dart';

import '../User/screens/myProfile/screens/Who us/whoUs.dart';


class navBar extends StatefulWidget {
  navBar({Key? key}) : super(key: key);

  @override
  State<navBar> createState() => _navBarState();
}

class _navBarState extends State<navBar> {
  FetchData _fetchData = FetchData();

  @override
  void initState() {
    super.initState();
    _fetchData.fetchMyAccount();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      //  backgroundColor: Colors.black38,
      child: ListView(
        padding: EdgeInsets.zero, // nice effect
        children: [

          userData(),

          // const UserAccountsDrawerHeader(
          //     accountName: Text(
          //       "محمد مبسلط",
          //       style: TextStyle(fontFamily: 'ALMARAI'),
          //     ),
          //     accountEmail: Text("mhmd.mubaslat@gmail.com"),
          //     currentAccountPicture: CircleAvatar(
          //       child: ClipOval(
          //         child: Image(
          //           image: NetworkImage(myMenAvatar),
          //           fit: BoxFit.cover,
          //           width: 90,
          //           height: 90,
          //         ),
          //       ),
          //     ),
          //     decoration: BoxDecoration(
          //       image: DecorationImage(
          //         image: NetworkImage(myProfileCover),
          //         fit: BoxFit.cover,
          //       ),
          //     )),
          // // ListTile(
          // //     leading: Icon(Icons.manage_accounts),
          // //     title: const Text(
          // //       'ملفي الشخصي',
          // //       style: TextStyle(fontFamily: 'ALMARAI'),
          // //     ),
          // //     onTap: () => Navigator.push(
          // //           context,
          // //           MaterialPageRoute(
          // //             builder: (context) => mainProfileClass(),
          // //           ),
          // //         )),

          ListTile(
            leading: Icon(Icons.report),
            title: const Text(
              'الابلاغ عن مشكلة',
              style: TextStyle(fontFamily: 'ALMARAI'),
            ),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => reportProblemClass(),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.lock),
            title: const Text(
              'تغيير كلمة المرور',
              style: TextStyle(fontFamily: 'ALMARAI'),
            ),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => changePassClass()),
            ),
          ),
          ListTile(
            leading: Icon(Icons.help),
            title: const Text(
              'من نحن؟',
              style: TextStyle(fontFamily: 'ALMARAI'),
            ),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => whoUS_Class(),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.phone_in_talk),
            title: const Text(
              'اتصل بنا',
              style: TextStyle(fontFamily: 'ALMARAI'),
            ),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => mainContactUSClass()),
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.stars_rounded),
            title: const Text(
              'تقييم التطبيق',
              style: TextStyle(fontFamily: 'ALMARAI'),
            ),
            onTap: () => _showRatingAppDialog(),
          ),
          ListTile(
              leading: Icon(Icons.logout_rounded),
              title: const Text(
                'خروج',
                style: TextStyle(fontFamily: 'ALMARAI'),
              ),
              onTap: () => LogoutAll()),
        ],
      ),
    );
  }

  void _showRatingAppDialog() {
    final _ratingDialog = RatingDialog(
      starColor: Colors.amber,
      title: const Text(
        'تقييم التطبيق',
        style: TextStyle(
            fontFamily: myOtherFont, fontSize: 17, fontWeight: FontWeight.bold),
      ),
      message: const Text(
        'اخبرنا عن رأيك بالتطبيق ومدى فعاليته',
        style: TextStyle(
            fontFamily: myOtherFont,
            fontSize: 15,
            fontWeight: FontWeight.normal),
      ),
      image: Image.network(
        rate,
        height: 100,
      ),
      submitButtonText: 'ارسال',
      onCancelled: () => print('cancelled'),
      onSubmitted: (response) {
        // print('rating: ${response.rating}, '
        //     'comment: ${response.comment}');
        Rating(response.rating.toInt(), response.comment);

        if (response.rating < 3.0) {
          print('response.rating: ${response.rating}');
        } else {
          Container();
        }
      },
    );

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => _ratingDialog,
    );

    void showRate() {
      EmojiFeedback(
        onChange: (index) {
          print(index);
        },
      );
    }
  }

  Widget userData() {
    return FutureBuilder(
        future: _fetchData.fetchMyAccount(),
        builder: (context, snapchot) {
          userModel data = snapchot.data as userModel;
          return snapchot.data == null
              ? Text('جاري التحميل...')
              : UserAccountsDrawerHeader(
                  accountName: Text(
                    data.Name,
                    style: TextStyle(fontFamily: 'ALMARAI'),
                  ),
                  accountEmail: Text(data.Email),
                  currentAccountPicture: CircleAvatar(
                    child: ClipOval(
                      child: Image(
                        image: NetworkImage(myMenAvatar),
                        fit: BoxFit.cover,
                        width: 90,
                        height: 90,
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(myProfileCover),
                      fit: BoxFit.cover,
                    ),
                  ));
        });
  }

  Future<void> Rating(int index, String note) async {
    var body = jsonEncode({
      'index': index,
      'note': note,
    });

    var res = await http.post(Uri.parse(FetchData.baseURL + "/rating"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body);

    if (res.statusCode == 201) {
      print("Thank you for Rating");
    } else {
      print("faild to Rate");
    }
  }

  Future<void> LogoutAll() async {
    var header = {"Authorization": "Bearer " + prefs.get("token").toString()};

    var res = await http.post(Uri.parse(FetchData.baseURL + "/users/logoutAll"),
        headers: header);
    if (res.statusCode == 200) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => loginPageClass()),
      );
    }
  }
}
