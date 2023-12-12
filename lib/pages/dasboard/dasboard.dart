import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fms_mobile_app/services/provider_service.dart';
import 'package:fms_mobile_app/theme/color.dart';
import 'package:fms_mobile_app/widgets/loading/loading_widget.dart';
import 'package:provider/provider.dart';

class DasBoard extends StatefulWidget {
  const DasBoard({super.key});

  @override
  State<DasBoard> createState() => _DasBoardState();
}

class _DasBoardState extends State<DasBoard> {
  @override
  void initState() {
    context.read<ProviderService>().getTimeSheetsPandingdays();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final providerService = Provider.of<ProviderService>(context, listen: false);

    return Container(
        height: 300.h,
        margin: const EdgeInsets.only(left: 10, right: 10),
        padding: const EdgeInsets.only(top: 20, bottom: 20),
        decoration: BoxDecoration(
            color: appBgColor,
            //color: providerService.mode== ThemeMode.light ? appBgColor : appBgColordark ,
            borderRadius: BorderRadius.circular(20),
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
        child: Column(
          children: [
             SingleChildScrollView(
              child: Text(
               providerService.langs == 'la' ? "ສຳລັບພະນັກງານບໍ່ປ້ອນ TimeSheets" : "For input staff",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: primary,
                ),
              ),
            ),
            Expanded(
              child: Consumer<ProviderService>(
                builder: ((context, value, child) {
                  if (value.isloading == true) {
                    return const LoadingWidget();
                  } else if (value.timeSheetPanding == null) {
                    return const Center(
                      child: Text("ບໍ່ມີລາຍການ"),
                    );
                  }
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Scrollbar(
                      interactive: true,
                      trackVisibility: true,
                      thickness: 20,
                      radius: Radius.circular(10.r),
                      child: SingleChildScrollView(
                        child: DataTable(
                          columns:  [
                            DataColumn(
                              label: Text(providerService.langs == 'la' ? "ລະດັບ" : "Lavel",),
                            ),
                            DataColumn(
                              label: Text(providerService.langs == 'la' ? "ຊື່" : "Name",),
                            ),
                            DataColumn(
                              label: Text(providerService.langs == 'la' ? "ຈຳນວນບໍ່ປ້ອນ TimeSheets" : "Number not input TimeSheets",),
                            )
                          ],
                          rows: List.generate(value.timeSheetPanding!.data!.length, (index) {
                            final data = value.timeSheetPanding!.data![index];
                            return DataRow(
                              cells: [
                                DataCell(
                                  SizedBox(
                                    width: 20.sp,
                                    child: Text(
                                      ('${index + 1}'),
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(100.r),
                                        child: CachedNetworkImage(
                                          height: 30,
                                          width: 30,
                                          imageUrl: data.profileImgNew!,
                                          progressIndicatorBuilder: (context, url, downloadProgress) =>
                                              CircularProgressIndicator(value: downloadProgress.progress),
                                          errorWidget: (context, url, error) => const Icon(Icons.error),
                                        ),
                                      ),
                                      SizedBox(width: 5.w),
                                      SizedBox(
                                        width: 150.sp,
                                        child: Text(
                                          data.fullname!,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    data.pendingDay.toString(),
                                  ),
                                )
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            )
          ],
        ));
  }
}
