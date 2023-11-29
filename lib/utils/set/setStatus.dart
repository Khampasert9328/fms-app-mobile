import 'package:flutter/material.dart';
import 'package:fms_mobile_app/theme/color.dart';

class StatusColor {
  Color setStatusColor(int val) {
    Color? color;
    switch (val) {
      case -1:
        {
          color = Colors.red;
        }

        break;
      case 1:
        {
          color = Colors.yellow;
        }

        break;
      case 2:
        {
          color = Colors.yellow;
        }

        break;
      case 3:
        {
          color = Colors.yellow;
        }

        break;
      case 4:
        {
          color = primary;
        }

        break;
      default:
    }
    return color!;
  }
}
