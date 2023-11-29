import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:fms_mobile_app/theme/color.dart';
import 'package:fms_mobile_app/widgets/custom_image.dart';

import 'package:badges/badges.dart' as badges;

class TeamItem extends StatelessWidget {
  final String profileImg;
  final String level;
  final String divisionname;
  final String fullname;
    final String? cout;
  final VoidCallback onPressed;
  // final String postImg;

  const TeamItem({
    Key? key,
    required this.profileImg,
    required this.fullname,
    required this.level,
     required this.cout,
    required this.divisionname,
   required this.onPressed,
    // required this.postImg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0, bottom: 15, left: 5, right: 5),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          height: 100,
          padding: const EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0),
          decoration: BoxDecoration(
              color: appBgColor,
              //color: providerService.mode== ThemeMode.light ? appBgColor : appBgColordark ,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade200,
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, 0.1),
                ),
                BoxShadow(
                  color: Colors.grey.shade200,
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, -0.1),
                ),
                BoxShadow(
                  color: Colors.grey.shade200,
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(-0.1, 0),
                ),
                BoxShadow(
                  color: Colors.grey.shade200,
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0.1, 0),
                ),
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // AvatarImage(MyData.profileImg, isSVG: false, width: 57, height: 57),
              CustomImage(
                profileImg,
                width: 57,
                height: 57,
                radius: 25,
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                  child: Container(
                alignment: Alignment.centerLeft,
                // color: Colors.red,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      fullname,
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: primary),
                    ),
                    Text(
                      level,
                      style: TextStyle(fontSize: 10.sp),
                    ),
                    Text(
                      divisionname,
                      style: TextStyle(fontSize: 10.sp),
                    ),
                  ],
                ),
              )),
         cout != '0'
                  ? badges.Badge(
                      badgeContent: Text(
                        '${cout}',
                        style: TextStyle(color: appBarColor),
                      ),
                    )
                  : SizedBox(),
              SizedBox(
                width: 15,
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.black87,
                size: 17,
              )
            ],
          ),
        ),
      ),
    );
  }
}
