import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fms_mobile_app/pages/ot/HR/service/hr_approved.dart';
import 'package:fms_mobile_app/pages/ot/screen/dialog/dialog_hr.dart';
import 'package:fms_mobile_app/services/provider_service.dart';
import 'package:fms_mobile_app/theme/color.dart';
import 'package:fms_mobile_app/widgets/loading/loading_widget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HRScreenOT extends StatefulWidget {
  const HRScreenOT({super.key});

  @override
  State<HRScreenOT> createState() => _HRScreenOTState();
}

class _HRScreenOTState extends State<HRScreenOT> {
  @override
  void initState() {
    context.read<ProviderService>().getHRApprovedPro();
    super.initState();
  }

  bool click = false;
  int showindex = 0;
  bool checkbox = false;
  bool selectAll = false;

  List<String> checkedIds = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ProviderService>(
        builder: ((context, value, child) {
          if (value.isloading == true) {
            return const LoadingWidget();
          } else if (value.hrApproved == null || value.hrApproved!.data!.isEmpty) {
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
                      style: TextStyle(color: Colors.grey.shade400, fontSize: 20, fontWeight: FontWeight.w800),
                    ),
                  ),
                ],
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(15),
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
                                        // newmodelhr.selectAllCheckBox(value.hrApproved?.data ?? []);
                                        if (checkedIds.isEmpty) {
                                          for (var i in value.hrApproved!.data!) {
                                            if (i.oStatusId == 3 ||
                                                ((i.oStatusId == 4 || i.oStatusId == -1) && i.statusApproved! > 0)) {
                                              checkedIds.add(i.eOvertimeId.toString());
                                               print("object1");
                                            } else {
                                              print("object2");
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
                        itemCount: value.hrApproved!.data!.length,
                        itemBuilder: (context, index) {
                          final data = value.hrApproved!.data![index];
                          bool isChecked = checkedIds.contains(data.eOvertimeId.toString());
                          String dateTime = DateFormat.yMMMMd('lo').format(data.date!);
                          return GestureDetector(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (_) {
                                    return DialogHR(models: value.hrApproved!.data!);
                                  });
                            },
                            child: Container(
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
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(100.r),
                                      child: Image.network(
                                        data.profileImgNew!,
                                        height: 55,
                                        width: 55,
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
                                          data.fullname.toString(),
                                          style: TextStyle(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.bold,
                                            color: primary,
                                          ),
                                        ),
                                        
                                        SizedBox(
                                          width: 167.w, // Set the width of the container to limit the available space
                                          child: Text(
                                            data.workTypesName.toString(),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Text(dateTime),
                                        Text(
                                          data.oStatusName.toString(),
                                          style: const TextStyle(color: yellow),
                                        )
                                      ],
                                    ),
                                    const Spacer(),
                                    if (data.oStatusId == 3 ||
                                        ((data.oStatusId == 4 || data.oStatusId == -1) && data.statusApproved! > 0) &&
                                            click == true)
                                    click==false?SizedBox():  Checkbox(
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
                            ),
                          );
                        })),
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
                      HRApprovedService().hrapproved(context, checkedIds, '0', '');
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
                      HRApprovedService().hrapproved(context, checkedIds, '1', '');
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
