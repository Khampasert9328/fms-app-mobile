// ignore_for_file: use_build_context_synchronously, sized_box_for_whitespace, unnecessary_string_interpolations, unrelated_type_equality_checks, prefer_is_empty, unnecessary_brace_in_string_interps, library_private_types_in_public_api

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fms_mobile_app/pages/leave/leave_page_detail.dart';
import 'package:fms_mobile_app/pages/ot/ot_page_detail.dart';
import 'package:fms_mobile_app/pages/timesheets/timesheet_list.dart';

import 'package:fms_mobile_app/services/provider_service.dart';
import 'package:fms_mobile_app/shared/mydata.dart';
import 'package:fms_mobile_app/theme/color.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class NotiPage extends StatefulWidget {
  const NotiPage({Key? key}) : super(key: key);

  @override
  _NotiPageState createState() => _NotiPageState();
}

class _NotiPageState extends State<NotiPage> {
  final _userIdController = TextEditingController();

  List<Map<String, dynamic>> notificationsNew = [];
  List<String> groupKeys = [];
  late Map<String, List<Map<String, dynamic>>> notificationGroups;

  @override
  void initState() {
    super.initState();

    checkingWorks();
  }

  void checkingWorks() async {
    final providerService = Provider.of<ProviderService>(context, listen: false);
    setState(() {
      providerService.loadding_noti = true;
    });

    // await Future.delayed(Duration(seconds: 2), (() async {

    await providerService.setNotilist();

    final notilist = providerService.notificationLists!.data!;
    for (var i = 0; i < notilist.length; i++) {
      // var dateInFormatText = notilist[i].time?.toString().split("-");
      DateTime dateTime = notilist[i].time!;
      String? imageNoti;
      Color? textColors;

      if (notilist[i].notificationType == 13) {
        imageNoti = "assets/images/notification/outwork.png";
        textColors = red;
      } else if (notilist[i].notificationType == 12) {
        imageNoti = "assets/images/notification/inwork.png";
        textColors = primary;
      } else if (notilist[i].notificationType == 10) {
        imageNoti = "assets/images/notification/OtUnapprovals.png";
        textColors = red;
      } else if (notilist[i].notificationType == 9) {
        imageNoti = "assets/images/notification/OtApprovals.png";
        textColors = primary;
      } else if (notilist[i].notificationType == 6) {
        imageNoti = "assets/images/notification/leaveApprovals.png";
        textColors = primary;
      } else if (notilist[i].notificationType == 7) {
        imageNoti = "assets/images/notification/leaveUnapprovals.png";
        textColors = red;
      } else if (notilist[i].notificationType == 3) {
        imageNoti = "assets/images/notification/timesheetApprovals.png";
        textColors = primary;
      } else if (notilist[i].notificationType == 4) {
        imageNoti = "assets/images/notification/timesheetUnapprovals.png";
        textColors = red;
      } else {
        textColors = black;
        imageNoti = "-1";
      }

      notificationsNew.add({
        'notification_title': '${notilist[i].notificationTitle}',
        'notification_body': '${notilist[i].notificationBody}',
        'is_read': '${notilist[i].isRead}',
        'notification_type': notilist[i].notificationType,
        'url': '${notilist[i].url}',
        'colors': textColors,
        'image': '${imageNoti}',
        'time': DateTime(dateTime.year, dateTime.month, dateTime.day, dateTime.hour, dateTime.minute),
      });
    }

    notificationGroups = groupBy(notificationsNew, (Map oj) => oj['time'].toString().substring(0, 10));

    groupKeys = notificationGroups.keys.toList()..sort();
    groupKeys.sort((a, b) => b.compareTo(a));

    setState(() {
      providerService.loadding_noti = false;
    });

    providerService.UpdateNotiCout();
  }

