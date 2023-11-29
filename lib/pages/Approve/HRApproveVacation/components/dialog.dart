import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fms_mobile_app/theme/color.dart';

class DialogData extends StatefulWidget {
  const DialogData({super.key});

  @override
  State<DialogData> createState() => _DialogDataState();
}

class _DialogDataState extends State<DialogData> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: Stack(
      children: [
        const Positioned(
          top: -10,
          right: -10,
          child: Icon(Icons.cancel),
        ),
        Container(
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [Text("data")],
          ),
        ),
      ],
    ));
  }
}
