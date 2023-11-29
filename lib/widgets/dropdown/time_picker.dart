// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TimePicker extends StatelessWidget {
  ValueChanged<DateTime> timeChanged;
  TimePicker({Key? key, required this.timeChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "ສຳເລັດ",
              style: TextStyle(fontSize: 16.sp, color: Colors.black),
            ),
          ),
          Expanded(
              child: CupertinoDatePicker(
                use24hFormat: true,
                mode: CupertinoDatePickerMode.time,
                onDateTimeChanged: timeChanged
              ))
        ],
      ),
    );
  }
}




