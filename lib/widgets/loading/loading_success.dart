// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fms_mobile_app/theme/color.dart';

class LoadingDialog extends StatelessWidget {
  final String title;
  VoidCallback onTap;

  LoadingDialog({Key? key, required this.title, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      content: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              "assets/images/success.gif",
              width: 200.w,
              height: 100.h,
            ),
            Text(title),
            SizedBox(
              height: 10.h,
            ),
            GestureDetector(
              onTap: onTap,
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 30.h,
                decoration: BoxDecoration(color: primary, borderRadius: BorderRadius.circular(10)),
                child: const Text(
                  "ຕົກລົງ",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
