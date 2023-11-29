import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fms_mobile_app/pages/ot/DR/component/dialog/dialog_list_data.dart';
import 'package:fms_mobile_app/services/provider_service.dart';
import 'package:fms_mobile_app/theme/color.dart';
import 'package:fms_mobile_app/widgets/loading/loading_widget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DRSuccess extends StatefulWidget {
  const DRSuccess({super.key});

  @override
  State<DRSuccess> createState() => _DRSuccessState();
}

class _DRSuccessState extends State<DRSuccess> {
  @override
  void initState() {
      context.read<ProviderService>().getDRSuccessPro();
   
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ProviderService>(
        builder: ((context, value, child) {
          if (value.isloading == true) {
            return const LoadingWidget();
          } else if (value.drSuccessModels == null || value.drSuccessModels!.data!.isEmpty) {
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
                Expanded(
                  child: ListView.builder(
                    itemCount: value.drSuccessModels!.data!.length,
                    itemBuilder: (context, index) {
                      final data = value.drSuccessModels!.data![index];

                      String dateTime = DateFormat.yMMMMd('lo').format(data.date!);
                      return GestureDetector(
                        onTap: () {
                          // showDialog(
                          //     context: context,
                          //     builder: (_) {
                          //       return const DRDialogSuccess();
                          //     });
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
        }),
      ),
    );
  }
}
