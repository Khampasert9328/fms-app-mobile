import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fms_mobile_app/theme/color.dart';

class SettingItem extends StatelessWidget {
  final IconData? leadingIcon;
  final Color leadingIconColor;
  final Color bgIconColor;
  final String title;
  final GestureTapCallback? onTap;
  const SettingItem(
      {Key? key,
      required this.title,
      this.onTap,
      this.leadingIcon,
      this.leadingIconColor = Colors.white,
      this.bgIconColor = primary})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: bgIconColor != red
              ? [
                  Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                        color: Colors.transparent, shape: BoxShape.circle),
                    child: Icon(
                      // weight : 22.0,
                      // grade : 22.0,
                      leadingIcon,
                      // opticalSize : 22,
                      size: 22.0,
                    
                      color: bgIconColor,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                          fontSize: 16,
                          color: bgIconColor,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  
                     Icon(
                    Icons.arrow_forward_ios,
                    color: bgIconColor,
                    size: 17,
                  )
                ]
              : [
                  Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                        color: Colors.transparent, shape: BoxShape.circle),
                    child: Icon(
                      leadingIcon,
                      size: 22.0,
                      color: bgIconColor,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                          fontSize: 16,
                          color: bgIconColor,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
           
                ],
        ),
      ),
    );
  }
}
