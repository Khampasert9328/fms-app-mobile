// ignore_for_file: avoid_unnecessary_containers, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fms_mobile_app/pages/ot/PM/service/pm_service.dart';
import 'package:fms_mobile_app/services/provider_service.dart';
import 'package:fms_mobile_app/theme/color.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DialogPM extends StatefulWidget {
  DialogPM({super.key});

  @override
  State<DialogPM> createState() => _DialogPMState();
}

class _DialogPMState extends State<DialogPM> {
  bool click = false;
  bool selectAll = false;
  List<String> checkedIds = [];
  @override
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<ProviderService>().getPMPro();
    });

    super.initState();
  }

  Widget build(BuildContext context) {
    return Dialog(
      shadowColor: appBarColor,
      insetPadding: const EdgeInsets.only(top: 110, bottom: 110, right: 10, left: 10),
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<ProviderService>(
            builder: (context, value, child) {
              if (value.pmModels == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10, left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("2/4"),
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
                                      borderRadius: BorderRadius.circular(23.r),
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
                                                // newmodelhr.selectAllCheckBox(value.hrApproved?.data ?? []);
                                                if (checkedIds.isEmpty) {
                                                  for (var i in value.pmModels!.data!) {
                                                    if (i.oStatusId == 1 ||
                                                        ((i.oStatusId == 2 || i.oStatusId == -1) &&
                                                            i.statusApproved! > 0)) {
                                                      checkedIds.add(i.eOvertimeId.toString());
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
                  SizedBox(
                    height: 5.h,
                  ),
                  Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: value.pmModels?.data?.length,
                        itemBuilder: (context, index) {
                          final data = value.pmModels?.data?[index];
                          bool isChecked = checkedIds.contains(data?.eOvertimeId.toString());
                          String dateTime = DateFormat.yMMMMd('lo').format(data!.date!);
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
                                                data.profileImgNew!,
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
                                                  data.fullname!,
                                                  style: TextStyle(
                                                    fontSize: 18.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: primary,
                                                  ),
                                                ),
                                                Text(dateTime),
                                                SizedBox(
                                                  width: 200.w,
                                                  child: Text(
                                                    data.projectName ?? '',
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    if (data.oStatusId == 3 ||
                                        ((data.oStatusId == 4 || data.oStatusId == -1) && data.statusApproved! > 0) &&
                                            click == true)
                                      Checkbox(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(100.r),
                                        ),
                                        value: isChecked,
                                        onChanged: (val) {
                                          setState(() {
                                            if (val!) {
                                              checkedIds.add(data.eOvertimeId.toString());
                                            } else {
                                              checkedIds.remove(data.eOvertimeId.toString());
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
                                          Container(
                                            child: const Text(
                                              "ວັນທີ",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 15.w,
                                          ),
                                          Container(
                                            child: Text(
                                              dateTime,
                                            ),
                                          ), // This will push the following widget to the end
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            "ໂຄງການ",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 15.w,
                                          ),
                                          SizedBox(
                                            width: 250.w,
                                            child: Text(
                                              data.projectName ?? '',
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            "ໜ້າວຽກ",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 15.w,
                                          ),
                                          const Text(
                                            "",
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            "ມື້ຂໍໂອທີ",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 15.w,
                                          ),
                                          Text(
                                            dateTime,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            "ເວລາກົດໂຕຈິງ",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 15.w,
                                          ),
                                          Text(
                                            data.startTime.toString(),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            "ປະເພດໂອທີ",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 15.w,
                                          ),
                                          Text(
                                            data.overtimeTypeName.toString(),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            "ໝາຍເຫດ",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 15.w,
                                          ),
                                          Text(
                                            "${data.detail}",
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
                                            data.oStatusName.toString(),
                                          ),
                                        ],
                                      )
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
                    padding: const EdgeInsets.only(bottom: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            PMService().pmapprove(context, checkedIds, '0', '');
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
                            PMService().pmapprove(context, checkedIds, '1', '');
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
    );
  }
}
