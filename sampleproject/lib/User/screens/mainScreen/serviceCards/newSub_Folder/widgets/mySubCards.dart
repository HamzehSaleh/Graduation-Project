import 'package:flutter/material.dart';
import 'package:vertical_card_pager/vertical_card_pager.dart';

class mySubCard extends StatefulWidget {
  @override
  _mySubCardState createState() => _mySubCardState();
}

class _mySubCardState extends State<mySubCard> {
  @override
  Widget build(BuildContext context) {
    final List<String> titles = [
      "RED",
      "YELLOW",
      "BLACK",
      "CYAN",
      "BLUE",
      "GREY",
    ];

    final List<Widget> images = [
      Container(
        color: Colors.red,
      ),
      Container(
        color: Colors.yellow,
      ),
      Container(
        color: Colors.black,
      ),
      Container(
        color: Colors.cyan,
      ),
      Container(
        color: Colors.blue,
      ),
      Container(
        color: Colors.grey,
      ),
    ];
    return SafeArea(
      child: Column(
        children: <Widget>[
          Container(
            child: VerticalCardPager(
              textStyle:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              titles: titles,
              images: images,
              onPageChanged: (page) {},
              align: ALIGN.CENTER,
              onSelectedItem: (index) {},
            ),
          ),
        ],
      ),
    );
  }
}
