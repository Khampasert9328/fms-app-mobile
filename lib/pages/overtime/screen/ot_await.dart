import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fms_mobile_app/services/provider_service.dart';
import 'package:fms_mobile_app/theme/color.dart';
import 'package:fms_mobile_app/utils/formater.dart';
import 'package:fms_mobile_app/widgets/loading/loading_widget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AwaitMyOT extends StatefulWidget {
  const AwaitMyOT({super.key});

  @override
  State<AwaitMyOT> createState() => _AwaitMyOTState();
}

class _AwaitMyOTState extends State<AwaitMyOT> {
  @override
  void initState() {
    context.read<ProviderService>().getovertimawait();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ProviderService>(
        builder: ((context, value, child) {
          if (value.isloading == true) {
            return const LoadingWidget();
          } else if (value.overTime == null || value.overTime!.data!.overtimes!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/images/logo.svg',
                    color: Colors.green.shade200,
                  ),
                  Center(
                    child: Text(
                      "ບໍ່ມີລາຍການ",
                      style: TextStyle(
                        color: Colors.grey.shade400,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: value.overTime!.data!.overtimes?.length,
                    itemBuilder: (context, index) {
                      final data = value.overTime!.data!.overtimes?[index];

                      String dateTime = DateFormat.yMMMMd('lo').format(data!.date!);
                      String dateTimefor = Formatter().dateFormatStandardLaos(data.date);

                      return GestureDetector(
                        onTap: () {
                          // showDialog(context: context, builder: ((context) => DialogHRApprove()));
                          // showDialog(
                          //   context: context,
                          //   builder: ((context) => DialogWidget(
                          //         lenght: value.hrLeaveRequest!.data!.length,
                          //         name: name,
                          //         profile: profile,
                          //         statusId: statusID,
                          //         statusApproved: statusApproved,
                          //       )),
                          // );
                        },
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10),
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
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data?.projectName ?? "",
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                      color: primary,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "ວັນທີ",
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                          color: black,
                                        ),
                                      ),
                                       SizedBox(
                                        width: 15.w,
                                      ),
                                      Text(
                                        dateTimefor,
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "ໜ້າວຽກ",
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                          color: black,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 15.w,
                                      ),
                                      Text(
                                        data.workTypesName ?? "",
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "ເວລາກົດ OT",
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                          color: black,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 15.w,
                                      ),
                                      Text(
                                        '${data.startTime}-${data.endTime}',
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "ສະຖານະ",
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                          color: black,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 15.w,
                                      ),
                                      Text(
                                        data.oStatusName ?? "",
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          color: yellow,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
