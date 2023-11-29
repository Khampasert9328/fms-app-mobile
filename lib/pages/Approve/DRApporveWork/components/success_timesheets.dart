// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fms_mobile_app/pages/ot/HR/provider/set_item_checkbox.dart';
import 'package:fms_mobile_app/services/provider_service.dart';
import 'package:fms_mobile_app/theme/color.dart';
import 'package:fms_mobile_app/widgets/loading/loading_widget.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:provider/provider.dart';

class SuccessTimeSheets extends StatefulWidget {
  const SuccessTimeSheets({super.key});

  @override
  State<SuccessTimeSheets> createState() => _SuccessTimeSheetsState();
}

class _SuccessTimeSheetsState extends State<SuccessTimeSheets> {
  @override
  void initState() {
    context.read<ProviderService>().getTimeSheetsSuccess(context);
    super.initState();
  }

  int? selectMonth;
  int? selectYears;

  @override
  Widget build(BuildContext context) {
    final providerSetIthem = Provider.of<SetItmem>(context, listen: false);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
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
                      providerSetIthem.setSelectMonthSuccess(selectMonth!);
                      providerSetIthem.setSelectYearSuccess(selectYears!);
                      context.read<ProviderService>().getTimeSheetsSuccess(context);
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
                          "ເລືອກເດືອນ: ${providerSetIthem.selectMonthSucees ?? '-'}-${providerSetIthem.selectYearSucees ?? '-'}"),
                      const Icon(Icons.date_range),
                    ],
                  ),
                ),
              ),
            ),
            Consumer<ProviderService>(
              builder: ((context, value, child) {
                if (value.isloading == true) {
                  return const LoadingWidget();
                } else if (value.drApproveSuccess == null || value.drApproveSuccess!.data!.isEmpty) {
                  return const Center(
                    child: Text("ບໍ່ມີລາຍການ"),
                  );
                }
                return Expanded(
                  child: ListView.builder(
                      itemCount: value.drApproveSuccess?.data?.length,
                      itemBuilder: ((context, index) {
                        final data = value.drApproveSuccess?.data![index];
                        for (var i in data!.timesheetList!)
                          return Container(
                            width: double.infinity,
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
                                          Text(
                                            data.statusName.toString(),
                                            style: const TextStyle(
                                              color: primary,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        return null;
                      })),
                );
              }),
            )
          ],
        ),
      ),
    );
    // }),
  }
}
