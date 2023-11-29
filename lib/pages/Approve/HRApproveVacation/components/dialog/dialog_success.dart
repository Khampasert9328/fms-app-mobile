// ignore_for_file: avoid_unnecessary_containers, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fms_mobile_app/pages/Approve/HRApproveVacation/service/hr_leave_request.dart';
import 'package:fms_mobile_app/services/provider_service.dart';
import 'package:fms_mobile_app/theme/color.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DialogHRApproveSuccess extends StatefulWidget {
  DialogHRApproveSuccess({super.key});

  @override
  State<DialogHRApproveSuccess> createState() => _DialogHRApproveSuccessState();
}

class _DialogHRApproveSuccessState extends State<DialogHRApproveSuccess> {
  bool click = false;
  bool selectAll = false;
  List<String> checkedIds = [];

  @override
  void initState() {
    context.read<ProviderService>().getHrLeaveReqSuccess();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
        shadowColor: appBarColor,
        insetPadding: const EdgeInsets.only(top: 100, bottom: 120, right: 10, left: 10),
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
                child: const Icon(
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
                                   
                                  ],
                                );
                              }),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
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
                              "Cancel",
                              style: TextStyle(color: white),
                            ),
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.only(bottom: 30),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                        //     children: [
                        //       GestureDetector(
                        //         onTap: () {
                        //           HRLeaveRequestService().hrapprovedleave(context, checkedIds, 0, '');
                        //         },
                        //         child: Container(
                        //           alignment: Alignment.center,
                        //           height: 30.h,
                        //           width: 120.w,
                        //           decoration: BoxDecoration(
                        //             borderRadius: BorderRadius.circular(23.r),
                        //             color: red,
                        //           ),
                        //           child: const Text(
                        //             "Unapprovede",
                        //             style: TextStyle(color: white),
                        //           ),
                        //         ),
                        //       ),
                        //       GestureDetector(
                        //         onTap: () {
                        //           HRLeaveRequestService().hrapprovedleave(context, checkedIds, 1, '');
                        //         },
                        //         child: Container(
                        //           alignment: Alignment.center,
                        //           height: 30.h,
                        //           width: 120.w,
                        //           decoration: BoxDecoration(
                        //             borderRadius: BorderRadius.circular(23.r),
                        //             color: primary,
                        //           ),
                        //           child: const Text(
                        //             "Approvede",
                        //             style: TextStyle(
                        //               color: white,
                        //             ),
                        //           ),
                        //         ),
                        //       )
                        //     ],
                        //   ),
                        // )
                      ],
                    );
                  },
                )),
          ],
        ));
  }
}
