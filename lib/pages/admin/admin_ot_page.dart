// ignore_for_file: library_private_types_in_public_api, non_constant_identifier_names, prefer_is_empty, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fms_mobile_app/pages/admin/admin_ot_page_detail.dart';

import 'package:fms_mobile_app/services/provider_service.dart';

import 'package:fms_mobile_app/theme/color.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';

class AdminOTPage extends StatefulWidget {
  const AdminOTPage({Key? key}) : super(key: key);

  @override
  _AdminOTPageState createState() => _AdminOTPageState();
}

class _AdminOTPageState extends State<AdminOTPage>
    with SingleTickerProviderStateMixin {
  bool? _loding;
  TabController? _tabController;
  String OTstd = "";
  String? _lodingBlack;

  _FuctionNewTap(BuildContext context) async {
    String refresh = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => const AdminOTPageDetail()));

    if (refresh == "true") {
      setState(() {
        // print(_tabController?.index.toString());
        _tabController?.animateTo((1));
      });

      checkingWorks();

      setState(() {
        _lodingBlack = "true";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    checkingWorks();
  }

  Future checkingWorks() async {
    final providerService =
        Provider.of<ProviderService>(context, listen: false);
    setState(() {
      _loding = true;
    });

    // await Future.delayed(Duration(seconds: 2), (() async {

    await providerService.setListAdminOT();

    // print(providerService.stdCheckingOt?.data?.length);
    //setState(() => _isLoading = false);
    setState(() {
      _loding = false;
    });
    // }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: black,
          ),
          onPressed: () {
            Navigator.pop(context, "$_lodingBlack");
          },
        ),
        title:
             const Text("ປ້ອນຂໍ້ມູນຂໍ OT", style: TextStyle(color: black)),
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
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'ລໍຖ້າກວດສອບ'),
            Tab(text: 'ກວດສອບແລ້ວ'),
          ],
        ),
      ),
      body: _loding == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              // ignore: prefer_const_constructors
              child: TabBarView(
                controller: _tabController,
                children: [
                  // Content for Tab 1
                  Container(
                    child: getChecking(),
                  ),

                  Container(
                    child: getCheckingSuccess(),
                  ),
                ],
              ),
            ),
    );
  }

  Widget getChecking() {

    final providerService =
        Provider.of<ProviderService>(context, listen: false);

    return providerService.adminOtPadding?.data?.length == 0
        ? Center(
            // ignore: prefer_const_constructors
            child: SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/images/logo.svg",
                        width: 130,
                        color: Colors.green.shade200,
                      ),
                    ],
                  ),
                  Center(
                    child: Text(
                      "ບໍ່ມີລາຍການ",
                      style: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 20,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          )
        : SizedBox(
            height: MediaQuery.of(context).size.height - 250,
            child: Consumer<ProviderService>(
              builder: (context, model, child) {
                return ListView.builder(
                  itemCount: model.adminOtPadding?.data?.length,
                  itemBuilder: (context, index) {
                    final item = model.adminOtPadding?.data?[index];

                    DateTime? startDate = item?.startTime;
                    DateTime? endDate = item?.endTime;
                    DateTime? Dates = item?.date;

                    String dateRangeString =
                        '${DateFormat.Hm().format(startDate!)} - ${DateFormat.Hm().format(endDate!)}';
                    String dateIn =
                        '${providerService.langs == 'la' ?  DateFormat.yMMMMd('lo') :  DateFormat.yMMMMd('en').format(Dates!)} ';
                    //print(dateRangeString);

                    return GestureDetector(
                      onTap: () async {
                        await providerService.SetAdminOTId(
                            item!.eOvertimeId, 1);
                        
                        _FuctionNewTap(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: appBgColor,
                            borderRadius: BorderRadius.circular(13),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade200,
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset: const Offset(0, 0.1),
                              ),
                              BoxShadow(
                                color: Colors.grey.shade200,
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset: const Offset(0, -0.1),
                              ),
                              BoxShadow(
                                color: Colors.grey.shade200,
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset: const Offset(-0.1, 0),
                              ),
                              BoxShadow(
                                color: Colors.grey.shade200,
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset: const Offset(0.1, 0),
                              ),
                            ]),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${item?.projectName}",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 5),
                                      Text(
                                        'ວັນທິ່ : ',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 10.sp, color: black),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        'ເວລາ : ',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 10.sp, color: black),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        'ສະຖານະ : ',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 10.sp, color: black),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        const SizedBox(height: 5),
                                        Text(
                                          dateIn,
                                          style: TextStyle(
                                              fontSize: 10.sp, color: black),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          dateRangeString,
                                          style: TextStyle(
                                              fontSize: 10.sp, color: black),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          'ລໍຖ້າອະນຸມັດ',
                                          style: TextStyle(
                                              fontSize: 10.sp,
                                              color: const Color.fromRGBO(
                                                  255, 153, 0, 1)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 20.0,
                              ),
                            ]),
                      ),
                    );
                  },
                );
              },
            ));
  }

  Widget getCheckingSuccess() {
    final providerService =
        Provider.of<ProviderService>(context, listen: false);
    //print(providerService.listOtSuccess?.data?.length);

    return providerService.adminOtSuccess?.data?.length == 0
        ? Center(
            // ignore: prefer_const_constructors
            child: SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/images/logo.svg",
                        width: 130,
                        color: Colors.green.shade200,
                      ),
                    ],
                  ),
                  Center(
                    child: Text(
                      "ບໍ່ມີລາຍການ",
                      style: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 20,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          )
        : SizedBox(
            height: MediaQuery.of(context).size.height - 250,
            child: Consumer<ProviderService>(
              builder: (context, model, child) {
                return ListView.builder(
                  itemCount: model.adminOtSuccess?.data?.length,
                  itemBuilder: (context, index) {
                    final item = model.adminOtSuccess?.data?[index];

                    DateTime? startDate = item?.startTime;
                    DateTime? endDate = item?.endTime;
                    DateTime? Dates = item?.date;

                    String dateRangeString =
                        '${DateFormat.Hm().format(startDate!)} - ${DateFormat.Hm().format(endDate!)}';
                    String dateIn =
                        '${providerService.langs == 'la' ?  DateFormat.yMMMMd('lo') :  DateFormat.yMMMMd('en').format(Dates!)} ';

                    //print(dateRangeString);

                    return GestureDetector(
                      onTap: () async {
                        await providerService.SetAdminOTId(
                            item!.eOvertimeId, 3);
                        _FuctionNewTap(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: appBgColor,
                            borderRadius: BorderRadius.circular(13),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade200,
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset: const Offset(0, 0.1),
                              ),
                              BoxShadow(
                                color: Colors.grey.shade200,
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset: const Offset(0, -0.1),
                              ),
                              BoxShadow(
                                color: Colors.grey.shade200,
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset: const Offset(-0.1, 0),
                              ),
                              BoxShadow(
                                color: Colors.grey.shade200,
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset: const Offset(0.1, 0),
                              ),
                            ]),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${item?.projectName}",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 5),
                                      Text(
                                        'ວັນທິ່ : ',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 10.sp, color: black),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        'ເວລາ : ',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 10.sp, color: black),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        'ສະຖານະ : ',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 10.sp, color: black),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        const SizedBox(height: 5),
                                        Text(
                                          dateIn,
                                          style: TextStyle(
                                              fontSize: 10.sp, color: black),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          dateRangeString,
                                          style: TextStyle(
                                              fontSize: 10.sp, color: black),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          item?.isApproved == -1
                                              ? 'ບໍ່ອະນຸມັດ'
                                              : item?.isApproved == 1
                                                  ? 'ອະນຸມັດ'
                                                  : '',
                                          style: TextStyle(
                                              fontSize: 10.sp,
                                              color: item?.isApproved == -1
                                                  ? const Color.fromRGBO(
                                                      244, 67, 54, 1)
                                                  : item?.isApproved == 1
                                                      ? const Color.fromRGBO(
                                                          76, 175, 79, 1)
                                                      : primary),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 20.0,
                              ),
                            ]),
                      ),
                    );
                  },
                );
              },
            ));
  }

 
}
