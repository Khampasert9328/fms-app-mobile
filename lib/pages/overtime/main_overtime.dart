// ignore_for_file: use_build_context_synchronously, curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:fms_mobile_app/pages/home/OT/ot_screen.dart';
import 'package:fms_mobile_app/pages/overtime/screen/ot_await.dart';
import 'package:fms_mobile_app/pages/overtime/screen/ot_success.dart';
import 'package:fms_mobile_app/services/provider_service.dart';
import 'package:fms_mobile_app/theme/color.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class MainOverTime extends StatefulWidget {
  const MainOverTime({super.key});

  @override
  State<MainOverTime> createState() => _MainOverTimeState();
}

class _MainOverTimeState extends State<MainOverTime> with SingleTickerProviderStateMixin {
  TabController? _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ຂໍ້ມູນໂອທີ"),
        bottom: TabBar(controller: _tabController, tabs: const [
          Tab(text: 'ລໍຖ້າກວດສອບ'),
          Tab(text: 'ກວດສອບແລ້ວ'),
        ]),
        actions: [
          IconButton(
            onPressed: () async {
              final providerService = Provider.of<ProviderService>(context, listen: false);
             // providerService.setCheckButtonOT(true);

              // if (providerService.checkbuttonot == true) {
                // providerService.setCheckButtonOT(false);

                // providerService.setBtStartLoading(true);
                // if (providerService.btnStartisLoading == true) {
                //   await providerService.setLocation();

                  if (Geolocator.checkPermission == LocationPermission.denied) {
                    providerService.setLocation();
                  } else {
                    await providerService.SetCheckFieldLocations(
                        "${providerService.userLocation?.latitude},${providerService.userLocation?.longitude}");
                    if (providerService.checkFieldLocations?.data.code == 1) {
                      final res = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => OverTimeOT(
                            latitude: '${providerService.userLocation?.latitude}',
                            longitude: '${providerService.userLocation?.longitude}',
                          ),
                        ),
                      );
                      if (res) {
                        if (!mounted)
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            backgroundColor: primary,
                            content: Text("ເລິ່ມເຮັດໂອທີສຳເລັດ"),
                            duration: Duration(seconds: 2),
                          ));

                        // providerService.setBtStartLoading(false);
                        // providerService.setCheckButtonOT(false);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          backgroundColor: red,
                          content: Text("ເຮັດໂອທີບໍ່ສຳເລັດ"),
                          duration: Duration(seconds: 2),
                        ));
                        // providerService.setFileForUpload(null);

                        // providerService.setBtStartLoading(false);
                        // providerService.setCheckButtonOT(false);
                      }
                    } 
                    // else {
                    //   providerService.setBtStartLoading(false);
                    //   providerService.setCheckButtonOT(true);
                    // }
                  }
                //}
              //}
            },
            icon: const Icon(
              Icons.add,
              color: primary,
            ),
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          AwaitMyOT(),
          SuccessMyOT(),
        ],
      ),
    );
  }
}
