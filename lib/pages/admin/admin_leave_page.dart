// ignore_for_file: unused_field, prefer_is_empty, library_private_types_in_public_api, non_constant_identifier_names, unnecessary_new, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fms_mobile_app/pages/admin/admin_leave_page_detail.dart';
import 'package:fms_mobile_app/services/provider_service.dart';
import 'package:fms_mobile_app/theme/color.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AdminLeavePage extends StatefulWidget {
  const AdminLeavePage({Key? key}) : super(key: key);

  @override
  _AdminLeavePageState createState() => _AdminLeavePageState();
}

class _AdminLeavePageState extends State<AdminLeavePage> with SingleTickerProviderStateMixin {
  bool? _isLoading;
  bool? _loding;
  String _lodingBlack = "";
  TabController? _tabController;

  _FuctionNewTap(BuildContext context) async {
    String refresh =
        await Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminLeavePageDetail()));

    if (refresh == "true") {
      setState(() {
        _lodingBlack = "true";
        // print(_tabController?.index.toString());
        _tabController?.animateTo((1));
      });

      checkingWorks();
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    checkingWorks();
  }

  Future checkingWorks() async {
    final providerService = Provider.of<ProviderService>(context, listen: false);
    setState(() {
      _loding = true;
    });

    // await Future.delayed(Duration(seconds: 2), (() async {
    // await providerService.setList();
    await providerService.setAdminLeaveList();

    setState(() {
      _loding = false;
    });
    // }));
  }

  @override
  Widget build(BuildContext context) {
    final providerService = Provider.of<ProviderService>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: black,
          ),
          onPressed: () {
            Navigator.pop(context, _lodingBlack
                // MYHomePage is another page for showcase
                // replace it with your page name
                );
          },
        ),
        title:
            Text(providerService.langs == 'la' ? "ລາຍການຂໍລາພັກ" : 'List Leaves', style: const TextStyle(color: black)),
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
    final providerService = Provider.of<ProviderService>(context, listen: false);
    return providerService.adminLeavesPadding?.data?.length == 0
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
                      style: TextStyle(color: Colors.grey.shade400, fontSize: 20, fontWeight: FontWeight.w800),
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
                  itemCount: model.adminLeavesPadding?.data?.length,
                  itemBuilder: (context, index) {
                    final item = model.adminLeavesPadding?.data?[index];

                    DateTime? startDate = item?.startDate;
                    DateTime? endDate = item?.endDate;

                    String dateRangeString =
                        '${providerService.langs == 'la' ? DateFormat.yMMMMd('lo') : DateFormat.yMMMMd('en').format(startDate!)} - ${providerService.langs == 'la' ? DateFormat.yMMMMd('lo') : DateFormat.yMMMMd('en').format(endDate!)}';

                    //print(dateRangeString);

                    return GestureDetector(
                      onTap: () async {
                        await providerService.SetLeaveAdminId(item!.eLeaveId, 1);
                        _FuctionNewTap(context);

                        // print(item.eLeaveId);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        margin: const EdgeInsets.all(10),
                        decoration:
                            BoxDecoration(color: appBgColor, borderRadius: BorderRadius.circular(13), boxShadow: [
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
                        child: Row(
                          children: [
                            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              Text(
                                dateRangeString,
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
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 5),
                                      Text(
                                        'ສະຖານະໃບລາພັກ : ',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: 10.sp, color: black),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.4,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        const SizedBox(height: 5),
                                        Text(
                                          item?.isApproved == -1
                                              ? 'ບໍ່ອະນຸມັດ'
                                              : item?.isApproved == 1
                                                  ? 'ອະນຸມັດ'
                                                  : item?.isApproved == 0
                                                      ? "ລໍຖ້າອະນຸມັດ"
                                                      : '',
                                          style: TextStyle(
                                              fontSize: 10.sp,
                                              color: item?.isApproved == -1
                                                  ? const Color.fromRGBO(244, 67, 54, 1)
                                                  : item?.isApproved == 1
                                                      ? const Color.fromRGBO(76, 175, 79, 1)
                                                      : item?.isApproved == 0
                                                          ? const Color.fromRGBO(255, 153, 0, 1)
                                                          : primary),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              Text(
                                "ເຫດຜົນຂໍລາພັກ",
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: black,
                                  fontWeight: FontWeight.w200,
                                ),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  "${item?.details}",
                                  style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w300, color: primary),
                                ),
                              ),
                            ]),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ));
  }

  Widget getCheckingSuccess() {
    final providerService = Provider.of<ProviderService>(context, listen: false);
   
    return providerService.adminLeavesSuccess?.data?.length == 0
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
                      style: TextStyle(color: Colors.grey.shade400, fontSize: 20, fontWeight: FontWeight.w800),
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
                  itemCount: model.adminLeavesSuccess?.data?.length,
                  itemBuilder: (context, index) {
                    final item = model.adminLeavesSuccess?.data?[index];

                    DateTime? startDate = item?.startDate;
                    DateTime? endDate = item?.endDate;

                    String dateRangeString =
                        '${providerService.langs == 'la' ? DateFormat.yMMMMd('lo') : DateFormat.yMMMMd('en').format(startDate!)} - ${providerService.langs == 'la' ? DateFormat.yMMMMd('lo') : DateFormat.yMMMMd('en').format(endDate!)}';

                    //print(dateRangeString);

                    return GestureDetector(
                      onTap: () async {
                        await providerService.SetLeaveAdminId(item!.eLeaveId, 3);

                        _FuctionNewTap(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        margin: const EdgeInsets.all(10),
                        decoration:
                            BoxDecoration(color: appBgColor, borderRadius: BorderRadius.circular(13), boxShadow: [
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
                        child: Row(
                          children: [
                            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              Text(
                                dateRangeString,
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
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 5),
                                      Text(
                                        'ສະຖານະໃບລາພັກ : ',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: 10.sp, color: black),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.4,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        const SizedBox(height: 5),
                                        Text(
                                          item?.isApproved == -1
                                              ? providerService.langs == 'la'
                                                  ? 'ບໍ່ອະນຸມັດ'
                                                  : "Disapproved"
                                              : item?.isApproved == 1
                                                  ? providerService.langs == 'la'
                                                      ? " ອະນຸມັດ"
                                                      : "Approved"
                                                  : item?.isApproved == 0
                                                      ? providerService.langs == 'la'
                                                          ? " ລໍຖ້າອະນຸມັດ"
                                                          : "Pending"
                                                      : '',
                                          style: TextStyle(
                                              fontSize: 10.sp,
                                              color: item?.isApproved == -1
                                                  ? const Color.fromRGBO(244, 67, 54, 1)
                                                  : item?.isApproved == 1
                                                      ? const Color.fromRGBO(76, 175, 79, 1)
                                                      : item?.isApproved == 0
                                                          ? const Color.fromRGBO(255, 153, 0, 1)
                                                          : primary),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              Text(
                                "ເຫດຜົນຂໍລາພັກ",
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: black,
                                  fontWeight: FontWeight.w200,
                                ),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  "${item?.details}",
                                  style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w300, color: primary),
                                ),
                              ),
                            ]),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ));
  }
}
