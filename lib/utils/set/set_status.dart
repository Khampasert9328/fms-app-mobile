import 'package:flutter/material.dart';

class SetStatus {
  Color statusColor(int val) {
    Color? color;
    switch (val) {
      case -1:
        {
          color = Colors.orange;
        }
        break;
      case 0:
        {
          color = Colors.red;
        }
        break;
      case 1:
        {
          color = Colors.green;
        }
        break;
    }
    return color!;
  }

  String status(BuildContext context, int val) {
    String? status;
    switch (val) {
      case -1:
        {
          status = 'ລໍຖ້າອະນຸມັດ';
        }
        break;
      case 0:
        {
          status = 'ປະຕິເສດ';
        }
        break;
      case 1:
        {
          status = 'ອະນຸມັດ';
        }
        break;
     
    }
    return status ?? "";
  }
}
