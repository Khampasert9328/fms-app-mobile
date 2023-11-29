// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fms_mobile_app/pages/calendar/provider/time_sheet_provider.dart';
import 'package:fms_mobile_app/pages/calendar/provider/workandprojectviewmodels.dart';
import 'package:fms_mobile_app/services/api_service.dart';
import 'package:fms_mobile_app/theme/color.dart';
import 'package:fms_mobile_app/widgets/dropdown/drop_down_widget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddTimeSheet extends StatefulWidget {
  final DateTime dateTime;

  const AddTimeSheet({Key? key, required this.dateTime}) : super(key: key);

  @override
  State<AddTimeSheet> createState() => _AddTimeSheetState();
}

class _AddTimeSheetState extends State<AddTimeSheet> {
  final DateFormat _format = DateFormat('yyyy-MM-dd');
  final DateFormat _timeFormat = DateFormat('HH:mm');
  final TextEditingController _remark = TextEditingController();
  final TextEditingController hoursofwork = TextEditingController();
  DateTime? start;
  DateTime? stop;

  String _showDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    return "${twoDigits(duration.inHours)} ຊົ່ວໂມງ $twoDigitMinutes ນາທີ";
  }

  final TextEditingController _start = TextEditingController();
  final TextEditingController _stop = TextEditingController();
  final TextEditingController _sum = TextEditingController();
  String? token;

  @override
  void initState() {
    //print(_format.format(widget.dateTime));
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      token = await FirebaseAuth.instance.currentUser!.getIdToken();
      context.read<WorkAndProjectProvider>().initWorkAndProject();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        title: const Text('ເພີ່ມທຣາມສິດ'),
        centerTitle: true,
      ),
      body: Consumer2<TimeSheetProvider, WorkAndProjectProvider>(
        builder: (context, tProvider, wProvider, child) {
          String billable = '1';
          String absence = '2';
          final workType = wProvider.workTypeModel?.data;
          final workCode = wProvider.workCodeModel?.data;
          final project = wProvider.projectModel?.data;
          final hours = wProvider.hoursAttendance?.data;
          return GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: wProvider.loading == true
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("ປະເພດໜ້າວຽກ"),
                          DropDownWidgets(
                            validator: (val) {
                              return null;
                            },
                            hint: "ປະເພດໜ້າວຽກ",
                            item: workType?.map((value) {
                              return DropdownMenuItem<String>(
                                value: value.workTypeId.toString(),
                                child: Text(value.name ?? ""),
                              );
                            }).toList(),
                            onChange: (String? val) {
                              tProvider.workType = val;
                              tProvider.workCode = workCode
                                  ?.firstWhere((element) => element.workTypeId.toString() == val)
                                  .workcodeId
                                  .toString();
                            },
                            value: tProvider.workType,
                          ),
                          const SizedBox(height: 15),
                          tProvider.workType == billable
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("ໂປຣເຈັກ"),
                                    const SizedBox(height: 10),
                                    DropDownWidgets(
                                      validator: (val) {
                                        return null;
                                      },
                                      hint: 'ເລືອກໂປຣເຈັກ',
                                      item: project?.map((value) {
                                        return DropdownMenuItem<String>(
                                          value: value?.projectId.toString(),
                                          child: Text(value?.projectName ?? ""),
                                        );
                                      }).toList(),
                                      onChange: (String? val) {
                                        tProvider.project = val;
                                      },
                                      value: tProvider.project,
                                    ),
                                    const SizedBox(height: 15),
                                  ],
                                )
                              : const SizedBox(),
                          tProvider.workType != null
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(tProvider.workType == absence ? "Reason" : 'ລະຫັດໜ້າວຽກ'),
                                    DropDownWidgets(
                                      validator: (val) {
                                        return null;
                                      },
                                      hint: '',
                                      item: workCode
                                          ?.where((element) => element.workTypeId.toString() == tProvider.workType)
                                          .map((value) {
                                        return DropdownMenuItem<String>(
                                          value: value.workcodeId.toString(),
                                          child: Text(value.workcode ?? ""),
                                        );
                                      }).toList(),
                                      onChange: (String? val) {
                                        tProvider.workCode = val;
                                      },
                                      value: tProvider.workCode,
                                    ),
                                    const SizedBox(height: 15),
                                  ],
                                )
                              : const SizedBox(),
                          const Text('ຊົ່ວໂມງເຮັດວຽກ'),
                          const SizedBox(height: 5),
                          _textField(controller: hoursofwork, hint: hours.toString()),
                          const SizedBox(height: 15),
                          const Text('ໝາຍເຫດ'),
                          _textField(controller: _remark, hint: ''),
                          const SizedBox(height: 15),
                          Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(primary)),
                                    onPressed: () {
                                      APIService().AddTimeSheet(
                                          token!,
                                          DateTime.parse(_format.format(widget.dateTime)).toString(),
                                          tProvider.project.toString(),
                                          tProvider.workType.toString(),
                                          tProvider.workCode.toString(),
                                          hours.toString(),
                                          _remark.text,
                                          context);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                                      child: Text(
                                        'ບັນທຶກ',
                                        style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }

  Widget _textField({required String hint, required TextEditingController controller}) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              borderSide: BorderSide(color: Colors.red, width: 1))),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
    );
  }
}
