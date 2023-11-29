import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fms_mobile_app/pages/Approve/DRApporveWork/screen/check/main_checking.dart';
import 'package:fms_mobile_app/pages/ot/HR/provider/set_item_checkbox.dart';
import 'package:fms_mobile_app/services/provider_service.dart';
import 'package:fms_mobile_app/theme/color.dart';
import 'package:fms_mobile_app/widgets/loading/loading_widget.dart';
import 'package:provider/provider.dart';

class DRMainApproved extends StatefulWidget {
  const DRMainApproved({super.key});

  @override
  State<DRMainApproved> createState() => _DRMainApprovedState();
}

class _DRMainApprovedState extends State<DRMainApproved> {
  @override
  void initState() {
    context.read<ProviderService>().getallformapprovetimesheetPro();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final setEmployee = Provider.of<SetItmem>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("ອະນຸມັດ TimeSheets"),
      ),
      body: Consumer<ProviderService>(
        builder: ((context, value, child) {
          if (value.isloading == true) {
            return const LoadingWidget();
          } else if (value.getallapprove == null || value.getallapprove!.data!.isEmpty) {
            return const Center(
              child: Text("ບໍ່ມີລາຍການ"),
            );
          }
          return ListView.builder(
            itemCount: value.getallapprove?.data?.length,
            itemBuilder: ((context, index) {
              final data = value.getallapprove?.data?[index];
              return GestureDetector(
                onTap: () {
                  setEmployee.setEmployeid(data.employeeId!);
                  Navigator.push(context, MaterialPageRoute(builder: (_) => MainChecking()));
                },
                child: Container(
                  width: double.infinity,
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
                      padding: const EdgeInsets.all(15),
                      child: Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(15),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100.r),
                                  child: Image.network(
                                    data!.profileImgNew!,
                                    height: 57,
                                    width: 57,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20.w,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 200.w,
                                    child: Text(
                                      data.fullname.toString(),
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold,
                                        color: primary,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 200.w, // Set the width of the container to limit the available space
                                    child: Text(
                                      data.divisionName ?? '',
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Text(
                                    data.departmentName!,
                                  )
                                ],
                              ),
                            ],
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(100.r), color: Colors.red),
                            child: Text(
                              data.timesheetApproveal.toString(),
                              style: TextStyle(color: white, fontSize: 13.sp),
                            ),
                          ),
                        ],
                      )),
                ),
              );
            }),
          );
        }),
      ),
    );
  }
}
