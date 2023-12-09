import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fms_mobile_app/theme/color.dart';

class DialogError extends StatefulWidget {
  String text;
  VoidCallback onTap;
  DialogError({super.key, required this.text, required this.onTap});

  @override
  State<DialogError> createState() => _DialogErrorState();
}

class _DialogErrorState extends State<DialogError> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.h,
      width: 200.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Image.asset(
            'assets/images/question.png',
            height: 50.h,
            width: 50.w,
          ),
          Text(
            "ເກີດຂໍ້ຜິດພາດ",
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          Text(
            widget.text,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          GestureDetector(
            onTap: widget.onTap,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(23.r),
                color: primary,
              ),
              child: Text(
                "ຕົກລົງ",
                style: TextStyle(fontSize: 14.sp, color: white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
