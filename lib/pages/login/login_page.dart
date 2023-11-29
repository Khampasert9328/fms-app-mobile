import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fms_mobile_app/services/auth_service.dart';
import 'package:fms_mobile_app/services/provider_service.dart';
import 'package:fms_mobile_app/widgets/bezierContainer.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _fromKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> loginUser() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final providerService = Provider.of<ProviderService>(context, listen: false);
    await authService.signInWithEmailAndPasswords(emailController.text, passwordController.text);
    providerService.setUserDetailModel();
  }

  @override
  Widget _submitButton() {
    return InkWell(
        onTap: () {
          if (_fromKey.currentState!.validate()) {
            loginUser();
          }
        },
        child: Container(
          width: MediaQuery.of(context).size.width,

          // ignore: prefer_const_constructors
          padding: EdgeInsets.symmetric(vertical: 15),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              // ignore: prefer_const_constructors
              borderRadius: BorderRadius.all(Radius.circular(5)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.shade200,
                    // ignore: prefer_const_constructors
                    offset: Offset(2, 4),
                    blurRadius: 5,
                    spreadRadius: 2)
              ],
              // ignore: prefer_const_constructors
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  // ignore: prefer_const_literals_to_create_immutables
                  colors: [Color(0xff1C9A7F), Color(0xff1C9A7F)])),
          child: const Text(
            'Login',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ));
  }

  Widget _createAccountLabel() {
    return InkWell(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          // ignore: prefer_const_literals_to_create_immutables
          children: <Widget>[
            Text(
              'Forgot Password',
              style: TextStyle(color: Color(0xff1C9A7F), fontSize: 13, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // ignore: prefer_const_literals_to_create_immutables
          children: <Widget>[
            const Text(
              "Email",
              // ignore: prefer_const_constructors
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            // ignore: prefer_const_constructors
            SizedBox(
              height: 10,
            ),
            TextFormField(
              // ignore: prefer_const_constructors
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                border: InputBorder.none,
                fillColor: Color(0xfff3f3f4),
                filled: true,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "ກະລຸນາປ້ອນ Email";
                }
                return null;
              },
            )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // ignore: prefer_const_literals_to_create_immutables
          children: <Widget>[
            const Text(
              "Password",
              // ignore: prefer_const_constructors
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            // ignore: prefer_const_constructors
            SizedBox(
              height: 10,
            ),
            TextFormField(
              obscureText: true,
              // ignore: prefer_const_constructors
              controller: passwordController,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(border: InputBorder.none, fillColor: Color(0xfff3f3f4), filled: true),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Container(
      height: height,
      child: Stack(
        children: <Widget>[
          Positioned(top: -height * .25, right: -MediaQuery.of(context).size.width * .4, child: BezierContainer()),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Form(
                key: _fromKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: height * .2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset("assets/images/logo.svg",
                            width: 150, color: Color(0xff1C9A7F), semanticsLabel: 'A red up arrow'),
                      ],
                    ),
                    SizedBox(height: 50),
                    _emailPasswordWidget(),
                    SizedBox(height: 20),
                    _submitButton(),
                    SizedBox(height: 10),
                    _createAccountLabel(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
