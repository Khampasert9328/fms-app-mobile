import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fms_mobile_app/pages/admin/admin_leave_page.dart';
import 'package:fms_mobile_app/pages/admin/admin_ot_page.dart';
import 'package:fms_mobile_app/pages/admin/admin_timesheet_page.dart';
import 'package:fms_mobile_app/pages/profile/profile_preview_id.dart';
import 'package:fms_mobile_app/services/provider_service.dart';
import 'package:fms_mobile_app/shared/mydata.dart';
import 'package:fms_mobile_app/theme/color.dart';
import 'package:fms_mobile_app/widgets/item_workteam.dart';

import 'package:provider/provider.dart';

class TeamWorkList extends StatefulWidget {
  const TeamWorkList({super.key});

  @override
  State<TeamWorkList> createState() => _TeamWorkListState();
}

class _TeamWorkListState extends State<TeamWorkList> {
  bool? _loding;
  int? leaveNoti;
  int? OTNoti;
  int? TimesheetNoti;

  @override
  void initState() {
    super.initState();
    checkingWorks();
  }

  _FuctionAdminLeavePage(BuildContext context) async {
    String refresh = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => const AdminLeavePage()));

    if (refresh == "true") {
      // setDataCalendarWorkRe();
      // setData();
            setState(() {
      _loding = true;
    });
      final providerService =
          Provider.of<ProviderService>(context, listen: false);
      await providerService.setAdminLeaveList();
      leaveNoti = providerService.adminLeavesPadding?.data?.length;

              setState(() {
      _loding = false;
    });
    }
  }

  _FuctionAdminTimesheetPage(BuildContext context) async {
    String refresh = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => const AdminTimesheetPage()));
      print(refresh);
    if (refresh == "true") {

      final providerService =
          Provider.of<ProviderService>(context, listen: false);
             setState(() {
      _loding = true;
    });

      await providerService.setAdminTimeSheetList();
      TimesheetNoti = providerService.adminTimeSheetPadding?.data?.length;
                   setState(() {
      _loding = false;
    });
    }
  }

  _FuctionAdminOTPage(BuildContext context) async {
    String refresh = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => const AdminOTPage()));

    if (refresh == "true") {
                 setState(() {
      _loding = true;
    });
      final providerService =
          Provider.of<ProviderService>(context, listen: false);
      await providerService.setListAdminOT();
      OTNoti = providerService.adminOtPadding?.data?.length;

                   setState(() {
      _loding = false;
    });
    }
  }

  Future checkingWorks() async {
    final providerService =
        Provider.of<ProviderService>(context, listen: false);

    setState(() {
      _loding = true;
    });

    await providerService.SetEmployeeIdDetail();
    await providerService.setAdminLeaveList();
    await providerService.setListAdminOT();
    await providerService.setAdminTimeSheetList();

    leaveNoti = providerService.adminLeavesPadding?.data?.length;
    OTNoti = providerService.adminOtPadding?.data?.length;
    TimesheetNoti = providerService.adminTimeSheetPadding?.data?.length;
    // final userDetailById = providerService.userDetailById;
    // await providerService.SetItemEmployeeId();
    setState(() {
      _loding = false;
    });
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
            Navigator.pop(context, ""
                // MYHomePage is another page for showcase
                // replace it with your page name
                );
          },
        ),
        title: new Text("ຂໍ້ມູນພະນັກງານ", style: const TextStyle(color: black)),
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
      body: _loding == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : getHeader(),
    );
  }

  getHeader() {
    final providerService = Provider.of<ProviderService>(context);

    final userDetailById = providerService.userDetailById!.data;

    // print(userDetailById!.profileImgNew);

    final profileImgNew = userDetailById!.profileImgNew;
    final fullname = userDetailById.fullname;
    final level = userDetailById.level;

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 0, left: 10, right: 10),
        child: Column(
          children: <Widget>[
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage('${profileImgNew}'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    '${fullname}',
                    style: TextStyle(
                      fontSize: 18,
                      color: primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // SizedBox(height: 2),
                  // Text(
                  //   '${MyData.division_name}',
                  //   style: TextStyle(
                  //     fontSize: 14,
                  //     color: Colors.grey,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                  SizedBox(height: 2),
                  Text(
                    '${level}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(
                    height: 30,
                  ),

                  ItemWorkTeam(
                    cout: "0",
                    title: providerService.langs == 'la' ? "ຂໍ້ມູນສ່ວນໂຕ" : "Personal Information",
                    leadingIcon: CupertinoIcons.person,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ProfilePreviewID()));
                    },
                  ),

                  MyData.levelID == 3
                      ? ItemWorkTeam(
                          cout: "${TimesheetNoti}",
                          title:  providerService.langs == 'la' ? "ອະນຸມັດ Timesheet": "Timesheet Approvals",
                          leadingIcon: Icons.calendar_month_sharp,
                          onTap: () {
                            _FuctionAdminTimesheetPage(context);
                          },
                        )
                      : SizedBox(),

                  MyData.levelID == 3
                      ? ItemWorkTeam(
                          cout: "${OTNoti}",
                          title: providerService.langs == 'la' ? "ອະນຸມັດ OT": "OT Approvals",
                          leadingIcon: CupertinoIcons.time,
                          onTap: () {
                            _FuctionAdminOTPage(context);
                          },
                        )
                      : SizedBox(),

                  MyData.levelID == 3
                      ? ItemWorkTeam(
                          cout: "${leaveNoti}",
                          title: providerService.langs == 'la' ? "ອະນຸມັດລາພັກ": "Leaves Approvals",
                          leadingIcon: CupertinoIcons.paperplane,
                          onTap: () {
                            _FuctionAdminLeavePage(context);
                          },
                        )
                      : SizedBox(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
