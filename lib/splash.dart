// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fms_mobile_app/services/provider_service.dart';
import 'package:fms_mobile_app/services/provider_service_splase.dart';
import 'package:fms_mobile_app/shared/mydata.dart';
import 'package:fms_mobile_app/theme/color.dart';
import 'package:provider/provider.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    context.read<ProviderService>().setVersion();
    context.read<ProviderSplase>().checkVersions(context);
    context.read<ProviderSplase>().initlang(context);
    super.initState();
  }

  // @override
  // void dispose() {
  //   // Cancel the auth state subscription if it exists
  //   _authStateSubscription.cancel();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderService>(
      builder: ((context, value, child) {
        return Scaffold(
          body: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset("assets/images/logo.svg",
                    width: 150, color: primary, semanticsLabel: 'A red up arrow'),
                const SizedBox(
                  height: 50,
                ),
                // ignore: prefer_const_constructors
                Text(
                  value.langs == 'la' ? "ກຳລັງກວດສອບ, ກະລຸນາລໍຖ້າ ... " : "Checking permission, Please Waiting...",
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
                    value.langs == 'la' ? "ເວີຊັ່ນ :  ${value.versionApp}" : "Version :  ${value.versionApp}",
                    style: const TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
