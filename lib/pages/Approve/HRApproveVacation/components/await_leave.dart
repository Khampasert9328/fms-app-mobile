// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fms_mobile_app/pages/Approve/HRApproveVacation/components/dialog/dialog_hr_approve.dart';
import 'package:fms_mobile_app/pages/Approve/HRApproveVacation/service/hr_leave_request.dart';
import 'package:fms_mobile_app/services/provider_service.dart';
import 'package:fms_mobile_app/theme/color.dart';
import 'package:fms_mobile_app/widgets/loading/loading_widget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AwaitOT extends StatefulWidget {
  const AwaitOT({super.key});

  @override
  State<AwaitOT> createState() => _AwaitOTState();
}

class _AwaitOTState extends State<AwaitOT> {
  List<String> checkedIds = [];
  List<String> name = [];
  List<String> profile = [];
  List<int> statusID = [];
  List<int> statusApproved = [];

  bool click = false;
  bool selectAll = false;
  @override
  void initState() {
    initData();
    super.initState();
  }

  initData() async {
    context.read<ProviderService>().getHrLeaveReq();
   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ProviderService>(
        builder: ((context, value, child) {
          if (value.isloading == true) {
            return const LoadingWidget();
          } else if (value.hrLeaveRequest == null || value.hrLeaveRequest!.data!.isEmpty) {
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
                if (value.status == true)
                  click == false
                      ? GestureDetector(
                          onTap: () {
                            setState(() {
                              click = true;
                            });
                          },
                          child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                            Container(
                              alignment: Alignment.center,
                              height: 25.h,
                              width: 70.w,
                              decoration: BoxDecoration(
                                color: Colors.grey[800],
                                borderRadius: BorderRadius.circular(23.r),
                              ),
                              child: Text(
                                "Select",
                                style: TextStyle(fontSize: 14.sp, color: white),
                              ),
                            )
                          ]),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        click = false;
                                      });
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 30,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          border: Border.all(color: primary),
                                          borderRadius: BorderRadius.circular(100.r)),
                                      child: Text(
                                        "X",
                                        style: TextStyle(fontSize: 16.sp, color: primary, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  const Text("ເລືອກທັງໝົດ"),
                                  Checkbox(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(100.r),
                                      ),
                                      value: selectAll,
                                      onChanged: (val) {
                                        if (checkedIds.isEmpty) {
                                          for (var i in value.hrLeaveRequest!.data!) {
                                            if (i.lStatusId == 3 ||
                                                ((i.lStatusId == 4 || i.lStatusId == -1) && i.statusApproved! > 0)) {
                                              checkedIds.add(
                                                i.eLeaveId.toString(),
                                              );
                                            }
                                          }
                                        } else {
                                          checkedIds.clear();
                                        }
                                        setState(() {
                                          selectAll = !selectAll;
                                        });
                                      })
                                ],
                              ),
                            ],
                          ),
                        )
                else
                  const SizedBox(),
                Expanded(
                  child: ListView.builder(
                    itemCount: value.hrLeaveRequest!.data!.length,
                    itemBuilder: (context, index) {
                      final data = value.hrLeaveRequest!.data![index];
                      bool isChecked = checkedIds.contains(data.eLeaveId.toString());
                      String dateTime = DateFormat.yMMMMd('lo').format(data.endDate!);
                      return GestureDetector(
                        onTap: () {
                          showDialog(context: context, builder: ((context) => DialogHRApprove()));
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
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(100.r),
                                    child: Image.network(
                                      data.profile ?? "",
                                      height: 70,
                                      width: 70,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data.fullnameSubstitute!,
                                        style: TextStyle(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.bold,
                                          color: primary,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 197.w, // Set the width of the container to limit the available space
                                        child: Text(
                                          data.fullnameApproved ?? "",
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Text(dateTime),
                                      Text(
                                        data.lStatusName!,
                                        style: const TextStyle(color: yellow),
                                      )
                                    ],
                                  ),
                                  const Spacer(),
                                  if (data.lStatusId == 3 ||
                                      ((data.lStatusId == 4 || data.lStatusId == -1) && data.statusApproved! > 0) &&
                                          click == true)
                                    click == false
                                        ? const SizedBox()
                                        : Checkbox(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(100.r),
                                            ),
                                            value: isChecked,
                                            onChanged: (val) {
                                              setState(() {
                                                if (val!) {
                                                  checkedIds.add(data.eLeaveId.toString());
                                                } else {
                                                  checkedIds.remove(data.eLeaveId.toString());
                                                }
                                              });
                                            },
                                          )
                                  else
                                    const SizedBox()
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
      bottomNavigationBar: click == false
          ? const SizedBox()
          : Container(
              height: 60.h,
              color: white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      HRLeaveRequestService().hrapprovedleave(context, checkedIds, 0, '');
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 30.h,
                      width: 120.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(23.r),
                        color: red,
                      ),
                      child: const Text(
                        "Unapprovede",
                        style: TextStyle(color: white),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (() {
                      HRLeaveRequestService().hrapprovedleave(context, checkedIds, 1, '');
                    }),
                    child: Container(
                      alignment: Alignment.center,
                      height: 30.h,
                      width: 120.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(23.r),
                        color: primary,
                      ),
                      child: const Text(
                        "Approvede",
                        style: TextStyle(
                          color: white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
