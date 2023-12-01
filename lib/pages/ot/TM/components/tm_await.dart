import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fms_mobile_app/pages/ot/TM/components/dialog/await_dialog.dart';
import 'package:fms_mobile_app/pages/ot/TM/service/tm_service.dart';
import 'package:fms_mobile_app/services/provider_service.dart';
import 'package:fms_mobile_app/theme/color.dart';
import 'package:fms_mobile_app/widgets/loading/loading_widget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TMAwaitCompo extends StatefulWidget {
  const TMAwaitCompo({super.key});

  @override
  State<TMAwaitCompo> createState() => _TMAwaitCompoState();
}

class _TMAwaitCompoState extends State<TMAwaitCompo> {
  @override
  void initState() {
    context.read<ProviderService>().getLeaveFirendsPro();
    super.initState();
  }

  List<String> checkedIds = [];
  bool click = false;
  bool selectAll = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ProviderService>(
        builder: (context, value, child) {
          if (value.isloading == true) {
            return const LoadingWidget();
          } else if (value.leaveFriends == null || value.leaveFriends!.data!.isEmpty) {
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
                              height: 30.h,
                              width: 100.w,
                              decoration: BoxDecoration(
                                color: Colors.grey[800],
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Text(
                                "ເລືອກທັງໝົດ",
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
                                          for (var i in value.leaveFriends!.data!) {
                                            if (i.levelId != 3 ||
                                                (i.lStatusId == 1 ||
                                                        i.lStatusId == -1 ||
                                                        i.lStatusId == 2 ||
                                                        (i.approvedBy == null || i.statusApproved! > 0)) &&
                                                    click == true) {
                                              if (i.levelId == 3 ||
                                                  (i.lStatusId != 4 ||
                                                          (i.statusUser == 2 ||
                                                              i.statusApproved == 2 ||
                                                              i.lStatusId == 2)) &&
                                                      click == true) {
                                                checkedIds.add(i.eLeaveId.toString());
                                              }
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
                    itemCount: value.leaveFriends!.data!.length,
                    itemBuilder: (context, index) {
                      final data = value.leaveFriends!.data![index];
                      bool isChecked = checkedIds.contains(data.eLeaveId.toString());
                      String dateTime = DateFormat.yMMMMd('lo').format(data.endDate!);
                      return GestureDetector(
                        onTap: () {
                          showDialog(context: context, builder: (_) => DialogTMAwait());
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
                                      data.profileImgNew ?? "",
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
                                        data.fullname ?? "",
                                        style: TextStyle(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.bold,
                                          color: primary,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 197.w, // Set the width of the container to limit the available space
                                        child: Text(
                                          data.fullnameSubstitute!,
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
                                  if (data.levelId != 3 || (data.lStatusId == 1 || data.lStatusId == -1 || data.lStatusId == 2 || (data.approvedBy == null || data.statusApproved! > 0)) && click == true)
                                    if (data.levelId == 3 || (data.lStatusId != 4 ||(data.statusUser == 2 ||data.statusApproved == 2 ||data.lStatusId == 2)) && click == true)
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
        },
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
                      TMServicer().tmapproved(context, checkedIds, 0, '');
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
                      TMServicer().tmapproved(context, checkedIds, 1, '');
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
