// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fms_mobile_app/pages/ot/ot_new.dart';
import 'package:fms_mobile_app/pages/ot/ot_page_detail.dart';

import 'package:fms_mobile_app/services/provider_service.dart';

import 'package:fms_mobile_app/theme/color.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';

class OTPage extends StatefulWidget {
  const OTPage({Key? key}) : super(key: key);

  @override
  _OTPageState createState() => _OTPageState();
}

class _OTPageState extends State<OTPage> with SingleTickerProviderStateMixin {
  bool? _isLoading;
  bool? _loding;
  TabController? _tabController;
  String OTstd = "";

  _FuctionNewTap(BuildContext context) async {
    String refresh = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => const OTNew()));

    if (refresh == "true") {

      checkingWorksRe();
      OTstd = "true";
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
     await providerService.CheckingOt();
     await providerService.setListOT();

    print(providerService.stdCheckingOt?.data?.length);
    //setState(() => _isLoading = false);
    setState(() {
      _loding = false;
    });
    // }));
  }

  Future checkingWorksRe() async {
    final providerService =
        Provider.of<ProviderService>(context, listen: false);
    setState(() {
      _loding = true;
    });

    // await Future.delayed(Duration(seconds: 2), (() async {
    await providerService.CheckingOt();
    await providerService.setListOT();

    print(providerService.stdCheckingOt?.data?.length);
    //setState(() => _isLoading = false);
    setState(() {
      _loding = false;
    });
    // }));
  }

  @override
  Widget build(BuildContext context) {
      final providerService =
        Provider.of<ProviderService>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: black,
          ),
          onPressed: () {
            Navigator.pop(context, "${OTstd}"
                // MYHomePage is another page for showcase
                // replace it with your page name
                );
          },
        ),
        title:
            new Text(providerService.langs == 'la' ? "ປ້ອນຂໍ້ມູນຂໍ OT" : "OT", style: const TextStyle(color: black)),
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
        actions: <Widget>[
          TextButton(
            // style: style,
            onPressed: () {
              final providerService =
                  Provider.of<ProviderService>(context, listen: false);
              if (providerService.stdCheckingOt?.data?.length == 0) {
                _FuctionNewTap(context);
              } else {
                _showDialogUnsuccus(
                    "OT Can be requested once a day. Try again the next day!");
              }
            },
            child: const Icon(Icons.add),
          )
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: [
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
    String formattedDate = "";

    final providerService =
        Provider.of<ProviderService>(context, listen: false);
    //print(providerService.listOtPading?.data?.length);

    return providerService.listOtPading?.data?.length == 0
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
                  SizedBox(
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
                  itemCount: model.listOtPading?.data?.length,
                  itemBuilder: (context, index) {
                    final item = model.listOtPading?.data?[index];

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

                     
                        await providerService.SetOTId(item!.eOvertimeId, 1);
                          //  print(item.eOvertimeId);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const OTPageDetail()));
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
                              SizedBox(
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
                                      SizedBox(height: 5),
                                      Text(
                                        providerService.langs == 'la' ? 'ວັນທິ່ : ' : "Date :",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 10.sp, color: black),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                           providerService.langs == 'la' ?   'ເວລາ : ' : "Time :",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 10.sp, color: black),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                         providerService.langs == 'la' ?   'ສະຖານະ : ' : "Stutas :",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 10.sp, color: black),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        SizedBox(height: 5),
                                        Text(
                                          '${dateIn}',
                                          style: TextStyle(
                                              fontSize: 10.sp, color: black),
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          '${dateRangeString}',
                                          style: TextStyle(
                                              fontSize: 10.sp, color: black),
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                         providerService.langs == 'la' ? 'ລໍຖ້າອະນຸມັດ' : "Pending" ,
                                          style: TextStyle(
                                              fontSize: 10.sp,
                                              color: Color.fromRGBO(
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

    return providerService.listOtSuccess?.data?.length == 0
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
                  SizedBox(
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
                  itemCount: model.listOtSuccess?.data?.length,
                  itemBuilder: (context, index) {
                    final item = model.listOtSuccess?.data?[index];

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
                        await providerService.SetOTId(item!.eOvertimeId, 3);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const OTPageDetail()));
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
                              SizedBox(
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
                                      SizedBox(height: 5),
                                      Text(
                                       providerService.langs == 'la' ?  'ວັນທິ່ : ' : "Date :",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 10.sp, color: black),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        providerService.langs == 'la' ?   'ເວລາ : ' : "Time  :",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 10.sp, color: black),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                          providerService.langs == 'la' ?   'ສະຖານະ : ' : "Status  :",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 10.sp, color: black),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        SizedBox(height: 5),
                                        Text(
                                          '${dateIn}',
                                          style: TextStyle(
                                              fontSize: 10.sp, color: black),
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          '${dateRangeString}',
                                          style: TextStyle(
                                              fontSize: 10.sp, color: black),
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          item?.isApproved == -1
                                              ?    providerService.langs == 'la' ?  'ບໍ່ອະນຸມັດ' : "Disapproved   "
                                              : item?.isApproved == 1
                                                  ? providerService.langs == 'la' ?  'ອະນຸມັດ' : " Approved  "
                                                  : '',
                                          style: TextStyle(
                                              fontSize: 10.sp,
                                              color: item?.isApproved == -1
                                                  ? Color.fromRGBO(
                                                      244, 67, 54, 1)
                                                  : item?.isApproved == 1
                                                      ? Color.fromRGBO(
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

  Future<void> _showDialogUnsuccus(String? Msg) async {
    final providerService =
        Provider.of<ProviderService>(context, listen: false);

    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('ຂໍ້ຄວາມ'),
        content: Text("${Msg == '' ? 'ກະລຸນາຕື່ມຂໍ້ມູນໃຫ້ຄົບຖ້ວນ' : Msg}"),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
