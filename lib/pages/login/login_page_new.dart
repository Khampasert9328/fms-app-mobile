// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fms_mobile_app/pages/resetpassword/resetpassword.dart';
import 'package:fms_mobile_app/services/provider_service.dart';
import 'package:fms_mobile_app/services/service.dart';

import 'package:fms_mobile_app/theme/color.dart';
import 'package:fms_mobile_app/widgets/login/Header.dart';
import 'package:provider/provider.dart';

class LoginPageNew extends StatefulWidget {
  const LoginPageNew({Key? key}) : super(key: key);

  @override
  State<LoginPageNew> createState() => _LoginPageNewState();
}

class _LoginPageNewState extends State<LoginPageNew> {
  final _fromKey = GlobalKey<FormState>();
  bool _obscureText = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final providerService = Provider.of<ProviderService>(context, listen: false);
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(begin: Alignment.centerLeft, colors: [
            Color(0xff039881),
            Color(0xff024C41),
          ]),
        ),
        height: height,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(top: 5.h),
                child: Column(
                  children: [
                    Header(),
                    Container(
                      width: 340.w,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white,
                            blurRadius: 0.4,
                            offset: Offset(0, 0.5),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(30),
                        child: SingleChildScrollView(
                          child: 
                          Form(
                            key: _fromKey,
                            child: 
                            Column(
                              children: <Widget>[
                                SizedBox(height: height * .01),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      Center(
                                        child: Text(
                                          providerService.langs == 'la' ? "ເຂົ້າສູ່ລະບົບ" : "Login",
                                          style: const TextStyle(
                                            color: primary,
                                            fontSize: 34,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: height * .01),
                                      SizedBox(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              providerService.langs == 'la' ? "ອີເມວ" : "Email:",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                                color: Color(0xff1C9A7F),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                     
                                            TextFormField(
                                              controller: emailController,
                                              keyboardType: TextInputType.emailAddress,
                                              decoration: InputDecoration(
                                                  hintText: "email:",
                                                  prefixIcon: const Icon(
                                                    Icons.email_outlined,
                                                    color: Color(0xff1C9A7F),
                                                  ),
                                                  border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(10.0),
                                                  ),
                                                  contentPadding: const EdgeInsets.symmetric(
                                                    vertical: 15.0,
                                                    horizontal: 20.0,
                                                  ),
                                                  enabledBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(10.0),
                                                    borderSide: BorderSide(
                                                      color: const Color(0xff1C9A7F).withOpacity(0.50),
                                                      width: 2.0,
                                                    ),
                                                  ),
                                                  fillColor: const Color(0xfff3f3f4),
                                                  filled: true),
                                              validator: (value) {
                                                if (value == null || value.isEmpty) {
                                                  return providerService.langs == 'la'
                                                      ? "ກະລຸນາປ້ອນ Email"
                                                      : "Please enter an email";
                                                }

                                                return null;
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: height * .01,
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            providerService.langs == 'la' ? "ລະຫັດຜ່ານ" : "Password:",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                              color: Color(0xff1C9A7F),
                                            ),
                                          ),
                                          SizedBox(
                                            height: height * .01,
                                          ),
                                          TextFormField(
                                            obscureText: _obscureText,
                                            controller: passwordController,
                                            keyboardType: TextInputType.visiblePassword,
                                            decoration: InputDecoration(
                                                hintText: "password:",
                                                prefixIcon: const Icon(
                                                  Icons.lock_outline_rounded,
                                                  color: Color(0xff1C9A7F),
                                                ),
                                                suffixIcon: GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      _obscureText = !_obscureText;
                                                    });
                                                  },
                                                  child: Icon(
                                                    _obscureText ? Icons.visibility : Icons.visibility_off,
                                                    color: primary,
                                                  ),
                                                ),
                                                border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(10.0),
                                                ),
                                                contentPadding:
                                                    const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                                                enabledBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(10.0),
                                                  borderSide: BorderSide(
                                                    color: const Color(0xff1C9A7F).withOpacity(0.50),
                                                    width: 2.0,
                                                  ),
                                                ),
                                                fillColor: const Color(0xfff3f3f4),
                                                filled: true),
                                            validator: (value) {
                                              if (value == null || value.isEmpty) {
                                                return "ກະລຸນາປ້ອນ ລະຫັດຜ່ານ";
                                              }
                                              return null;
                                            },
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: height * .01,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    InkWell(
                                      child: Text(
                                        providerService.langs == 'la' ? "ລືມລະຫັດຜ່ານ?" : "Forgot password?",
                                        style: const TextStyle(color: Colors.grey),
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                            context, MaterialPageRoute(builder: (context) => const ResetPass()));
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: height * .01,
                                ),
                                InkWell(
                                  onTap: () {
                                    if (_fromKey.currentState!.validate()) {
                                  
                                      ServiceAuth().loginUser(
                                        context,
                                        emailController.text,
                                        passwordController.text,
                                      );
                                    }
                                  },
                                  child: Container(
                                    height: 50.h,
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(begin: Alignment.centerLeft, colors: [
                                        Color(0xff039881),
                                        Color(0xff024C41),
                                      ]),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Center(
                                      child: Text(
                                        providerService.langs == 'la' ? "ເຂົ້າສູ່ລະບົບ" : "Login",
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
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
      ),
    );
  }
}
