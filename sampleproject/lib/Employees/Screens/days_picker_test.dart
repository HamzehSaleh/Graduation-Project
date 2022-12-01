import 'package:day_picker/day_picker.dart';
import 'package:day_picker/model/day_in_week.dart';
import 'package:flutter/material.dart';

class datePicker extends StatelessWidget {
  List<DayInWeek> _days = [
    DayInWeek(
      "سبت",
      isSelected: true,
    ),
    DayInWeek(
      "أحد",
      isSelected: true,
    ),
    DayInWeek(
      "اثنين",
      isSelected: true,
    ),
    DayInWeek(
      "ثلاثاء",
      isSelected: true,
    ),
    DayInWeek(
      "اربعاء",
      isSelected: true,
    ),
    DayInWeek("خميس", isSelected: true),
    DayInWeek("جمعة", isSelected: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SelectWeekDays(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            days: _days,
            onSelect: (values) {
              print(values);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SelectWeekDays(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            days: _days,
            border: false,
            boxDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                // 10% of the width, so there are ten blinds.
                colors: [
                  const Color(0xFFE55CE4),
                  const Color(0xFFBB75FB)
                ], // whitish to gray
                tileMode:
                    TileMode.repeated, // repeats the gradient over the canvas
              ),
            ),
            onSelect: (values) {
              print(values);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SelectWeekDays(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            days: _days,
            boxDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                // 10% of the width, so there are ten blinds.
                colors: [
                  const Color(0xFFE55CE4),
                  const Color(0xFFBB75FB)
                ], // whitish to gray
                tileMode:
                    TileMode.repeated, // repeats the gradient over the canvas
              ),
            ),
            onSelect: (values) {
              print(values);
            },
          ),
        ),
        SelectWeekDays(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          days: _days,
          backgroundColor: Color(0xFF303030),
          onSelect: (values) {
            print(values);
          },
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SelectWeekDays(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            days: _days,
            border: false,
            backgroundColor: Color(0xFF303030),
            onSelect: (values) {
              print(values);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SelectWeekDays(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            days: _days,
            border: false,
            boxDecoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(30.0),
            ),
            onSelect: (values) {
              print(values);
            },
          ),
        ),
      ],
    );
  }
}
