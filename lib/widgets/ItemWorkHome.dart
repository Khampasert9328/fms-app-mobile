import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:fms_mobile_app/theme/color.dart';

class ItemWorkHome extends StatelessWidget {
  final Widget icon;
  final String title;
  final String cout;
  final VoidCallback onPressed;

  const ItemWorkHome({
    Key? key,
    required this.icon,
    required this.title,
    required this.cout,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        cout == '0'
            ? ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: const MaterialStatePropertyAll<Color>(primary),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      const EdgeInsets.only(
                        bottom: 10,
                        top: 10,
                        left: -12,
                        right: -12,
                      ),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        // side: BorderSide(color: Colors.red),
                      ),
                    )),
                onPressed: onPressed,
                child: icon,
              )
            : badges.Badge(
                badgeContent: Text(
                  cout,
                  style: const TextStyle(color: appBarColor),
                ),
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: const MaterialStatePropertyAll<Color>(primary),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          const EdgeInsets.only(bottom: 10, top: 10, left: -12, right: -12)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          // side: BorderSide(color: Colors.red),
                        ),
                      )),
                  onPressed: onPressed,
                  child: icon,
                ),
              ),
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.black,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
