import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motion_toast/motion_toast.dart';

import 'package:sampleproject/Custom_widgets/CustomTextField.dart';
import 'package:sampleproject/myadditional_folder/constants.dart';

import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:day_night_time_picker/lib/constants.dart';
import 'package:vertical_card_pager/vertical_card_pager.dart';
import '../../../../../APIs/fetchData.dart';
import '../../../../../main.dart';
import 'widgets/mySubCards.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class newSubBody extends StatefulWidget {
  const newSubBody({Key? key}) : super(key: key);

  @override
  State<newSubBody> createState() => _newSubBodyState();
}

class _newSubBodyState extends State<newSubBody> {
  late List ImageData = [];
  late File imageFile;

  static final DateTime now = DateTime.now();
  static final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final String formatted = formatter.format(now);

  SlidingUpPanelController panelController = SlidingUpPanelController();

  late ScrollController scrollController;
  int myIndex = 0;

  @override
  void initState() {
    // panelController.hide();

    myIndex = 0;
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.offset >=
              scrollController.position.maxScrollExtent &&
          !scrollController.position.outOfRange) {
        panelController.expand();
      } else if (scrollController.offset <=
              scrollController.position.minScrollExtent &&
          !scrollController.position.outOfRange) {
        panelController.anchor();
      } else {}
    });
    super.initState();
  }

  final List<String> titles = [
    "اشتراك كهرباء منزلي 1 فاز",
    "اشتراك كهرباء تجاري صناعي 1 فاز",
    "معاملة تركيب عداد مسبق الدفع",
    "نقل عداد في نفس الموقع",
    "تبديل عداد الكهرباء",
    "تنازل عن اشتراك كهرباء",
    "معاملة ايقاف اشتراك كهرباء مؤقت",
    "طلب زيادة قدرة لاشتراك كهرباء",
    "فحص عداد كهرباء",
    "نقل اشتراك كهرباء",
    "اعادة توصيل اشتراك كهرباء",
  ];
  final List<String> cost = [
    "170 دينار",
    "170 دينار في حالة 3 فاز",
    "بدون رسوم",
    "5 دنانير",
    "بدون رسوم", // تبديل
    "بدون رسوم",
    "بدون رسوم", // ايقاف
    "حسب الرسوم المحتسبة لزيادة الرخصة",
    "5 دنانير",
    "50 دينار",
    "حسب فروقات التأمين",
  ];
  final List<String> docs = [
    " صورة عن البطاقة الشخصية \n بيان ذمة مالية للمواطن  براءة ذمة من ضريبة الاملاك \n	اثبات ملكية(رخصة بناء/عقد اجار/ موافقة المالك \nخطية/وكالة)	مخطط مصدق من وزارة الحكم المحلي \nتعهد عدلي من المحكمة خاص بالكرباء ( يتضمن ازالة \nاعمدة الكهرباء من الشوارع مرفق نص التعهد )",
    " صورة عن البطاقة الشخصية \n	بيان ذمة مالية للمواطن صاحب الاشتراك وفق ما هو \n متبع في حينه ومصدق من كافة الدوائر المعنية وبراءة\n ذمة من ضريبة الاملاك 	اثبات ملكية ( وهي احد التالي :\n رخصة بنا ، عقد اجار ،  موافقه المالك خطية او ينوب\n عنه بوكالة ) . في حال الطلب خارج حدود البلدية \n تعهد عدلي من المحكمة خاص بالكرباء  ( يتضمن ازالة \n اعمدة الكهرباء  من الشوارع مرفق نص التعهد ) ",
    " صورة عن البطاقة الشخصية \n	بيان ذمة مالية للمواطن صاحب الاشتراك\n وفق ما هو متبع في حينه ومصدق من كافة الدوائر المعنية \n وبراءة ذمة من ضريبة الاملاك \n	اثبات ملكية ( وهي احد التالي : رخصة بنا ، عقد اجار \n، موافقه المالك خطية او ينوب عنه بوكالة ) \n",
    "	صورة عن البطاقة الشخصية \n ",
    " صورة عن البطاقة الشخصية \n", // تبديل
    "	صورة عن البطاقة الشخصية \n يان ذمة مالية للمواطن صاحب الاشتراك وفق ما \n هو متبع في حينه ومصدق من كافة الدوائر المعنية\n وبراءة ذمة من ضريبة الاملاك \n	اثبات ملكية ( وهي احد التالي : رخصة بنا ، عقد اجار ،\n موافقه المالك خطية او ينوب عنه بوكالة ) \n 	اقرار من المتنازل اليه بإلغاء تنازل \nالاشتراك في حالة اعتراض الورثة او من ينوب عنهم \n	ورقة اقرار وتعهد بالديون ( قسم الجباية ) \n",
    "	صورة عن البطاقة الشخصية \n 	بيان ذمة مالية للمواطن صاحب الاشتراك \nوفق ما هو متبع في حينه ومصدق من كافة الدوائر\n المعنية وبراءة ذمة من ضريبة الاملاك \n 	دفع جميع المستحقات المترتبة على الاشتراك  \nاو اي استحقاقات اخرى للبلدية \n", // ايقاف
    " صورة عن البطاقة الشخصية  \n	سبب زيادة القوة واثبات على ذلك \n",
    "	بيانات اشتراك الكهرباء(رقم الاشتراك المراد فحصه) \n	صورة عن الهوية الشخصية \n 	بيان ذمة مالي ",
    "	صورة عن البطاقة الشخصية \n 	بيان ذمة مالية للمواطن صاحب الاشتراك وفق ما\n هو متبع في حينه ومصدق من كافة الدوائر المعنية\n وبراءة ذمة من ضريبة الاملاك \n 	اثبات ملكية من المواطن : صورة عن رخصة البناء\n أو صورة عن الطابو أو صورة عن عقد الايجار . في حال \nان الاشتراك خارج حدود البلدية) \n 	مخطط مصدق من وزارة الحكم المحلي \n	تعهد عدلي من المحكمة خاص بالكرباء ( يتضمن ازالة\n اعمدة الكهرباء من الشوارع مرفق نص التعهد ) \n ",
    "	صورة عن البطاقة الشخصية \n	بيان ذمة مالية للمواطن صاحب الاشتراك وفق ما هو  \nمتبع في حينه ومصدق من كافة الدوائر المعنية \n وبراءة ذمة من ضريبة الاملاك \n",
  ];

  final List<String> workRoad = [
    "مركز خدمة الجمهور - دائرة التخطيط والتطوير\n -  دائرة الكهرباء والقسم الفني \n– رئيس البلدية أو من يفوضه - امین الصندون -\n  دائرة الكهرباء و القسم الفني -  مركز خدمة الجمهور ",
    "مركز خدمة الجمهور - دائرة التخطيط والتطوير - \n دائرة الحرف و الصناعات – دائرة الكهرباء و القسم الفني \n – رئيس البلدية أو من يفوضه - امین الصندون - \n دائرة الكهرباء و القسم الفني -  مركز خدمة الجمهور ",
    "مركز خدمة الجمهور - \n دائرة الكهرباء و القسم الفني -  مركز خدمة الجمهور ",
    "مركز خدمة الجمهور - دائرة التخطيط والتطوير - \n دائرة الكهرباء والقسم الفني - امین الصندون - \n دائرة الكهرباء و القسم الفني -  مركز خدمة الجمهور ",
    "مركز خدمة الجمهور\n - دائرة الكهرباء الفني - امین الصندون - \n دائرة الكهرباء و القسم الفني -  مركز خدمة الجمهور",
    "مركز خدمة الجمهور -- \n دائرة الكهرباء– رئيس البلدية أو من يفوضه - - \n دائرة الكهرباء و القسم الفني -امین الصندون - \n دائرة الكهرباء و القسم الفني -  مركز خدمة الجمهور ",
    "مركز خدمة الجمهور  - \n دائرة الكهرباء و القسم الفني -  مركز خدمة الجمهور ",
    "مركز خدمة الجمهور -- \n دائرة الكهرباء– رئيس البلدية أو من يفوضه -\n -  دائرة الكهرباء و القسم الفني -امین الصندون - \n دائرة الكهرباء و القسم الفني -  مركز خدمة الجمهور  ",
    "مركز خدمة الجمهور\n -امین الصندون -  دائرة الكهرباء و القسم الفني ",
    "مركز خدمة الجمهور - دائرة التخطيط والتطوير– \nدائرة الكهرباء و القسم الفني  – رئيس البلدية أو من يفوضه \n- دائرة الكهرباء و القسم الفني  - امین الصندون - \n دائرة الكهرباء و القسم الفني -  مركز خدمة الجمهور",
    "مركز خدمة الجمهور  -   دائرة التخطيط و التطوير - \nدائرة الكهرباء و القسم الفني – امين الصندوق - \nدائرة الكهرباء و القسم الفني-   مركز خدمة الجمهور",
  ];

  final List<String> executeSide = [
    "دائرة الكهرباء",
    "دائرة الكهرباء",
    "دائرة الكهرباءو القسم الفني ",
    "دائرة الكهرباء والقسم الفني ",
    "دائرة الكهرباء والقسم الفني ",
    "دائرة الكهرباء",
    "دائرة الكهرباء و القسم الفني ",
    "دائرة الكهرباء و القسم الفني ",
    "دائرة الكهرباء و القسم الفني ",
    "دائرة الكهرباء و القسم الفني ",
    "دائرة الكهرباء و القسم الفني ",
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    final List<Widget> images = [
      newSubCard(home_elec, context), //0
      newSubCard(factory_Elec, context),
      newSubCard(electric_meter, context),
      newSubCard(repair_electric, context), //3
      newSubCard(change_electric, context),
      newSubCard(document_elec, context),
      newSubCard(noElec, context), // 6
      newSubCard(check_electric, context),
      newSubCard(repair_electric, context),
      newSubCard(document_elec, context),
      newSubCard(change_electric, context), // 10
    ];

    return Stack(
      children: <Widget>[
        Center(
          child: ListView(children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 50),
              child: Text(
                "وفرنا لكم امكانية تقديم طلب كهرباء الكتروني دون الحاجة الى التوجه الى البلدية.",
                style: style(),
              ),
            ),
            Container(
              height: screenHeight * 0.7,
              child: Column(
                children: [
                  Expanded(
                    child: VerticalCardPager(
                        titles: titles,
                        // requ ired
                        images: images, // required
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: myOtherFont,
                            fontSize: 10), // optional
                        onPageChanged: (page) {
                          // optional
                          // print("changed");
                        },
                        onSelectedItem: (index) {
                          panelController.expand();

                          setState(() {
                            myIndex = index;
                          });
                          print(index);
                          // optional
                        },
                        initialPage: 5, // optional
                        align: ALIGN.CENTER // optional
                        ),
                  ),
                ],
              ),
            ),
          ]),
        ),
        SlidingUpPanelWidget(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 0),
            decoration: const ShapeDecoration(
              color: Colors.white,
              shadows: [
                BoxShadow(
                    blurRadius: 5.0,
                    spreadRadius: 2.0,
                    color: Color(0x11000000))
              ],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
              ),
            ),
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  child: Row(
                    children: const <Widget>[
                      Icon(
                        Icons.menu,
                        size: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 8.0,
                        ),
                      ),
                      Text(
                        'اضغط هنا للاغلاق',
                        style: TextStyle(fontFamily: myOtherFont, fontSize: 12),
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                  height: 50.0,
                ),
                Divider(
                  height: 0.5,
                  color: Colors.grey[300],
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      // alignment: Alignment.topRight,
                      child: Align(
                        alignment: Alignment.topRight,
                        child: sheet(screenWidth),
                      ),
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
              mainAxisSize: MainAxisSize.min,
            ),
          ),
          controlHeight: 0,
          anchor: 0.4,
          panelController: panelController,
          onTap: () {
            ///Customize the processing logic
            if (SlidingUpPanelStatus.expanded == panelController.status) {
              panelController.collapse();
            } else {
              //  panelController.expand();
            }
          },
          enableOnTap: true, //Enable the onTap callback for control bar.
        ),
      ],
    );
  }

  Column sheet(double screenWidth) {
    return Column(
      children: [
        const Spacer(),
        sheetRowMethod(
          "عنوان الخدمة : ",
          titles[myIndex],
        ),
        const Spacer(),
        sheetRowMethod(
          "الرسوم المطلوبة : ",
          cost[myIndex],
        ),
        const Spacer(),
        Row(
          children: [
            const SizedBox(
              width: 20,
            ),
            Text(
              "الوثائق المطلوبة : ",
              style: sheetStyle(fontWeight: FontWeight.bold),
            ),
            const Spacer(),
          ],
        ),
        Row(
          children: [
            const SizedBox(
              width: 20,
            ),
            Column(
              children: [
                const SizedBox(
                  width: 20,
                ),
                Text(
                  docs[myIndex],
                  style: sheetStyle(fontSize: 15),
                ),
              ],
            ),
            const Spacer(
              flex: 3,
            ),
          ],
        ),
        const Spacer(),
        Row(
          children: [
            SizedBox(
              width: 20,
            ),
            Text(
              "مسار العمل : ",
              style: sheetStyle(fontWeight: FontWeight.bold),
            ),
            const Spacer(),
          ],
        ),
        Row(
          children: [
            const SizedBox(
              width: 20,
            ),
            Column(
              children: [
                const SizedBox(
                  width: 20,
                ),
                Text(
                  workRoad[myIndex],
                  style: sheetStyle(fontSize: 15),
                ),
              ],
            ),
            const Spacer(
              flex: 3,
            ),
          ],
        ),
        const Spacer(),
        sheetRowMethod(
          "جهة التنفيذ : ",
          executeSide[myIndex],
        ),
        const Spacer(
          flex: 1,
        ),
        // newElectronicFormButton(context),
        attachDocs(context),
        const Spacer(
          flex: 1,
        ),
        ElevatedButton(
          onPressed: () {
            SubRequest();
            panelController.collapse();
            // panelController.hide();
          },
          child: const Text(
            "حفظ و اغلاق ",
            style: TextStyle(
              fontFamily: myOtherFont,
            ),
          ),
          style: ElevatedButton.styleFrom(
              shadowColor: Colors.black,
              elevation: 3,
              primary: myMainColor,
              fixedSize: Size(screenWidth, screenWidth * 0.03),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
        ),
        const Spacer(
          flex: 1,
        ),
      ],
    );
  }

  Row sheetRowMethod(String title, String info) {
    return Row(
      children: [
        const SizedBox(
          width: 20,
        ),
        Text(
          title,
          style: sheetStyle(fontWeight: FontWeight.bold),
        ),
        Text(
          info,
          style: sheetStyle(fontSize: 15),
        ),
        const Spacer(
          flex: 4,
        ),
      ],
    );
  }

  TextStyle sheetStyle(
          {double fontSize = 16, FontWeight fontWeight = FontWeight.normal}) =>
      TextStyle(
        fontFamily: myOtherFont,
        fontWeight: fontWeight,
        fontSize: fontSize,
      );

  TextStyle style() => TextStyle(
      fontFamily: myOtherFont,
      fontWeight: FontWeight.bold,
      fontSize: 15,
      color: myMainColor);

  Stack newSubCard(String img, BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        Container(
            decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(img),
            fit: BoxFit.fill,
          ),
        )),
        Container(
          width: screenWidth,
          height: screenHeight,
          decoration: BoxDecoration(
            //borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 5, 8, 66).withOpacity(0.5),
                Colors.black.withOpacity(0.5)
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              stops: [0.1, 0.7],
              tileMode: TileMode.repeated,
            ),
          ),
          child: Column(
            children: [],
          ),
        ),
      ],
    );
  }

  Widget buildImageCard(double screenHeight, String text, String img) =>
      Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Card(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Ink.image(
                image: NetworkImage(myMenAvatar),
                height: screenHeight * 0.3,
                fit: BoxFit.cover,
                child: InkWell(
                  onTap: () {},
                ),
              ),
              Positioned(
                right: 20,
                bottom: 10,
                child: Text(
                  text,
                  style: TextStyle(
                      fontFamily: myOtherFont,
                      fontSize: 17,
                      color: Colors.white),
                ),
              )
            ],
          ),
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
      );

  //FlatButton newElectronicFormButton(BuildContext context) {
  //  return FlatButton(
  //    color: Colors.transparent,
  //    splashColor: Colors.black26,
  //    onPressed: () {},
  //    child: Align(
  //        alignment: Alignment.topRight,
  //        child: Row(
  //          children: [
  //            Icon(
  //              Icons.dvr,
  //              color: myMainColor,
  //            ),
  //            const Spacer(
  //              flex: 2,
  //            ),
  //            Text(
  //              "زيارة موقع البلدية الالكتروني لطلب اشتراك جديد ",
  //              //textAlign: TextAlign.left,
  //              style: TextStyle(
  //                color: myMainColor,
  //                fontFamily: 'ALMARAI',
  //                fontSize: 13,
  //              ),
  //            ),
  //            const Spacer(flex: 15),
  //          ],
  //        )),
  //  );
  //}

  FlatButton attachDocs(BuildContext context) {
    return FlatButton(
      color: Colors.transparent,
      splashColor: Colors.black26,
      onPressed: () {
        openImages();
      },
      child: Align(
          alignment: Alignment.topRight,
          child: Row(
            children: [
              Icon(
                Icons.description,
                color: myMainColor,
              ),
              const Spacer(
                flex: 1,
              ),
              Text(
                "اضغط هنا لارفاق جميع صور الوثائق المطلوبة",
                //textAlign: TextAlign.left,
                style: TextStyle(
                  color: myMainColor,
                  fontFamily: 'ALMARAI',
                  fontSize: 13,
                ),
              ),
              const Spacer(flex: 15),
            ],
          )),
    );
  }

  final ImagePicker imgpicker = ImagePicker();
  List<XFile>? imagefiles = [];

  openImages() async {
    try {
      final List<XFile>? pickedfiles = await imgpicker.pickMultiImage();

      imagefiles!.addAll(pickedfiles!);

      for (int i = 0; i < imagefiles!.length; i++) {
        print(imagefiles!.elementAt(i).path);
        imageFile = File(imagefiles!.elementAt(0).path);
        var rr = base64Encode(imageFile.readAsBytesSync());
        ImageData.add(rr);
      }

      _displayWarningMotionToast();
      setState(() {
        print(ImageData.length);

        print(ImageData.toString());
      });
    } catch (e) {
      print("error while picking file.");
    }
  }

  // pickImage(source) async {
  //   try {
  //     final pickedImage = await ImagePicker().pickImage(source: source);
  //     if (pickedImage == null) return;

  //     setState(() {
  //       this.imageFile = File(pickedImage.path);
  //       // print(ImageName);
  //     });
  //     ImageData = base64Encode(imageFile.readAsBytesSync());
  //     return ImageData;
  //   } on PlatformException catch (e) {
  //     print("catch picker");
  //     return null;
  //   }
  // }

  Future<void> SubRequest() async {
    // print(ImageData.toString());
    var body1 = jsonEncode({
      "name": titles[myIndex],
      "photos": ['test'],
      "service_date": formatted,
    });
    var res = await http.post(Uri.parse(FetchData.baseURL + "/services"),
        headers: {
          "Authorization": "Bearer " + prefs.get("token").toString(),
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: body1);

    // print(res.body);

    if (res.statusCode == 201) {
      print("problem successfully sent");
    } else {
      print("problem can't be sent ");
    }
  }

  void _displayWarningMotionToast() {
    MotionToast.success(
      title: const Text(
        'تم ارسال المرفقات بنجاح',
        style: TextStyle(fontWeight: FontWeight.bold, fontFamily: myOtherFont),
      ),
      description: const Text(
        'عزيزي المواطن سوف يتم النظر في هذه الوئائق تبليغك بحالة الطلب ',
        style: TextStyle(fontFamily: myOtherFont, fontSize: 12),
      ),
      animationCurve: Curves.bounceIn,
      borderRadius: 0,
      animationDuration: const Duration(milliseconds: 3000),
    ).show(context);
  }
}
