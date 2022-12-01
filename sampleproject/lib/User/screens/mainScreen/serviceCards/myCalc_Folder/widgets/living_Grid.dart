import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sampleproject/User/screens/mainScreen/serviceCards/myCalc_Folder/myCalc_body.dart';
import 'package:giffy_dialog/giffy_dialog.dart';

import 'package:numberpicker/numberpicker.dart';
import 'package:sampleproject/User/screens/mainScreen/serviceCards/myCalc_Folder/widgets/kitchen_Grid.dart';
import 'package:sampleproject/User/screens/mainScreen/serviceCards/myCalc_Folder/widgets/other_Grid.dart';

import '../../../../../../bar/buttomNavBar.dart';
import '../../../../../../myadditional_folder/constants.dart';

//List of Cards with size

final List<double> result_List = [];
final List<double> consumption = [200, 2000, 90, 100];

final List<String> living_names = [
  "مكبرات صوت",
  "مكيف هواء",
  "بلاي ستيشن",
  "شاشة تلفاز",
];

final List<String> living_imgs = [
  sound,
  condition,
  playstaiton,
  TV,
];

List<StaggeredTile> _cardTile = <StaggeredTile>[
  StaggeredTile.count(2, 3),
  StaggeredTile.count(2, 2),
  StaggeredTile.count(2, 3),
  StaggeredTile.count(2, 2),
];

double living_result = 0;

int public_index = -1;
int new_horizontal = 1;
BuildContext? public_context;

List<Widget> _listTile = <Widget>[
  BackGroundTile(
    text: living_names[++public_index],
    index: public_index,
    img: living_imgs[public_index],
  ),
  BackGroundTile(
    text: living_names[++public_index],
    index: public_index,
    img: living_imgs[public_index],
  ),
  BackGroundTile(
    text: living_names[++public_index],
    index: public_index,
    img: living_imgs[public_index],
  ),
  BackGroundTile(
    text: living_names[++public_index],
    index: public_index,
    img: living_imgs[public_index],
  ),
];

class myLivingGrid extends StatefulWidget {
  @override
  State<myLivingGrid> createState() => _myLivingGridState();
}

class _myLivingGridState extends State<myLivingGrid> {
  int _currentHorizontalIntValue = 10;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    public_context = context;

    return Stack(
      children: [
        Container(
          // Staggered Grid View starts here
          child: StaggeredGridView.count(
            crossAxisCount: 4,
            staggeredTiles: _cardTile,
            children: _listTile,
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
              onPressed: () {
                double result = 0;
                for (int i = 0; i < result_List.length; i++) {
                  result += result_List[i];
                }
                living_result = result;

                setState(() {
                  living_result;
                });
                //print("معدل اسهتهلاكك اليومي هو: " +
                //    (result + kitchen_result + other_result).toString() +
                //    " واط ");
                // result_List.clear();

                //  print("this is list" + result_List.toString());

                // resultDialog(context, result + kitchen_result + other_result);
              },
              child: Text(
                "حساب الاستهلاك وحفظ",
                style: const TextStyle(
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
          ),
        )
        //SubNumber_Dialog(),
      ],
    );
  }

  Future<dynamic> resultDialog(BuildContext context, double result) {
    return showDialog(
        context: context,
        builder: (_) => AssetGiffyDialog(
              buttonCancelText: Text(
                "الغاء",
                style: TextStyle(fontFamily: myOtherFont, color: Colors.white),
              ),
              buttonOkText: Text(
                "موافق",
                style: TextStyle(fontFamily: myOtherFont, color: Colors.white),
              ),
              key: keys[5],
              image: Image.network(
                myCalc,
                fit: BoxFit.cover,
              ),
              title: Text(
                'معدل استهلاكك اليومي',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w600,
                    fontFamily: myOtherFont),
              ),
              entryAnimation: EntryAnimation.BOTTOM_RIGHT,
              description: Text(
                'عزيزي المواطن معدل استهلاكك اليومي هو ${result / 1000}  كيلو واط وهو يزداد بشكل ملحوظ الرجاء الترشيد في استهلاكك حتى لا نضطر لقطع التيار الكهربائي في اوقات الذروة وشكرا',
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: myOtherFont),
              ),
              onOkButtonPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => buttomNavBarClass()),
                );
              },
            ));
  }
}

