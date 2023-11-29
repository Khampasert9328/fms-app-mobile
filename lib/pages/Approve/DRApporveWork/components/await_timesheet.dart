// ignore_for_file: curly_braces_in_flow_control_structures, iterable_contains_unrelated_type

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fms_mobile_app/pages/Approve/DRApporveWork/service/dr_approve_service.dart';
import 'package:fms_mobile_app/pages/ot/HR/provider/set_item_checkbox.dart';
import 'package:fms_mobile_app/services/provider_service.dart';
import 'package:fms_mobile_app/theme/color.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:provider/provider.dart';

class AwaitTimeSheets extends StatefulWidget {
  const AwaitTimeSheets({super.key});

  @override
  State<AwaitTimeSheets> createState() => _AwaitTimeSheetsState();
}

class _AwaitTimeSheetsState extends State<AwaitTimeSheets> {
  int? selectMonth;
  int? selectYears;
  bool click = false;
  bool selectAll = false;
  List<String> checkedate = [];
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<ProviderService>().getTimeSheetsMonthYearPro(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final providerSetIthem = Provider.of<SetItmem>(context, listen: false);
    return Consumer<ProviderService>(
      builder: ((context, value, child) {
        if (value.isloading == true) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (value.gettimesheetallmonthyear == null || value.gettimesheetallmonthyear!.data!.isEmpty) {
          return const Center(
            child: Text("ບໍ່ມີລາຍການ"),
          );
        }
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    showMonthPicker(
                      context: context,
                      initialDate: DateTime.now(),
                    ).then((selectedDate) {
                      if (selectedDate != null) {
                        setState(() {
                          selectMonth = selectedDate.month;
                          selectYears = selectedDate.year;
                          providerSetIthem.setSelectMonth(selectMonth!);
                          providerSetIthem.setSelectYear(selectYears!);
                          context.read<ProviderService>().getTimeSheetsMonthYearPro(context);
                        });
                      }
                    });
                  },
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(23.r)),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 15, left: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              "ເລືອກເດືອນ: ${providerSetIthem.selectMonth ?? '-'}-${providerSetIthem.selectYear ?? '-'}"),
                          const Icon(Icons.date_range),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Expanded(
                  child: Column(
                    children: [
                      click == false
                          ? GestureDetector(
                              onTap: () {
                                setState(() {
                                  click = true;
                                });
                              },
                              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                                Container(
                                  margin: const EdgeInsets.only(right: 15),
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
                                            selectAll = false;
                                          });
                                          checkedate.clear();
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
                                            style:
                                                TextStyle(fontSize: 16.sp, color: primary, fontWeight: FontWeight.bold),
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

                                            if (checkedate.isEmpty) {
                                              for (var i in value.gettimesheetallmonthyear!.data!) {
                                                checkedate.add(i.date.toString());
                                              }
                                            } else {
                                              checkedate.clear();
                                            }
                                            setState(() {
                                              selectAll = !selectAll;
                                            });
                                          })
                                    ],
                                  ),
                                ],
                              ),
                            ),
                      Expanded(
                        child: ListView.builder(
                            itemCount: value.gettimesheetallmonthyear!.data!.length,
                            itemBuilder: (context, index) {
                              final data = value.gettimesheetallmonthyear!.data![index];

                              bool isChecked = checkedate.contains(data.date);
                              for (var i in data.timesheetList!)
                                return GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    width: double.infinity,
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
                                    child: Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: 200.w,
                                                child: Text(
                                                  i.workcode!,
                                                  style: TextStyle(
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: primary,
                                                  ),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              Row(
                                                children: [
                                                  const Text(
                                                    "ປະເພດວຽກ",
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 20.w,
                                                  ),
                                                  Text(i.workType.toString()),
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
                                                    width: 20.w,
                                                  ),
                                                  Text(i.workcode.toString()),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  const Text(
                                                    "ເວລາເຮັດວຽກ",
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 20.w,
                                                  ),
                                                  Text("${i.workHour} ຊົ່ວໂມງ"),
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
                                                    width: 20.w,
                                                  ),
                                                  Text(data.statusName.toString()),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const Spacer(),
                                          if (click == true)
                                            Checkbox(
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(100.r),
                                              ),
                                              value: isChecked,
                                              onChanged: (val) {
                                                String formatDate = DateFormat('yyyy-mm-dd').format(i.date!);

                                                setState(() {
                                                  if (val!) {
                                                    checkedate.add(formatDate);
                                                  } else {
                                                    checkedate.remove(formatDate);
                                                  }
                                                });
                                              },
                                            )
                                          else
                                            const SizedBox()
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              return null;
                            }),
                      ),
                    ],
                  ),
                )
              ],
            ),
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
                          //HRApprovedService().hrapproved(context, checkedIds, '0', '');
                          DRApproveService().drApproveTimeSheets(
                            context,
                            checkedate,
                            value.gettimesheetallmonthyear!.data![0].timesheetList![0].employeeId.toString(),
                            0,
                            '',
                          );
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
                          //HRApprovedService().hrapproved(context, checkedIds, '1', '');
                          DRApproveService()
                              .drApproveTimeSheets(
                                context,
                                checkedate,
                                value.gettimesheetallmonthyear!.data![0].timesheetList![0].employeeId.toString(),
                                1,
                                '',
                              )
                              .then((value) {
                                context.read<ProviderService>().getTimeSheetsMonthYearPro(context);
                              });
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
      }),
    );
  }
}
