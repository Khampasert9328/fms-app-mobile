// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api, unused_local_variable

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fms_mobile_app/pages/acount/pdf/pdf_viewer.dart';
import 'package:fms_mobile_app/pages/languagee/language_page.dart';
import 'package:fms_mobile_app/pages/login/login_page_new.dart';
import 'package:fms_mobile_app/pages/profile/profile_preview.dart';
import 'package:fms_mobile_app/pages/resetpassword/resetpassword.dart';
import 'package:fms_mobile_app/services/auth_service.dart';
import 'package:fms_mobile_app/services/provider_service.dart';
import 'package:fms_mobile_app/shared/mydata.dart';
import 'package:fms_mobile_app/theme/color.dart';
import 'package:fms_mobile_app/widgets/MyElevatedButton_Primary.dart';
import 'package:fms_mobile_app/widgets/MyElevatedButton_Secondary.dart';
import 'package:fms_mobile_app/widgets/custom_image.dart';
import 'package:fms_mobile_app/widgets/setting_item.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final providerService = Provider.of<ProviderService>(context);
    return Scaffold(
        // backgroundColor: appBgColor,
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.light,
          title: Center(
              child: Text(providerService.langs == 'la' ? "ການຕັ້ງຄ່າ" : "Setting",
                  textAlign: TextAlign.center, style: const TextStyle(color: Colors.white))),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[Color(0xff039881), Color(0xff024C41)]),
            ),
          ),
        ),
        body: CustomScrollView(
          slivers: <Widget>[SliverToBoxAdapter(child: getBody())],
        ));
  }

  Widget getBody() {
    final providerService = Provider.of<ProviderService>(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Column(
            children: [
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return SafeArea(
                        child: Wrap(
                          children: [
                            ListTile(
                              leading: const Icon(Icons.camera_alt_outlined),
                              title: Text(providerService.langs == 'la' ? ' ຖ່າຍຮູບ' : 'Camera'),
                              onTap: () async {
                                Navigator.of(context).pop();
                                XFile? file = await ImagePicker()
                                    .pickImage(source: ImageSource.camera, maxWidth: 1024, imageQuality: 80);
                                if (file != null) {
                                  providerService.setProFileForUpload(File(file.path));

                                  String? path = '';

                                  if (providerService.imageProFile?.path != null) {
                                    path = providerService.imageProFile?.path;
                                  }

                                  if (path == '' || path!.isEmpty) {
                                    return;
                                  }

                                  final res = await providerService.updateProfiles(path);

                                  if (res) {
                                    if (!mounted) return;
                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                      backgroundColor: primary,
                                      content: Text("ແກ້ໄຂຮູບສຳເລັດ"),
                                      duration: Duration(seconds: 2),
                                    ));
                                    providerService.setProFileForUpload(null);

                                    // Navigator.of(context).pop(true);
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                      backgroundColor: red,
                                      content: Text("ເລິ່ມວຽກບໍສຳເລັດ"),
                                      duration: Duration(seconds: 2),
                                    ));
                                    providerService.setProFileForUpload(null);
                                  }
                                }
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.photo_camera_back_outlined),
                              title: Text(providerService.langs == 'la' ? 'ເລືອກຮູບຈາກເຄື່ອງ ' : 'Photo Library'),
                              onTap: () async {
                                Navigator.of(context).pop();
                                XFile? file = await ImagePicker()
                                    .pickImage(source: ImageSource.gallery, maxWidth: 1024, imageQuality: 80);
                                if (file != null) {
                                  providerService.setProFileForUpload(File(file.path));

                                  String? path = '';

                                  if (providerService.imageProFile?.path != null) {
                                    path = providerService.imageProFile?.path;
                                  }

                                  if (path == '' || path!.isEmpty) {
                                    return;
                                  }

                                  final res = await providerService.updateProfiles(path);

                                  if (res) {
                                    if (!mounted) return;
                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                      backgroundColor: primary,
                                      content: Text("ແກ້ໄຂຮູບສຳເລັດ"),
                                      duration: Duration(seconds: 2),
                                    ));
                                    providerService.setProFileForUpload(null);

                                    // Navigator.of(context).pop(true);
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                      backgroundColor: red,
                                      content: Text("ເລິ່ມວຽກບໍສຳເລັດ"),
                                      duration: Duration(seconds: 2),
                                    ));
                                    providerService.setProFileForUpload(null);
                                  }
                                }
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: Stack(
                  children: [
                    // Profile picture
                    CustomImage(
                      MyData.profileImg,
                      width: 90,
                      height: 90,
                      // radius: 20,
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: IconTheme(
                          data: const IconThemeData(color: white),
                          child: IconButton(
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return SafeArea(
                                    child: Wrap(
                                      children: [
                                        ListTile(
                                          leading: const Icon(Icons.camera_alt_outlined),
                                          title: const Text('ຖ່າຍຮູບ'),
                                          onTap: () async {
                                            Navigator.of(context).pop();
                                            XFile? file = await ImagePicker().pickImage(
                                                source: ImageSource.camera, maxWidth: 1024, imageQuality: 80);
                                            if (file != null) {
                                              providerService.setProFileForUpload(File(file.path));

                                              String? path = '';

                                              if (providerService.imageProFile?.path != null) {
                                                path = providerService.imageProFile?.path;
                                              }

                                              if (path == '' || path!.isEmpty) {
                                                return;
                                              }

                                              final res = await providerService.updateProfiles(path);

                                              if (res) {
                                                if (!mounted) return;
                                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                  backgroundColor: primary,
                                                  content: Text("ແກ້ໄຂຮູບສຳເລັດ"),
                                                  duration: Duration(seconds: 2),
                                                ));
                                                providerService.setProFileForUpload(null);

                                                // Navigator.of(context).pop(true);
                                              } else {
                                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                  backgroundColor: red,
                                                  content: Text("ແກ້ໄຂຮູບບໍສຳເລັດ"),
                                                  duration: Duration(seconds: 2),
                                                ));
                                                providerService.setProFileForUpload(null);
                                              }
                                            }
                                          },
                                        ),
                                        ListTile(
                                          leading: const Icon(Icons.photo_camera_back_outlined),
                                          title: const Text('ເລືອກຮູບຈາກເຄື່ອງ'),
                                          onTap: () async {
                                            Navigator.of(context).pop();
                                            XFile? file = await ImagePicker().pickImage(
                                                source: ImageSource.gallery, maxWidth: 1024, imageQuality: 80);
                                            if (file != null) {
                                              providerService.setProFileForUpload(File(file.path));

                                              String? path = '';

                                              if (providerService.imageProFile?.path != null) {
                                                path = providerService.imageProFile?.path;
                                              }

                                              if (path == '' || path!.isEmpty) {
                                                return;
                                              }

                                              final res = await providerService.updateProfiles(path);

                                              if (res) {
                                                if (!mounted) return;
                                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                  backgroundColor: primary,
                                                  content: Text("ແກ້ໄຂຮູບສຳເລັດ"),
                                                  duration: Duration(seconds: 2),
                                                ));
                                                providerService.setProFileForUpload(null);

                                                // Navigator.of(context).pop(true);
                                              } else {
                                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                  backgroundColor: red,
                                                  content: Text("ແກ້ໄຂຮູບບໍສຳເລັດ"),
                                                  duration: Duration(seconds: 2),
                                                ));
                                                providerService.setProFileForUpload(null);
                                              }
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            icon: const Icon(Icons.camera_alt),
                          ),
                        )),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),

          Container(
            padding: const EdgeInsets.only(left: 15, right: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: cardColor,
              boxShadow: [
                BoxShadow(
                  color: shadowColor.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, 1), // changes position of shadow
                ),
              ],
            ),
            child: Column(children: [
              SettingItem(
                title: providerService.langs == 'la' ? "ຂໍ້ມູນສ່ວນໂຕ" : "Profile",
                leadingIcon: CupertinoIcons.person,
                bgIconColor: Colors.black87,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfilePreview()));
                },
              ),
              SettingItem(
                title: providerService.langs == 'la' ? "ປ່ຽນພາສາ" : "Language",
                leadingIcon: Icons.g_translate_outlined,
                bgIconColor: Colors.black87,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const LanguagePage()));
                },
              ),
              SettingItem(
                title: providerService.langs == 'la' ? "ປ່ຽນລະຫັດຜ່ານ" : "ChangePassword",
                leadingIcon: Icons.vpn_key_outlined,
                bgIconColor: Colors.black87,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ResetPass()));

                  //  print("555");
                },
              ),
              SettingItem(
                title: providerService.langs == 'la' ? "ກົດລະບຽບຂອງບໍລິສັດ" : "ChangePassword",
                leadingIcon: Icons.picture_as_pdf,
                bgIconColor: Colors.black87,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const PDFViewer()));

                  //  print("555");
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 45),
                child: Divider(
                  height: 0,
                  color: Colors.grey.withOpacity(0.8),
                ),
              ),
            ]),
          ),
          // SizedBox(
          //   height: 20,
          // ),

          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.only(left: 15, right: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: cardColor,
              boxShadow: [
                BoxShadow(
                  color: shadowColor.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, 1), // changes position of shadow
                ),
              ],
            ),
            child: Column(children: [
              SettingItem(
                  title: providerService.langs == 'la' ? "ອອກຈາກລະບົບ" : "Logout",
                  leadingIcon: CupertinoIcons.power,
                  bgIconColor: red,
                  onTap: () {
                    _showSuccus();
                  }),
            ]),
          ),

          const SizedBox(
            height: 100,
          ),
          Center(
            child: Text(
              providerService.langs == 'la'
                  ? "ເວີຊັ່ນ :  ${providerService.versionApp}"
                  : "Version :  ${providerService.versionApp}",
              style: const TextStyle(fontSize: 13, color: Colors.grey),
            ),
          )
        ],
      ),
    );
  }

  Future<void> _showSuccus() async {
    final providerService = Provider.of<ProviderService>(context, listen: false);

    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Center(
            child: Text('ຢືນຢັນການອອກຈາກລະບົບ',
                style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold))),
        content: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Text("ທ່ານຕ້ອງການເພີ່ມ ອອກຈາກລະບົບ ບໍ?",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: primary, fontSize: 12, fontWeight: FontWeight.w300)),
            )
          ],
        ),
        actions: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SizedBox(
                  child: MyElevatedButtonSecondary(
                      height: 30,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      borderRadius: BorderRadius.circular(24),
                      child: const Text(
                        'ຍົກເລີກ',
                        style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                      )),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: MyElevatedButtonPrimary(
                    height: 30,
                    onPressed: () async {
                      final providerService = Provider.of<ProviderService>(context, listen: false);
                      await context.read<AuthService>().signOut();

                      setState(() {
                        providerService.pageSelected = 0;

                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => LoginPageNew()),
                          (route) => false,
                        );
                      });
                    },
                    borderRadius: BorderRadius.circular(24),
                    child: const Text(
                      'ຕົກລົງ',
                      style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                    )),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class ProfileTabButton extends StatelessWidget {
  final String text;
  final bool isActive;
  final VoidCallback onTap;

  const ProfileTabButton({
    Key? key,
    required this.text,
    this.isActive = false,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: isActive ? Colors.blue : Colors.grey.withOpacity(0.5),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