class BackGroundTile extends StatefulWidget {
  final String img;
  final String text;
  int? index;
  int houres = 0;

  BackGroundTile({required this.img, required this.text, required this.index});

  @override
  State<BackGroundTile> createState() => _BackGroundTileState();
}

class _BackGroundTileState extends State<BackGroundTile> {
  createAlertDialog(
    BuildContext context,
  ) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    TextEditingController customController = new TextEditingController();

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "اختيار عدد ساعات تشغيل الجهاز في اليوم الواحد",
              style: const TextStyle(fontFamily: myOtherFont, fontSize: 14),
            ),
            content: Container(
              height: screenHeight * 0.22,
              child: numberPicker_Class(),
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
                  //  _currentHorizontalIntValue
                  //print(kithcen_names[widget.index!].toString() +
                  //    "  " +
                  //    consumption[widget.index!].toString());
                  // print();
                  widget.houres = new_horizontal;
                  print(widget.houres);
                  result_List.add(consumptionCalc(
                      new_horizontal, consumption[widget.index!]));
                  new_horizontal = 1;
                  // print((result_List));
                  setState(() {});
                  Navigator.of(context).pop(customController.text.toString());
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Card(
        child: Stack(
      alignment: Alignment.center,
      children: [
        Ink.image(
          image: NetworkImage(widget.img),
          height: screenHeight * 0.3,
          fit: BoxFit.fill,
          child: InkWell(
            onTap: () {},
          ),
        ),
        GestureDetector(
          onTap: () {
            createAlertDialog(
              context,
            );
            print(widget.index);
          },
          child: Container(
            width: screenWidth,
            height: screenHeight,
            decoration: BoxDecoration(
              //borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 40, 48, 211).withOpacity(0.3),
                  Colors.black.withOpacity(0.1)
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
        ),
        Positioned(
          left: 15,
          top: 10,
          child: Row(
            children: [
              Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: myMainColor),
                    // color: Colors.red,
                    width: 70,
                    height: 27,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        widget.houres.toString() + " " + "ساعة",
                        style: TextStyle(
                            fontFamily: myOtherFont,
                            fontSize: 15,
                            color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        Positioned(
          right: 20,
          bottom: 15,
          child: Row(
            children: [
              Text(
                widget.text + "   ",
                style: TextStyle(
                    fontFamily: myOtherFont, fontSize: 17, color: Colors.white),
              ),
              //Text(
              //  "(اضغط لتحديد الساعات)",
              //  style: TextStyle(
              //      fontFamily: myOtherFont, fontSize: 11, color: myGray),
              //),
            ],
          ),
        ),
      ],
    ));
  }
}

class numberPicker_Class extends StatefulWidget {
  @override
  _numberPicker_ClassState createState() => _numberPicker_ClassState();
}

class _numberPicker_ClassState extends State<numberPicker_Class> {
  int _currentIntValue = 1;
  int _currentHorizontalIntValue = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        NumberPicker(
          value: _currentHorizontalIntValue,
          minValue: 1,
          maxValue: 24,
          step: 1,
          itemHeight: 100,
          axis: Axis.horizontal,
          onChanged: (value) {
            setState(() {
              _currentHorizontalIntValue = value;
              new_horizontal = _currentHorizontalIntValue;
            });
          },
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.black26),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.remove),
              onPressed: () => setState(() {
                final newValue = _currentHorizontalIntValue - 1;
                _currentHorizontalIntValue = newValue.clamp(1, 24);
                new_horizontal = _currentHorizontalIntValue;
              }),
            ),
            Text(
              'القيمة الحالية: ' + _currentHorizontalIntValue.toString(),
              style: TextStyle(fontFamily: myOtherFont),
            ),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () => setState(() {
                final newValue = _currentHorizontalIntValue + 1;
                _currentHorizontalIntValue = newValue.clamp(1, 24);
                new_horizontal = _currentHorizontalIntValue;
              }),
            ),
          ],
        ),
      ],
    );
  }
}

double consumptionCalc(int houres, double cons) => houres * cons;
