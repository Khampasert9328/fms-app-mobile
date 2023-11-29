import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fms_mobile_app/services/provider_service.dart';
import 'package:fms_mobile_app/shared/mydata.dart';
import 'package:fms_mobile_app/theme/color.dart';
import 'package:fms_mobile_app/widgets/custom_image.dart';
import 'package:provider/provider.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({Key? key}) : super(key: key);

  @override
  _LanguagePageState createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  String? _selectedLanguage;

  void _onLanguageSelected(String language) {
    setState(() {
      _selectedLanguage = language;
    });
    // MyApp.setLocale(context, Locale(language));
  }

  @override
  Widget build(BuildContext context) {
    final providerService =
        Provider.of<ProviderService>(context, listen: false);
    // final lang = Provider.of<ProviderService>(context, listen: false).lang;

    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        // systemOverlayStyle: SystemUiOverlayStyle.dark,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: black,
          ),
          onPressed: () {
            Navigator.pop(context, '');
          },
        ),
        title: Text(
          providerService.langs == 'la' ? "ປ່ຽນພາສາ" : 'Change Language',
          style: TextStyle(
              fontSize: 16.sp,
              // fontWeight: FontWeight.bold,
              color: black),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              color: appBgColor,

              // borderRadius: BorderRadius.circular(13),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade200,
                  spreadRadius: 2,
                  blurRadius: 2,
                  offset: const Offset(0, 2),
                ),
                BoxShadow(
                  color: Colors.grey.shade200,
                  spreadRadius: 2,
                  blurRadius: 2,
                  offset: const Offset(0, -2),
                ),
                BoxShadow(
                  color: Colors.grey.shade200,
                  spreadRadius: 2,
                  blurRadius: 2,
                  offset: const Offset(-2, 0),
                ),
                BoxShadow(
                  color: Colors.grey.shade200,
                  spreadRadius: 2,
                  blurRadius: 2,
                  offset: const Offset(2, 0),
                ),
              ]),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey.shade200,
                    ),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 3, horizontal: 4),
                  child: ListTile(
                    leading: CustomImage(
                      "https://fms-api.archiineergroup.la/profile/eng.png",
                      width: 50,
                      height: 40,
                      // radius: 20,
                    ),
                    title: Align(
                      alignment: Alignment.center,
                      child: Text(
                          providerService.langs == 'la'
                              ? "English"
                              : "English",
                          style: TextStyle(
                              fontSize: 15.sp,
                              color: providerService.langs == 'en'
                                  ? black
                                  : Colors.grey)),
                    ),
                    trailing: Icon(
                      CupertinoIcons.checkmark,
                      color: providerService.langs == 'en'
                          ? primary
                          : Colors.transparent,
                      size: 30,
                    ),
                    onTap: () async {
                      final providerService =
                          Provider.of<ProviderService>(context, listen: false);

                      await providerService.savePreference('en');
                      setState(() {
                        //     print(providerService.lang);
                        providerService.initLang();
                      });
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey.shade200,
                    ),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 3, horizontal: 4),
                  child: ListTile(
                    leading: CustomImage(
                      "https://fms-api.archiineergroup.la/profile/la.png",
                      width: 50,
                      height: 40,
                      // radius: 20,
                    ),
                    title: Align(
                      alignment: Alignment.center,
                      child: Text(
                          providerService.langs == 'la' ? "ພາສາລາວ" : "ພາສາລາວ",
                          style: TextStyle(
                              fontSize: 15.sp,
                              color: providerService.langs == 'la'
                                  ? black
                                  : Colors.grey)),
                    ),
                    trailing: Icon(
                      CupertinoIcons.checkmark,
                      color: providerService.langs == 'la'
                          ? primary
                          : Colors.transparent,
                      size: 30,
                    ),
                    onTap: () async {
                      final providerService =
                          Provider.of<ProviderService>(context, listen: false);

                      await providerService.changeLanguage('la');

                      setState(() {
                        context.read<ProviderService>().initLang();
                        //  print(providerService.lang);
                      });
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
