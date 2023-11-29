import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fms_mobile_app/pages/ot/DR/service/dr_service.dart';
import 'package:fms_mobile_app/services/provider_service.dart';
import 'package:fms_mobile_app/theme/color.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DRAwait extends StatefulWidget {
  const DRAwait({super.key});

  @override
  State<DRAwait> createState() => _DRAwaitState();
}

class _DRAwaitState extends State<DRAwait> {
  @override
  void initState() {

      context.read<ProviderService>().getDRAwaitPro();
   
    super.initState();
  }

  bool click = false;
  bool selectAll = false;
  List<String> checkedIds = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ProviderService>(
        builder: ((context, value, child) {
          if (value.isloading == true) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (value.drAwaitModels == null || value.drAwaitModels!.data!.isEmpty) {
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
                                        borderRadius: BorderRadius.circular(100.r),
                                      ),
                                      child: Text(
                                        "X",
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          color: primary,
                                          fontWeight: FontWeight.bold,
                                        ),
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
                                          for (var i in value.drAwaitModels!.data!) {
                                            if (i.oStatusId == 2 ||
                                                ((i.oStatusId == 3 || i.oStatusId == -1) && i.statusApproved! > 0)) {
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
                Expanded(
                    child: ListView.builder(
                        itemCount: value.drAwaitModels!.data!.length,
                        itemBuilder: (context, index) {
                          final data = value.drAwaitModels!.data![index];
                          bool isChecked = checkedIds.contains(data.eOvertimeId.toString());
                          String dateTime = DateFormat.yMMMMd('lo').format(data.date!);
                          return GestureDetector(
                            onTap: () {
                              // showDialog(
                              //     context: context,
                              //     builder: (_) {
                              //       return DialogHR(models: value.hrApproved!.data!);
                              //     });
                            },
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10),
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
                                            data.fullname.toString(),
                                            style: TextStyle(
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.bold,
                                              color: primary,
                                            ),
                                          ),
                                          Text(dateTime),
                                          SizedBox(
                                            width: 197.w, // Set the width of the container to limit the available space
                                            child: Text(
                                              data.projectName ?? '',
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Text(
                                            data.oStatusName.toString(),
                                            style: const TextStyle(color: primary),
                                          )
                                        ],
                                      ),
                                      const Spacer(),
                                      if (data.oStatusId == 2 ||
                                          ((data.oStatusId == 3 || data.oStatusId == -1) && data.statusApproved! > 0) &&
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
                              ],
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
                      // HRApprovedService().hrapproved(context, checkedIds, '0', '');
                      DRService().drApproved(context, checkedIds, '0', '');
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
                      DRService().drApproved(context, checkedIds, '1', '');
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