  void checkingWorksRe() async {
    final providerService = Provider.of<ProviderService>(context, listen: false);
    if (MyData.noticout == 0) {
      setState(() {
        providerService.loadding_noti = true;
      });

      setState(() {
        notificationsNew.clear();
        groupKeys.clear();
        notificationGroups.clear();
      });

      await providerService.setNotilist();

      // await Future.delayed(Duration(seconds: 2), (() async {

      final notilist = providerService.notificationLists!.data!;
      for (var i = 0; i < notilist.length; i++) {
        DateTime dateTime = notilist[i].time!;
        String? imageNoti;
        Color? textColors;

        if (notilist[i].notificationType == 13) {
          imageNoti = "assets/images/notification/outwork.png";
          textColors = red;
        } else if (notilist[i].notificationType == 12) {
          imageNoti = "assets/images/notification/inwork.png";
          textColors = primary;
        } else if (notilist[i].notificationType == 10) {
          imageNoti = "assets/images/notification/OtUnapprovals.png";
          textColors = red;
        } else if (notilist[i].notificationType == 9) {
          imageNoti = "assets/images/notification/OtApprovals.png";
          textColors = primary;
        } else if (notilist[i].notificationType == 6) {
          imageNoti = "assets/images/notification/leaveApprovals.png";
          textColors = primary;
        } else if (notilist[i].notificationType == 7) {
          imageNoti = "assets/images/notification/leaveUnapprovals.png";
          textColors = red;
        } else if (notilist[i].notificationType == 3) {
          imageNoti = "assets/images/notification/timesheetApprovals.png";
          textColors = primary;
        } else if (notilist[i].notificationType == 4) {
          imageNoti = "assets/images/notification/timesheetUnapprovals.png";
          textColors = red;
        } else {
          textColors = black;
          imageNoti = "-1";
        }

        notificationsNew.add({
          'notification_title': '${notilist[i].notificationTitle}',
          'notification_body': '${notilist[i].notificationBody}',
          'is_read': '${notilist[i].isRead}',
          'notification_type': notilist[i].notificationType,
          'url': '${notilist[i].url}',
          'colors': textColors,
          'image': '${imageNoti}',
          'time': DateTime(dateTime.year, dateTime.month, dateTime.day, dateTime.hour, dateTime.minute),
        });
      }

      notificationGroups = groupBy(notificationsNew, (Map oj) => oj['time'].toString().substring(0, 10));

      groupKeys = notificationGroups.keys.toList()..sort();
      groupKeys.sort((a, b) => b.compareTo(a));

      setState(() {
        providerService.loadding_noti = false;
      });
    }
    providerService.UpdateNotiCout();
  }

