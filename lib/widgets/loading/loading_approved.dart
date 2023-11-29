// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fms_mobile_app/theme/color.dart';

class LoadingApproved {
  Future<void> showDialogLodingApproved(context, String title) async {
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
                    Image.asset(
                      'assets/images/loadingapprove.gif',
                      height: 150,
                      width: 100,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      title,
                      style: const TextStyle(color: primary),
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

  Future<void> LodingApprovedSuccess(context, String title) async {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => true,
          child: SimpleDialog(
            backgroundColor: Colors.white,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15),
                child: Center(
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/success.gif',
                        height: 150,
                        width: 150,
                      ),
                     
                      SizedBox(
                        height: 15.h,
                      ),
                      Text(
                        title,
                        style: const TextStyle(color: primary),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      GestureDetector(
                        onTap: (() {
                          Navigator.pop(context);
                        }),
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.only(right: 30, left: 30),
                          height: 30.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: primary,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Text(
                            'ຕົກລົງ',
                            style: TextStyle(
                              color: white,
                              fontSize: 15.sp
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
