import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fms_mobile_app/model/user_info.dart';
import 'package:fms_mobile_app/services/auth_service.dart';
import 'package:fms_mobile_app/theme/color.dart';
import 'package:fms_mobile_app/widgets/dialog/dialog_error.dart';
import 'package:fms_mobile_app/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

//import 'package:provider/provider.dart';

//import 'auth_service.dart';

class ServiceAuth {
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;
  UserInfo? _userFromFirebase(auth.User? user) {
    if (user == null) {
      return null;
    }
    //return UserInfo(uid: user.uid, email: user.email);
    FMSUserInfo(uid: user.uid, email: user.email);
  }

  Stream<UserInfo?> get user {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

  Future<void> loginUser(context, email, password) async {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
              child: Container(
            height: 50.h,
            alignment: Alignment.center,
            child: const CircularProgressIndicator(
              color: primary,
            ),
          ));
        });
    final auth = Provider.of<AuthService>(context, listen: false);

    try {
      final res = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      auth.stdLoginInlogin(1);

      if (res.user != null) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => Wrapper()));
      }
      _userFromFirebase(res.user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                  child: DialogError(
                text: "ກາລຸນາກວດສອບອີເມລຂອງທ່ານ",
                onTap: () {
                  Navigator.pop(context);
                },
              ));
            });
      }

      // WRONG PASSWORD
      else if (e.code == 'wrong-password') {
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                  child: DialogError(
                text: "ກາລຸນາກວດສອບລະຫັດຜ່ານຂອງທ່ານ",
                onTap: () {
                  Navigator.pop(context);
                },
              ));
            });
        // show error to user
      }
    }
  }
}
