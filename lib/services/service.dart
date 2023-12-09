import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fms_mobile_app/model/user_info.dart';
import 'package:fms_mobile_app/services/auth_service.dart';
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
      // showDialog(
      //   context: context,
      //   builder: (context) {
      //     return DialogError(
      //       text: 'ກາລຸນາກວດສອບອີເມລຂອງທ່ານໃຫ້ຖືກຕ້ອງ',
      //       onTap: () {
      //         Navigator.pop(context);
      //       },
      //     );
      //   },
      // );

      print('${e.code}');
      // pop the loading circle
      // Navigator.pop(context);
      // WRONG EMAIL
      if (e.code == 'user-not-found') {
        // show error to user
      }

      // WRONG PASSWORD
      else if (e.code == 'wrong-password') {
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
