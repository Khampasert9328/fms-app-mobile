import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fms_mobile_app/services/provider_service.dart';
import 'package:fms_mobile_app/theme/color.dart';
import 'package:fms_mobile_app/widgets/loading/loading_widget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HRCheckingSuccess extends StatefulWidget {
  const HRCheckingSuccess({super.key});

  @override
  State<HRCheckingSuccess> createState() => _HRCheckingSuccessState();
}

class _HRCheckingSuccessState extends State<HRCheckingSuccess> {
  @override
  void initState() {
      context.read<ProviderService>().getHRCheckSucces();

    super.initState();
  }

  Future<void> _refresh() async {
    await context.read<ProviderService>().getHRCheckSucces();
    // Add a delay using Future.delayed
    final Completer<void> completer = Completer<void>();
    Future<void>.delayed(const Duration(seconds: 2), () {
      completer.complete();
    });
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refresh,
      child: Consumer<ProviderService>(
        builder: ((context, value, child) {
          if (value.isloading) {
            return const LoadingWidget();
          } else if (value.hrCheckingsuccess == null || value.hrCheckingsuccess!.data!.isEmpty) {
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
          return ListView.builder(
            itemCount: value.hrCheckingsuccess?.data?.length,
            itemBuilder: ((context, index) {
              final data = value.hrCheckingsuccess?.data?[index];
              String dateTime = DateFormat.yMMMMd('lo').format(data!.date!);
              return Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: appBgColor, borderRadius: BorderRadius.circular(13), boxShadow: [
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
                        width: 20.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.fullname.toString(),
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: primary,
                            ),
                          ),
                          Text(
                            data.workTypesName ?? '',
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(dateTime),
                          SizedBox(height: 5.h),
                          Text(
                            data.oStatusName.toString(),
                            style: const TextStyle(color: primary),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
          );
        }),
      ),
    );
  }
}
