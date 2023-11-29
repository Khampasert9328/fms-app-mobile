import 'package:flutter/material.dart';
import 'package:fms_mobile_app/theme/color.dart';

class ShowDialoadingWidget {
  Future<void> showDialogLoding(context, String title) async {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => true,
          child: SimpleDialog(
            backgroundColor: Colors.white,
            children: <Widget>[
              Center(
                child: Column(
                  children: [
                    CircularProgressIndicator(),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      title,
                      style: TextStyle(color: primary),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Future<void> showDialogLodingAction(context) async {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return const AlertDialog(
          contentPadding: EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 0.0),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'ສຳເລັດ',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 25.0),
              Icon(
                Icons.check_circle_outline,
                color: Colors.green,
                size: 70.0,
              ),
              SizedBox(height: 60.0),
            ],
          ),

          // actions: <Widget>[
          //   TextButton(
          //     child: Text('OK'),
          //     onPressed: () {
          //       Navigator.of(context).pop();
          //     },
          //   ),
          // ],
        );
      },
    );
  }

  Future<void> showDialogUnsuccus(String? msg, context) async {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('ຂໍ້ຄວາມ'),
        content: Text("${msg == '' ? 'ກະລຸນາຕື່ມຂໍ້ມູນໃຫ້ຄົບຖ້ວນ' : msg}"),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
