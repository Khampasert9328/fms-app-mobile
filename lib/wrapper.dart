import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fms_mobile_app/pages/home/home_app.dart';
import 'package:fms_mobile_app/pages/login/login_page_new.dart';


class Wrapper extends StatefulWidget {

  State<Wrapper> createState() => _WrapperState();
}
  @override
class _WrapperState extends State<Wrapper> {
 late Widget child;
  void checkLogin(BuildContext context) async {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if (user != null) {
      child = const HomeApp();
    } else {
      child = const LoginPageNew();
    }
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.push(context, MaterialPageRoute(builder: (_) => child));
    });
  }

  @override
  void initState() {
    checkLogin(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
