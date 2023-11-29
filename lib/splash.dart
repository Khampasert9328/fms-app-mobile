// ignore_for_file: unused_local_variable

import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fms_mobile_app/pages/home/home_app.dart';
import 'package:fms_mobile_app/pages/login/login_page_new.dart';
import 'package:fms_mobile_app/services/provider_service.dart';
import 'package:fms_mobile_app/shared/mydata.dart';
import 'package:fms_mobile_app/theme/color.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  String? version;
  FirebaseAuth _auth = FirebaseAuth.instance;
  late StreamSubscription<User?> _authStateSubscription;
  @override
  void initState() {
    super.initState();
    final providerService = Provider.of<ProviderService>(context, listen: false);
    providerService.initLang();
    _getAppVersion(context);
    checkVersions();
  }

  @override
  void dispose() {
    // Cancel the auth state subscription if it exists
    _authStateSubscription.cancel();
    super.dispose();
  }

  Future<void> _getAppVersion(BuildContext context) async {
    final providerService = Provider.of<ProviderService>(context, listen: false);
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      providerService.setVersion();
    });
  }

  Future checkVersions() async {
    final providerService = Provider.of<ProviderService>(context, listen: false);

    _authStateSubscription = _auth.authStateChanges().listen((User? user) async {
      if (user == null) {
        _navigaetohome(const LoginPageNew());
      } else {
        await providerService.setUserDetailModel();
        await providerService.setCheckAttend();
        await providerService.setSundayAndHoliday();
        await providerService.setAttendanceHistory();
        await providerService.setPendingDay();

        _navigaetohome(const HomeApp());
      }
    });
  }

  void _checkVersion() async {
    final status = await Permission.notification.status;

    if (status.isGranted) {
    } else {
      // await Permission.notification ;
      await openAppSettings();
    }
    // await checkUpdatable(version);
  }

  _navigaetohome(Widget widget) async {
    Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (ctx) => widget));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _lodingSplash());
  }

  Widget _lodingSplash() {
    final providerService = Provider.of<ProviderService>(context, listen: false);
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset("assets/images/logo.svg", width: 150, color: primary, semanticsLabel: 'A red up arrow'),
          const SizedBox(
            height: 50,
          ),
          // ignore: prefer_const_constructors
          Text(
            providerService.langs == 'la' ? "ກຳລັງກວດສອບ, ກະລຸນາລໍຖ້າ ... " : "Checking permission, Please Waiting...",
            style: const TextStyle(fontSize: 13, color: Colors.grey),
          ),
          const SizedBox(
            height: 15,
          ),

          // ignore: prefer_const_constructors
          SpinKitFadingCircle(
            color: primary,
          ),

          const SizedBox(
            height: 60,
          ),
          Center(
            child: Text(
              providerService.langs == 'la'
                  ? "ເວີຊັ່ນ :  ${MyData.versionApp.toString()}"
                  : "Version :  ${MyData.versionApp.toString()}",
              style: const TextStyle(fontSize: 13, color: Colors.grey),
            ),
          )
        ],
      ),
    );
  }
}
