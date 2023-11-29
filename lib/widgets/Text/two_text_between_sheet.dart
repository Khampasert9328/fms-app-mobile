
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TwoTextBetween extends StatelessWidget {
  final String title;
  final String detail;
  const TwoTextBetween({super.key, required this.title, required this.detail});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: TextStyle(color: Colors.black87, fontSize: 12.sp)),
        Text(detail, style: TextStyle(color: Colors.black54, fontSize: 12.sp)),
      ],
    );
  }
}
