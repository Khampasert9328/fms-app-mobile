import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fms_mobile_app/theme/color.dart';

class DurationContainerScreen extends StatelessWidget {
  final String title;
  final String subtitle;
  const DurationContainerScreen({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    //final color = Provider.of<OrganizeVm>(context, listen: false);
    // Color primary = Color(int.parse(color.primaryColor));
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.all(10),
          height: 30.h,
          width: 50.w,
          decoration: BoxDecoration(
              color: white,
              border: Border.all(color: primary),
              borderRadius: BorderRadius.circular(10)),
          child: Text(
            title,
            style: TextStyle(fontSize: 18.sp),
          ),
        ),
        Text(subtitle)
      ],
    );
  }
}