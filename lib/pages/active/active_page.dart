

// ignore_for_file: unused_field, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:fms_mobile_app/services/provider_service.dart';

import 'package:fms_mobile_app/widgets/post_item.dart';
import 'package:fms_mobile_app/widgets/post_item_shimmer.dart';

import 'package:provider/provider.dart';

class ActivePage extends StatefulWidget {
  const ActivePage({Key? key}) : super(key: key);

  @override
  _ActivePageState createState() => _ActivePageState();
}

class _ActivePageState extends State<ActivePage> {
  bool? _isLoading;
  @override
  void initState() {
    super.initState();

    checkingWorks();
  }

  Future checkingWorks() async {
    final providerService =
        Provider.of<ProviderService>(context, listen: false);

    await Future.delayed(const Duration(seconds: 3), (() {
      providerService.setHistoryInDay();
      //setState(() => _isLoading = false);
      setState(() {
        providerService.loadding_activepage = false;
        providerService.loadding_activepagestd = 0;
      });
    }));
  }

  @override
  Widget build(BuildContext context) {
      final providerService =
        Provider.of<ProviderService>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        title:  Center(
            child:  Text(providerService.langs == 'la' ? "ພະນັກງານປະຈຳການ" : "Active",
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white))),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[Color(0xff039881), Color(0xff024C41)]),
          ),
        ),
      ),
      body: Center(
          // ignore: prefer_const_constructors
          child: getBody()),
    );
  }

  Widget getBody() {
    final providerService =
        Provider.of<ProviderService>(context, listen: false);
    final historyinday = providerService.historyinday;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          historyinday.isNotEmpty
              ? SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height - 170,
                  child: RefreshIndicator(
                    onRefresh: () async {
                      setState(() {
                        providerService.loadding_activepage = true;
                        providerService.loadding_activepagestd = 1;
                      });
                      await providerService.Refreshactive_page();
                      await Future.delayed(const Duration(seconds: 2));

                      setState(() {
                        providerService.loadding_activepage = false;
                        providerService.loadding_activepagestd = 0;
                      });
                    },
                    child: Consumer<ProviderService>(
                        builder: (context, model, child) {
                      return ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        primary: false,
                        itemCount: model.historyinday.length,
                        itemBuilder: (context, index) {
                          final item = model.historyinday[index];

                          if (providerService.loadding_activepage == true &&
                              providerService.loadding_activepagestd == 1) {
                            return PostItemShimmer();
                          } else {
                            //  print(MyData.token);
                            return PostItem(
                              postImg: item.attendanceImgurl.toString(),
                              profileImg: item.profileImgNew.toString(),
                              name: item.fullnameEn.toString(),
                              checkin: item.checkin.toString(),
                              checkout: item.checkout.toString(),
                            );
                          }

                          // return PostItemShimmer();
                        },
                      );
                    }),
                  ),
                )
              : const SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search_outlined,
                            color: Colors.grey,
                          ),
                          Text(
                        "ບໍ່ມີຄົນມາວຽກ",
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                      )
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
