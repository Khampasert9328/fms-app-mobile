import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fms_mobile_app/model/user_info.dart';

class AuthService extends ChangeNotifier {
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;

  String errorMessage = "";
  int stdLogin = 0;

  //   set stdLoginInlogin(val) {

  //   notifyListeners();
  // }

  void stdLoginInlogin(int i) {
    stdLogin = i;
  }

  FMSUserInfo? _userFromFirebase(auth.User? user) {
    if (user == null) {
      return null;
    }
    return FMSUserInfo(uid: user.uid, email: user.email);
  }

  Stream<FMSUserInfo?> get user {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

  // ignore: body_might_complete_normally_nullable
  Future<FMSUserInfo?> signInWithEmailAndPasswords(
    String email,
    String password,
  ) async {
    EasyLoading.show(status: 'ກຳລັງເຂົ້າສູ່ລະບົບ...');

    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);

     
      stdLoginInlogin(1);

      EasyLoading.dismiss();
      return _userFromFirebase(credential.user);
    } on auth.FirebaseAuthException catch (error) {
      errorMessage = error.code;

      // ignore: unnecessary_null_comparison
      if (errorMessage != null) {
        EasyLoading.dismiss();
        //EasyLoading.showSuccess(errorMessage);
        EasyLoading.showError('ຜູ້ໃຊ້ນີ້ບໍ່ມີໃນລະບົບໃນລະບົບກາລຸນາຕິດຕໍ່ແອັດ');
        return Future.error(error.code);
      }
    } catch (e) {
      EasyLoading.dismiss();
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
