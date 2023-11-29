// ignore_for_file: avoid_unnecessary_containers, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fms_mobile_app/pages/Approve/HRApproveVacation/service/hr_leave_request.dart';
import 'package:fms_mobile_app/services/provider_service.dart';
import 'package:fms_mobile_app/theme/color.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DialogHRApprove extends StatefulWidget {
  DialogHRApprove({super.key});

  @override
  State<DialogHRApprove> createState() => _DialogHRApproveState();
}

class _DialogHRApproveState extends State<DialogHRApprove> {
  bool click = false;
  bool selectAll = false;
  List<String> checkedIds = [];

  @override
  void initState() {
    context.read<ProviderService>().getHrLeaveReq();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
        shadowColor: appBarColor,
        insetPadding: const EdgeInsets.only(top: 50, bottom: 50, right: 10, left: 10),
        child: Stack(
          children: [
            Positioned(
              width: 50,
              height: 50,
              top: 0,
              right: 0,

              // left: 0,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.cancel,
                  size: 40,
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Consumer<ProviderService>(
                  builder: (context, value, child) {
                    if (value.hrLeaveRequest == null || value.hrLeaveRequest!.data!.isEmpty) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    return Column(
                      children: [
                        SizedBox(
                          height: 30.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Center(child: Text("1/${value.hrLeaveRequest!.data?.length}")),
                            Padding(
                              padding: const EdgeInsets.only(right: 10, left: 10, top: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  if (value.status == true)
                                    click == false
                                        ? GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                click = true;
                                              });
                                            },
                                            child: Container(
                                              alignment: Alignment.center,
                                              height: 25.h,
                                              width: 70.w,
                                              decoration: BoxDecoration(
                                                color: Colors.grey[800],
                                                borderRadius: BorderRadius.circular(10.r),
                                              ),
                                              child: Text(
                                                "Select",
                                                style: TextStyle(
                                                  fontSize: 14.sp,
                                                  color: white,
                                                ),
                                              ),
                                            ),
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
                                                          style: TextStyle(
                                                              fontSize: 16.sp, color: primary, fontWeight: FontWeight.bold),
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
                                                                  ((i.lStatusId == 4 || i.lStatusId == -1) &&
                                                                      i.statusApproved! > 0)) {
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
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Expanded(
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: value.hrLeaveRequest!.data!.length,
                              itemBuilder: (context, index) {
                                final data = value.hrLeaveRequest!.data![index];
                                bool isChecked = checkedIds.contains(data.eLeaveId.toString());
                                String startDate = DateFormat.yMMMMd('lo').format(data.startDate!);
                                String endDate = DateFormat.yMMMMd('lo').format(data.endDate!);
                                return Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Stack(
                                        alignment: Alignment.topRight,
                                        children: [
                                          Container(
                                            height: 70.h,
                                            width: 320.w,
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
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
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
                                                        data.fullnameSubstitute ?? "",
                                                        style: TextStyle(
                                                          fontSize: 18.sp,
                                                          fontWeight: FontWeight.bold,
                                                          color: primary,
                                                        ),
                                                      ),
                                                      Text(data.fullnameApproved ?? ""),
                                                      // SizedBox(
                                                      //   width: 200.w,
                                                      //   child: Text(
                                                      //     data.,
                                                      //     overflow: TextOverflow.ellipsis,
                                                      //   ),
                                                      // ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          if (data.lStatusId == 3 ||
                                              ((data.lStatusId == 4 || data.lStatusId == -1) &&
                                                      data.statusApproved! > 0) &&
                                                  click == true)
                                            click == false
                                                ? SizedBox()
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
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Container(
                                      width: 320.w,
                                      decoration: BoxDecoration(
                                          color: appBarColor,
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
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 10, bottom: 10, right: 10, left: 10),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                const Text(
                                                  "ມື້ຂໍລາພັກ",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 15.w,
                                                ),
                                                SizedBox(
                                                  width: 200.w,
                                                  child: Text(
                                                    '${startDate} ຈົນເຖິງ ${endDate}',
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Text(
                                                  "ປະເພດລາພັກ",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 15.w,
                                                ),
                                                Text(
                                                  data.leaveTypeName ?? "",
                                                ),
                                              ],
                                            ),
                                            // SizedBox(
                                            //   height: 10.h,
                                            // ),
                                            Row(
                                              children: [
                                                const Text(
                                                  "ເຫດຜົນຂໍລາພັກ",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 15.w,
                                                ),
                                                Text(
                                                  data.remark ?? "ບໍ່ມີ",
                                                ),
                                              ],
                                            ),
                                            const Text(
                                              "ຜູ້ປະຕິບັດວຽກແທນ",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5.h,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  ClipRRect(
                                                    borderRadius: BorderRadius.circular(100.r),
                                                    child: Image.network(
                                                      data.profileApproved ?? "",
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
                                                        data.fullnameApproved ?? "ບໍ່ມີ",
                                                        style: TextStyle(
                                                          fontSize: 18.sp,
                                                          fontWeight: FontWeight.bold,
                                                          color: primary,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5.h,
                                            ),
                                            Row(
                                              children: [
                                                const Text(
                                                  "ຈຳນວນມື້ລາພັກປະຈຳປີຍັງເຫລືອ",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 15.w,
                                                ),
                                                Text(
                                                  "${data.annualLeave} ມື້",
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Text(
                                                  "ຈຳນວນມື້ລາກິດຍັງເຫລືອ",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 15.w,
                                                ),
                                                Text(
                                                  "${data.lakitLeave} ມື້",
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Text(
                                                  "ຈຳນວນມື້ລາປ່ວຍຍັງເຫລືອ",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 15.w,
                                                ),
                                                Text(
                                                  "${data.sickLeave} ມື້",
                                                ),
                                              ],
                                            ),

                                            Row(
                                              children: [
                                                const Text(
                                                  "ສະຖານະ",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 15.w,
                                                ),
                                                Text(
                                                  data.lStatusName!,
                                                  style: TextStyle(color: yellow),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15.h,
                                    ),
                                  ],
                                );
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 30),
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
                                onTap: () {
                                  HRLeaveRequestService().hrapprovedleave(context, checkedIds, 1, '');
                                },
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
                        )
                      ],
                    );
                  },
                )),
          ],
        ));
  }
}
