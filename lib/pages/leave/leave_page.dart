// ignore_for_file: use_build_context_synchronously, prefer_is_empty, unnecessary_string_interpolations, unused_local_variable, unused_field, non_constant_identifier_names, library_private_types_in_public_api, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fms_mobile_app/pages/leave/leave_new.dart';
import 'package:fms_mobile_app/pages/leave/leave_page_detail.dart';
import 'package:fms_mobile_app/pages/leave/screen/await_checking_leave.dart';
import 'package:fms_mobile_app/services/provider_service.dart';
import 'package:fms_mobile_app/theme/color.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class LeavePage extends StatefulWidget {
  const LeavePage({Key? key}) : super(key: key);

  @override
  _LeavePageState createState() => _LeavePageState();
}

class _LeavePageState extends State<LeavePage> with SingleTickerProviderStateMixin {
  bool? _isLoading;
  bool? _loding;
  TabController? _tabController;

  _FuctionNewTap(BuildContext context) async {
    String refresh = await Navigator.push(context, MaterialPageRoute(builder: (context) => const LeaveNew()));

    if (refresh == "true") {
      checkingWorks();
      // setData();
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
    await providerService.setList();

    //setState(() => _isLoading = false);
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
            Navigator.pop(context
                // MYHomePage is another page for showcase
                // replace it with your page name
                );
          },
        ),
        title:
             Text(providerService.langs == 'la' ? "ລາຍການຂໍລາພັກ" : "Leave ", style: const TextStyle(color: black)),
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
              _FuctionNewTap(context);
            },
            child: const Icon(Icons.add),
          )
        ],
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
                    child: const AwaitCheckingLeave(),
                  ),

                  Container(
                    child: getCheckingSuccess(),
                  ),
                ],
              ),
            ),
    );
  }

  // Widget getChecking() {
  //   String formattedDate = "";

    
  //   return providerService.leave?.data.leaves ==null
  //       ? 
  //       : 
  // }

  Widget getCheckingSuccess() {
    final providerService = Provider.of<ProviderService>(context, listen: false);
  

    return providerService.listSuccess?.data?.length == 0
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
                  itemCount: model.listSuccess?.data?.length,
                  itemBuilder: (context, index) {
                    final item = model.listSuccess?.data?[index];

                    DateTime? startDate = item?.startDate;
                    DateTime? endDate = item?.endDate;

                    String dateRangeString =
                        '${providerService.langs == 'la' ? DateFormat.yMMMMd('lo') : DateFormat.yMMMMd('en').format(startDate!)} - ${providerService.langs == 'la' ? DateFormat.yMMMMd('lo') : DateFormat.yMMMMd('en').format(endDate!)}';

                    //print(dateRangeString);

                    return GestureDetector(
                      onTap: () async {
                        await providerService.SetLeaveId(item!.eLeaveId, 3);

                        Navigator.push(context, MaterialPageRoute(builder: (context) => const LeavePageDetail()));
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
                                "$dateRangeString",
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
                                        providerService.langs == 'la' ? 'ສະຖານະໃບລາພັກ : ' : 'Stutas : ',
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
                                                  : 'Disapproved '
                                              : item?.isApproved == 1
                                                  ? providerService.langs == 'la'
                                                      ? 'ອະນຸມັດ'
                                                      : 'Approved '
                                                  : item?.isApproved == 0
                                                      ? providerService.langs == 'la'
                                                          ? "ລໍຖ້າອະນຸມັດ"
                                                          : 'Pending '
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