  @override
  void dispose() {
    _userIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final providerService = Provider.of<ProviderService>(context, listen: false);

    return Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.light,
          title: Center(
              child: Text(providerService.langs == 'la' ? "ແຈ້ງເຕືອນ" : "Notification",
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
        body: providerService.loadding_noti == true
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : providerService.notificationLists?.data?.length == 0
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
                              "ບໍ່ມີແຈ້ງເຕື່ອນ",
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
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RefreshIndicator(
                      onRefresh: () async {
                        checkingWorksRe();
                      },
                      child: ListView.separated(
                        itemCount: groupKeys.length,
                        separatorBuilder: (context, index) => const Divider(),
                        itemBuilder: (context, index) {
                          final groupNotifications = notificationGroups[groupKeys[index]]!;
                          var format =
                              providerService.langs == 'la' ? DateFormat.yMMMMd('lo') : DateFormat.yMMMMd('en');
                          DateTime dateFull = DateTime.parse(groupKeys[index]);

                          final formattedDate = format.format(dateFull);

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(formattedDate,
                                        style: TextStyle(fontSize: 14.sp, color: black, fontWeight: FontWeight.w400))),
                              ),
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: groupNotifications.length,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  final notification = groupNotifications[index];
                                  return Container(
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: Colors.grey.shade200,
                                        ),
                                      ),
                                      gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: <Color>[
                                            notificationGroups['is_read'] == "1" ? Colors.grey.shade100 : Colors.white,
                                            notification['is_read'] == "1" ? Colors.grey.shade100 : Colors.white
                                          ]),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 4),
                                      child: ListTile(
                                        leading: notification['image'] != "-1"
                                            ? Image(
                                                image: AssetImage('${notification['image'].toString()}'),
                                              )
                                            : Image.network(
                                                "https://fms-api.archiineergroup.la/profile/306847972_639399167522569_3410737748581977086_n.jpeg"),
                                        title: Text(notification['notification_title'],
                                            style: TextStyle(fontSize: 12.sp, color: notification['colors'])),
                                        subtitle: Text(
                                          notification['notification_body'],
                                          style: TextStyle(fontSize: 10.sp, color: black),
                                        ),
                                        trailing: Text(
                                            '${notification['time'].hour >= 10 ? notification['time'].hour : "0${notification['time'].hour}"}:${notification['time'].minute >= 10 ? notification['time'].minute : "0${notification['time'].minute}"}',
                                            style: TextStyle(color: Colors.grey.shade500)),
                                        onTap: () async {
                                          if (notification['notification_type'] == 13) {
                                          } else if (notification['notification_type'] == 12) {
                                          } else if (notification['notification_type'] == 10) {
                                            await providerService.SetOTId(int.parse(notification['url']), 3);
                                            Navigator.push(
                                                context, MaterialPageRoute(builder: (context) => const OTPageDetail()));
                                          } else if (notification['notification_type'] == 9) {
                                            await providerService.SetOTId(int.parse(notification['url']), 3);
                                            Navigator.push(
                                                context, MaterialPageRoute(builder: (context) => const OTPageDetail()));
                                          } else if (notification['notification_type'] == 6) {
                                            await providerService.SetLeaveId(int.parse(notification['url']), 3);

                                            Navigator.push(context,
                                                MaterialPageRoute(builder: (context) => const LeavePageDetail()));
                                          } else if (notification['notification_type'] == 7) {
                                            await providerService.SetLeaveId(int.parse(notification['url']), 3);

                                            Navigator.push(context,
                                                MaterialPageRoute(builder: (context) => const LeavePageDetail()));
                                          } else if (notification['notification_type'] == 3) {
                                            var dateInFormatText = notification['url'].toString().split("-");

                                            int year = int.parse(dateInFormatText[0]);
                                            int mm = int.parse(dateInFormatText[1]);
                                            int day = int.parse(dateInFormatText[2]);

                                            await providerService.SetTimeSheetItem(DateTime(year, mm, day));

                                            Navigator.push(context,
                                                MaterialPageRoute(builder: (context) => const TimeSheetList()));
                                          } else if (notification['notification_type'] == 4) {
                                            var dateInFormatText = notification['url'].toString().split("-");

                                            int year = int.parse(dateInFormatText[0]);
                                            int mm = int.parse(dateInFormatText[1]);
                                            int day = int.parse(dateInFormatText[2]);

                                            await providerService.SetTimeSheetItem(DateTime(year, mm, day));

                                            Navigator.push(context,
                                                MaterialPageRoute(builder: (context) => const TimeSheetList()));
                                          } else {}
                                        },
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ));
  }

  notificationItem() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.grey.shade300, width: 1)),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(
                          "https://fms-api.archiineergroup.la/profile/306847972_639399167522569_3410737748581977086_n.jpeg")),
                ),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        overflow: TextOverflow.ellipsis,
                        'ການອະນຸມັດ',
                        style: TextStyle(fontSize: 14.sp, color: primary),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        overflow: TextOverflow.ellipsis,
                        'ຄຳຮ້ອງຂໍເຮັດວຽກລ່ວງເວລາໄດ້ຮັບການອະນຸມັດ',
                        style: TextStyle(fontSize: 10.sp, color: black),
                      ),
                      const SizedBox(height: 5),
                    ],
                  ),
                ),
                // Flexible(
                //   child: RichText(text: TextSpan(
                //     children: [
                //       TextSpan(text: "Header", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                //       TextSpan(text: "Title", style: TextStyle(color: Colors.black)),

                //     ]
                //   )),
                // )
              ],
            ),
          ),
          // notification.postImage != '' ?
          //   Container(
          //     width: 50,
          //     height: 50,
          //     child: ClipRRect(
          //       child: Image.network(notification.postImage)
          //     ),
          //   )
          // :
          Container(
              height: 35,
              width: 80,
              decoration: BoxDecoration(
                // color: Colors.blue[700],
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(child: Text('date', style: TextStyle(color: Colors.grey.shade500)))),
        ],
      ),
    );
  }
}
