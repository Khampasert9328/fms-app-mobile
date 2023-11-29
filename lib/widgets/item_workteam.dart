import 'package:flutter/material.dart';

import 'package:fms_mobile_app/theme/color.dart';
import 'package:badges/badges.dart' as badges;

class ItemWorkTeam extends StatelessWidget {
  final IconData? leadingIcon;
  // final Color leadingIconColor;
  final Color bgIconColor;
  final String title;
  final String? cout;
  final GestureTapCallback? onTap;
  const ItemWorkTeam(
      {Key? key,
      required this.title,
      this.onTap,
      this.cout,
      this.leadingIcon,
      // this.leadingIconColor = Colors.white,
      this.bgIconColor = primary})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 2, horizontal: 2),
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: appBgColor,
            borderRadius: BorderRadius.circular(13),
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
        child: ListTile(
          leading: Icon(
            leadingIcon,
            size: 33,
            color: primary,
          ),
          title: Text(title),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
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
                Icons.keyboard_arrow_right,
                size: 33,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
