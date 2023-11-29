// ignore_for_file: avoid_unnecessary_containers, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fms_mobile_app/services/provider_service.dart';
import 'package:fms_mobile_app/theme/color.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DialogPMSuccess extends StatefulWidget {
  DialogPMSuccess({super.key});

  @override
  State<DialogPMSuccess> createState() => _DialogPMSuccessState();
}

class _DialogPMSuccessState extends State<DialogPMSuccess> {
 

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<ProviderService>().getPMSuccessPro();
    });

    super.initState();
  }

  Widget build(BuildContext context) {
    return Dialog(
      shadowColor: appBarColor,
      insetPadding: const EdgeInsets.only(top: 170, bottom: 150, right: 10, left: 10),
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<ProviderService>(
            builder: (context, value, child) {
              if (value.pmsuccess == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Padding(
                padding:  EdgeInsets.only(top: 10.h),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: value.pmsuccess?.data?.length,
                          itemBuilder: (context, index) {
                            final data = value.pmsuccess?.data?[index];
              
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
                              ],
                            );
                          }),
                    ),
                  
                    SizedBox(
                      height: 10.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 40.h,
                        width: 250.w,
                        decoration: BoxDecoration(color: red, borderRadius: BorderRadius.circular(23.r)),
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                            color: white,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          )),
    );
  }
}
