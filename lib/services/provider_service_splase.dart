import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fms_mobile_app/pages/home/home_app.dart';
import 'package:fms_mobile_app/pages/login/login_page_new.dart';
import 'package:fms_mobile_app/services/provider_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import 'package:package_info_plus/package_info_plus.dart';

class ProviderSplase extends ChangeNotifier {
 

  Future checkVersions(context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    late StreamSubscription<User?> authStateSubscription;
    final providerService = Provider.of<ProviderService>(context, listen: false);

    authStateSubscription = _auth.authStateChanges().listen((User? user) async {
      if (user == null) {
        _navigaetohome(const LoginPageNew(), context);
      } else {
        await providerService.setUserDetailModel();
        await providerService.setCheckAttend();
        await providerService.setSundayAndHoliday();
        await providerService.setAttendanceHistory();
        await providerService.setPendingDay();

        _navigaetohome(const HomeApp(), context);
      }
    });
  }

  _navigaetohome(Widget widget, context) async {
    Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (ctx) => widget));
  }

  Future<void> initlang(context) async {
    final providerService = Provider.of<ProviderService>(context, listen: false);
    providerService.initLang();
    notifyListeners();
  }

  void checkVersion() async {
    final status = await Permission.notification.status;

    if (status.isGranted) {
    } else {
      // await Permission.notification ;
      await openAppSettings();
    }
    // await checkUpdatable(version);
  }
}
