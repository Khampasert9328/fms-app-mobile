import 'package:flutter/material.dart';
import 'package:fms_mobile_app/theme/color.dart';

class DisplayTimerUI extends StatelessWidget {

  final String header;
  final String time;

  const DisplayTimerUI({
    Key? key,
    required this.header,
    required this.time, 
 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
  
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: primary)),
            child: Text(time,
                // ignore: prefer_const_constructors
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 40)),
          ),
          Text(header, style: TextStyle(fontSize: 10, color: Colors.grey)),
        ],
      );
  }
}
