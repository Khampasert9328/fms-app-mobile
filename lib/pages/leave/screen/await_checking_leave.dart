// ignore_for_file: unnecessary_string_interpolations, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fms_mobile_app/pages/leave/leave_page_detail.dart';
import 'package:fms_mobile_app/services/provider_service.dart';
import 'package:fms_mobile_app/theme/color.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AwaitCheckingLeave extends StatefulWidget {
  const AwaitCheckingLeave({super.key});

  @override
  State<AwaitCheckingLeave> createState() => _AwaitCheckingLeaveState();
}

class _AwaitCheckingLeaveState extends State<AwaitCheckingLeave> {
  @override
  void initState() {
    context.read<ProviderService>().getLeavePro();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final providerService = Provider.of<ProviderService>(context, listen: false);
    return SizedBox(
        height: MediaQuery.of(context).size.height - 250,
        child: Consumer<ProviderService>(
          builder: (context, model, child) {
            return model.leave?.data.leaves == null
                ? Center(
                    // ignore: prefer_const_constructors
                    child: SizedBox(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                "assets/images/logo.svg",
                                width: 130,
                                color: Colors.green.shade200,
                              ),
                            ],
                          ),
                          Center(
                            child: Text(
                              "ບໍ່ມີລາຍການ",
                              style: TextStyle(color: Colors.grey.shade400, fontSize: 20, fontWeight: FontWeight.w800),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: model.leave?.data.leaves.length,
                    itemBuilder: (context, index) {
                      final item = model.leave?.data.leaves[index];

                      DateTime? startDate = item?.startDate;
                      DateTime? endDate = item?.endDate;

                      String dateStart =
                          '${providerService.langs == 'la' ? DateFormat.yMMMMd('lo').format(startDate!) : DateFormat.yMMMMd('en').format(startDate!)} ';
                      String dateEnd =
                          '${providerService.langs == 'la' ? DateFormat.yMMMMd('lo').format(endDate!) : DateFormat.yMMMMd('en').format(endDate!)}';
              

                      return GestureDetector(
                        onTap: () async {
                          await providerService.SetLeaveId(item!.eLeaveId, 1);

                          Navigator.push(context, MaterialPageRoute(builder: (context) => const LeavePageDetail()));
                      
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
                              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                Row(
                                  children: [
                                    Text(
                                      providerService.langs == 'la' ? 'ມື້ພັກ : ' : 'Start Date : ',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 10.sp, color: black),
                                    ),
                                    Text(
                                      "$dateStart ຈົເຖິງ $dateEnd",
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: primary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 5),
                                        Text(
                                          providerService.langs == 'la' ? 'ສະຖານະໃບລາພັກ : ' : 'Sturas : ',
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(fontSize: 10.sp, color: black),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.4,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          const SizedBox(height: 5),
                                          Text(
                                            item?.isApproved == -1
                                                ? providerService.langs == 'la'
                                                    ? 'ບໍ່ອະນຸມັດ'
                                                    : ' Disapproved '
                                                : item?.isApproved == 1
                                                    ? providerService.langs == 'la'
                                                        ? 'ອະນຸມັດ'
                                                        : ' Approved '
                                                    : item?.isApproved == 0
                                                        ? providerService.langs == 'la'
                                                            ? "ລໍຖ້າອະນຸມັດ"
                                                            : 'Pending'
                                                        : '',
                                            style: TextStyle(
                                                fontSize: 10.sp,
                                                color: item?.isApproved == -1
                                                    ? const Color.fromRGBO(244, 67, 54, 1)
                                                    : item?.isApproved == 1
                                                        ? const Color.fromRGBO(76, 175, 79, 1)
                                                        : item?.isApproved == 0
                                                            ? const Color.fromRGBO(255, 153, 0, 1)
                                                            : primary),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                Text(
                                  providerService.langs == 'la' ? "ເຫດຜົນຂໍລາພັກ" : 'ເຫດຜົນຂໍລາພັກ',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: black,
                                    fontWeight: FontWeight.w200,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    "${item?.details}",
                                    style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w300, color: primary),
                                  ),
                                ),
                              ]),
                            ],
                          ),
                        ),
                      );
                    },
                  );
          },
        ));
  }
}
