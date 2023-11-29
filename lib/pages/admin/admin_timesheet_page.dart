import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fms_mobile_app/pages/admin/admin_timesheet_list.dart';
import 'package:fms_mobile_app/services/provider_service.dart';
import 'package:fms_mobile_app/theme/color.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AdminTimesheetPage extends StatefulWidget {
  const AdminTimesheetPage({Key? key}) : super(key: key);

  @override
  _AdminTimesheetPageState createState() => _AdminTimesheetPageState();
}

class _AdminTimesheetPageState extends State<AdminTimesheetPage>
    with SingleTickerProviderStateMixin {
  bool? _isLoading;
  bool? _loding;

    String _lodingBlack = "";
  TabController? _tabController;
  final List<Map<String, dynamic>> notificationsPadding = [];

  _FuctionNewTap(BuildContext context) async {
    String refresh = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => const AdminTimeSheetList()));

    if (refresh == "true") {
      print(refresh);
      setState(() {
        _lodingBlack = "true" ;
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
    final providerService =
        Provider.of<ProviderService>(context, listen: false);
    setState(() {
      _loding = true;
    });

    await providerService.setAdminTimeSheetList();

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
          icon: Icon(
            Icons.arrow_back,
            color: black,
          ),
          onPressed: () {
            Navigator.pop(context,"${_lodingBlack}"
                // MYHomePage is another page for showcase
                // replace it with your page name
                );
          },
        ),
        title:
            new Text("ຂໍ້ມູນ Timesheet", style: const TextStyle(color: black)),
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
    return providerService.adminTimeSheetPadding?.data?.length == 0
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
                  itemCount: model.adminTimeSheetPadding?.data?.length,
                  itemBuilder: (context, index) {
                    final item = model.adminTimeSheetPadding?.data?[index];

                    DateTime? startDate = item?.date;
                    // DateTime? endDate = item?.endDate;
var format = providerService.langs == 'la' ?  DateFormat.yMMMMd('lo') :  DateFormat.yMMMMd('en');
                    String dateRangeString =
                        '${format.format(startDate!)}';

                    //print(dateRangeString);

                    return GestureDetector(
                      onTap: () async {
                        final providerService = Provider.of<ProviderService>(
                            context,
                            listen: false);

                        await providerService.SetAdminTimeSheetItem(DateTime(
                            startDate.year, startDate.month, startDate.day));

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
                        child: Row(
                          children: [
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${dateRangeString}",
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
                                            'ສະຖານະໃບລາພັກ : ',
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 10.sp, color: black),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            SizedBox(height: 5),
                                            Text(
                                              item?.status == 0
                                                  ? 'ບໍ່ອະນຸມັດ'
                                                  : item?.status == 1
                                                      ? 'ອະນຸມັດ'
                                                      : item?.status == -1
                                                          ? "ລໍຖ້າອະນຸມັດ"
                                                          : '',
                                              style: TextStyle(
                                                  fontSize: 10.sp,
                                                  color: item?.status == 0
                                                      ? Color.fromRGBO(
                                                          244, 67, 54, 1)
                                                      : item?.status == 1
                                                          ? Color.fromRGBO(
                                                              76, 175, 79, 1)
                                                          : item?.status == -1
                                                              ? Color.fromRGBO(
                                                                  255,
                                                                  153,
                                                                  0,
                                                                  1)
                                                              : primary),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
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
    final providerService =
        Provider.of<ProviderService>(context, listen: false);
    // print(providerService.adminTimeSheetApprovals?.data?.length);

    return providerService.adminTimeSheetApprovals?.data?.length == 0
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
                  itemCount: model.adminTimeSheetApprovals?.data?.length,
                  itemBuilder: (context, index) {
                    final item = model.adminTimeSheetApprovals?.data?[index];

                    DateTime? startDate = item?.date;
                    // DateTime? endDate = item?.endDate;
var format = providerService.langs == 'la' ?  DateFormat.yMMMMd('lo') :  DateFormat.yMMMMd('en');
                    String dateRangeString =
                        '${format.format(startDate!)}';

                    //print(dateRangeString);

                    return GestureDetector(
                      onTap: () async {
                        final providerService = Provider.of<ProviderService>(
                            context,
                            listen: false);

                        await providerService.SetAdminTimeSheetItem(DateTime(
                            startDate.year, startDate.month, startDate.day));

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
                        child: Row(
                          children: [
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${dateRangeString}",
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
                                            'ສະຖານະໃບລາພັກ : ',
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 10.sp, color: black),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            SizedBox(height: 5),
                                            Text(
                                              item?.status == 0
                                                  ? 'ບໍ່ອະນຸມັດ'
                                                  : item?.status == 1
                                                      ? 'ອະນຸມັດ'
                                                      : item?.status == -1
                                                          ? "ລໍຖ້າອະນຸມັດ"
                                                          : '',
                                              style: TextStyle(
                                                  fontSize: 10.sp,
                                                  color: item?.status == 0
                                                      ? Color.fromRGBO(
                                                          244, 67, 54, 1)
                                                      : item?.status == 1
                                                          ? Color.fromRGBO(
                                                              76, 175, 79, 1)
                                                          : item?.status == -1
                                                              ? Color.fromRGBO(
                                                                  255,
                                                                  153,
                                                                  0,
                                                                  1)
                                                              : primary),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
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
