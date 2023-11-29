// ignore_for_file: deprecated_member_use, library_private_types_in_public_api, prefer_final_fields, non_constant_identifier_names, use_build_context_synchronously, unused_local_variable

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:fms_mobile_app/services/provider_service.dart';
import 'package:fms_mobile_app/shared/mydata.dart';

import 'package:fms_mobile_app/theme/color.dart';
import 'package:fms_mobile_app/widgets/MyElevatedButton_Primary.dart';
import 'package:fms_mobile_app/widgets/MyElevatedButton_Secondary.dart';

import 'package:fms_mobile_app/widgets/custom_image.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:timelines/timelines.dart';

class AdminLeavePageDetail extends StatefulWidget {
  const AdminLeavePageDetail({Key? key}) : super(key: key);

  @override
  _AdminLeavePageDetailState createState() => _AdminLeavePageDetailState();
}

class _AdminLeavePageDetailState extends State<AdminLeavePageDetail> {
  bool? _loding;
  double totalh = 0.0;
  Color completeColor = Colors.grey.shade500;
  Color inProgressColor = const Color(0xff5ec792);
  Color todoColor = const Color(0xffd1d2d7);

  // DateTime? _fromDateStart;
  // DateTime? _fromDateEnd;
 TextEditingController _remark = TextEditingController();
  String stdblack = "1";
  int _processIndex = 0;
  Color getColor(int index) {
    if (index == _processIndex) {
      return primary;
    } else if (index < _processIndex) {
      return primary;
    } else {
      return todoColor;
    }
  }

  void setData() async {
    final providerService =
        Provider.of<ProviderService>(context, listen: false);

    setState(() {
      _loding = true;
    });

await providerService.setLeaveAdminByID();

    _processIndex = providerService.LeaveAdminIdProcessIndex!;

    

    setState(() {
      _loding = false;
    });
  }

  @override
  void initState() {
      setData();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
     final providerService =
        Provider.of<ProviderService>(context, listen: false);

    // final teamwork = providerService.teamwork;

    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        // systemOverlayStyle: SystemUiOverlayStyle.dark,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: black,
          ),
          onPressed: () {
            Navigator.pop(context, stdblack
                // MYHomePage is another page for showcase
                // replace it with your page name
                );
          },
        ),
        title: Text(
            providerService.langs == 'la' ? "ປ້ອນຂໍ້ມູນຂໍລາພັກ"  :  ' Leaves' ,
          style: TextStyle(
              fontSize: 16.sp,
              // fontWeight: FontWeight.bold,
              color: black),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              color: appBgColor,

              // borderRadius: BorderRadius.circular(13),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade200,
                  spreadRadius: 2,
                  blurRadius: 2,
                  offset: const Offset(0, 2),
                ),
                BoxShadow(
                  color: Colors.grey.shade200,
                  spreadRadius: 2,
                  blurRadius: 2,
                  offset: const Offset(0, -2),
                ),
                BoxShadow(
                  color: Colors.grey.shade200,
                  spreadRadius: 2,
                  blurRadius: 2,
                  offset: const Offset(-2, 0),
                ),
                BoxShadow(
                  color: Colors.grey.shade200,
                  spreadRadius: 2,
                  blurRadius: 2,
                  offset: const Offset(2, 0),
                ),
              ]),
        ),
      ),
      floatingActionButton:    MyData.levelID == 3
                      ?   Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyElevatedButtonSecondary(
                width: MediaQuery.of(context).size.width / 2 - 30,
                onPressed: () async {
                  _showUnSuccus();

                },
                borderRadius: BorderRadius.circular(24),
                child:  Text(
                   providerService.langs == 'la' ?  'ບໍ່ອະນຸມັດ'  : 'Unpproval',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                )),
            const SizedBox(
              width: 20,
            ),
            MyElevatedButtonPrimary(
                width: MediaQuery.of(context).size.width / 2 - 30,
                onPressed: () async {
                  _showSuccus();
                },
                borderRadius: BorderRadius.circular(24),
                child:  Text(
                   providerService.langs == 'la' ?'ອະນຸມັດ'  :  'Approval',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                )),
          ],
        ),
      ): const SizedBox(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: _loding == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(
                    left: 15, right: 15, top: 8, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 80,
                      padding: const EdgeInsets.only(),
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
                      child: Timeline.tileBuilder(
                        theme: TimelineThemeData(
                          direction: Axis.horizontal,
                          connectorTheme: const ConnectorThemeData(
                            space: 30.0,
                            thickness: 5.0,
                          ),
                        ),
                        builder: TimelineTileBuilder.connected(
                          connectionDirection: ConnectionDirection.before,
                          itemExtentBuilder: (_, __) =>
                              MediaQuery.of(context).size.width /
                              _processes.length,
                          contentsBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 2.0),
                              child: Text(
                                _processes[index],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: getColor(index),
                                ),
                              ),
                            );
                          },
                          indicatorBuilder: (_, index) {
                            Color color;
                            Widget? child;
                            if (index == _processIndex) {
                              color = primary;
                              child = const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: CircularProgressIndicator(
                                  strokeWidth: 3.0,
                                  valueColor:
                                      AlwaysStoppedAnimation(Colors.white),
                                ),
                              );
                            } else if (index < _processIndex) {
                              color = primary;
                              child = const Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 24.0,
                              );
                            } else {
                              color = todoColor;
                            }

                            if (index <= _processIndex) {
                              return Stack(
                                children: [
                                  CustomPaint(
                                    size: const Size(2.0, 2.0),
                                    painter: _BezierPainter(
                                      color: color,
                                      drawStart: index > 0,
                                      drawEnd: index < _processIndex,
                                    ),
                                  ),
                                  DotIndicator(
                                    size: 30.0,
                                    color: color,
                                    child: child,
                                  ),
                                ],
                              );
                            } else {
                              return Stack(
                                children: [
                                  CustomPaint(
                                    size: const Size(15.0, 15.0),
                                    painter: _BezierPainter(
                                      color: color,
                                      drawEnd: index < _processes.length - 1,
                                    ),
                                  ),
                                  OutlinedDotIndicator(
                                    borderWidth: 4.0,
                                    color: color,
                                  ),
                                ],
                              );
                            }
                          },
                          connectorBuilder: (_, index, type) {
                            if (index > 0) {
                              if (index == _processIndex) {
                                final prevColor = getColor(index - 1);
                                final color = getColor(index);
                                List<Color> gradientColors;
                                if (type == ConnectorType.start) {
                                  gradientColors = [
                                    Color.lerp(prevColor, color, 0.5)!,
                                    color
                                  ];
                                } else {
                                  gradientColors = [
                                    prevColor,
                                    Color.lerp(prevColor, color, 0.5)!
                                  ];
                                }
                                return DecoratedLineConnector(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: gradientColors,
                                    ),
                                  ),
                                );
                              } else {
                                return SolidLineConnector(
                                  color: getColor(index),
                                );
                              }
                            } else {
                              return null;
                            }
                          },
                          itemCount: _processes.length,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                        padding: const EdgeInsets.only(
                            left: 15, right: 15, top: 8, bottom: 10),
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
                        child: getDetail())
                  ],
                ),
              ),
            ),
    );
  }

  Widget getDetail() {
    final providerService =
        Provider.of<ProviderService>(context, listen: false);

    final leaveAdminById = providerService.leaveAdminById?.data![0];

    DateTime? startDate = leaveAdminById?.startDate;
    DateTime? endDate = leaveAdminById?.endDate;

    String dateRangeString =
        '${ providerService.langs == 'la' ?  DateFormat.yMMMMd('lo') :  DateFormat.yMMMMd('en').format(startDate!)} - ${providerService.langs == 'la' ?  DateFormat.yMMMMd('lo') :  DateFormat.yMMMMd('en').format(endDate!)}';

    return Row(
      children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            "ເວລາຂໍລາພັກ",
            style: TextStyle(
              fontSize: 12.sp,
              color: black,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 10,
          ),

          Text(
            dateRangeString,
            style: TextStyle(
              fontSize: 14.sp,
              color: primary,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(
            height: 20,
          ),
          Text(
            "ສະຖານະໃບລາພັກ",
            style: TextStyle(
              fontSize: 12.sp,
              color: black,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Text(
            leaveAdminById?.isApproved == -1
                ? 'ບໍ່ອະນຸມັດ'
                : leaveAdminById?.isApproved == 1
                    ? 'ອະນຸມັດ'
                    : leaveAdminById?.isApproved == 0
                        ? "ລໍຖ້າອະນຸມັດ"
                        : '',
            style: TextStyle(
                fontSize: 10.sp,
                color: leaveAdminById?.isApproved == -1
                    ? const Color.fromRGBO(244, 67, 54, 1)
                    : leaveAdminById?.isApproved == 1
                        ? const Color.fromRGBO(76, 175, 79, 1)
                        : leaveAdminById?.isApproved == 0
                            ? const Color.fromRGBO(255, 153, 0, 1)
                            : primary),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Text(
            "ຜູ້ປະຕິບັດວຽກແທນ",
            style: TextStyle(
              fontSize: 12.sp,
              color: black,
              fontWeight: FontWeight.w600,
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: CustomImage(
                      leaveAdminById?.profileImgSubstitute ?? '',
                      width: 60,
                      height: 57,
                      radius: 25,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    "${leaveAdminById?.employeeSubstitute}",
                    style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: primary),
                  ),
                  Text(
                    "${leaveAdminById?.level}",
                    style: TextStyle(fontSize: 10.sp),
                  ),
                  Text(
                    "${leaveAdminById?.departmentName}",
                    style: TextStyle(fontSize: 10.sp),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(
            height: 20.0,
          ),
          Text(
            "ເຫດຜົນຂໍລາພັກ",
            style: TextStyle(
              fontSize: 12.sp,
              color: black,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              "${leaveAdminById?.details}",
              style: TextStyle(
                  fontSize: 12.sp, fontWeight: FontWeight.w300, color: primary),
            ),
          ),

          const SizedBox(
            height: 20.0,
          ),

          //     ],
          //   ),
          // )
        ]),
      ],
    );
  }

  Future<void> _showUnSuccus() async {
    final providerService =
        Provider.of<ProviderService>(context, listen: false);

    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Center(
            child: Text('ຢືນຢັນການ UnApproval',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold))),
        content:  TextField(
                          keyboardType: TextInputType.multiline,
                          maxLines: 4,
                          controller: _remark,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15.0, horizontal: 20.0),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(
                                  color: const Color(0xff1C9A7F).withOpacity(0.50),
                                  width: 2.0,
                                ),
                              ),
                              fillColor: const Color(0xfff3f3f4),
                              filled: true,
                              hintText: "ເຫດຜົນທີ່ ບໍອະນຸມັດ"),
                        ),
        actions: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SizedBox(
                  child: MyElevatedButtonSecondary(
                      height: 30,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      borderRadius: BorderRadius.circular(24),
                      child: const Text(
                        'ຍົກເລີກ',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      )),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: MyElevatedButtonPrimary(
                    height: 30,
                    onPressed: () async {
                      _showDialogLoding();
                      final Approval = await providerService.ApprovalLeaves(
                        '-1',
                        '${providerService.LeaveAdminId}',
                        _remark.text,
                      );

                     

                      if (Approval == true) {
                        _showDialogLodingAction();
                        setState(() {
                          stdblack = "true";
                        });

                        await Future.delayed(const Duration(seconds: 1), (() async {
                          setState(() async {
                            await providerService.SetLeaveAdminId(
                                providerService.LeaveAdminId, 3);
                            Navigator.pop(context, "true");
                            Navigator.pop(context, "true");
                            Navigator.pop(context, "true");

                            setData();
                          });
                          // Navigator.pop(context, "true");
                        }));
                      } else {
                        _showDialogUnsuccus('');
                      }
                    },
                    borderRadius: BorderRadius.circular(24),
                    child: const Text(
                      'ຕົກລົງ',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    )),
              )
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _showSuccus() async {
    final providerService =
        Provider.of<ProviderService>(context, listen: false);

    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Center(
            child: Text('ຢືນຢັນການ Approval',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold))),
        content: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Text("ທ່ານຕ້ອງການ Approval ການລາພັກນີ້ບໍ?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: primary,
                      fontSize: 12,
                      fontWeight: FontWeight.w300)),
            )
          ],
        ),
        actions: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SizedBox(
                  child: MyElevatedButtonSecondary(
                      height: 30,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      borderRadius: BorderRadius.circular(24),
                      child: const Text(
                        'ຍົກເລີກ',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      )),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: MyElevatedButtonPrimary(
                    height: 30,
                    onPressed: () async {
                      _showDialogLoding();
                      final Approval = await providerService.ApprovalLeaves(
                        '1',
                        '${providerService.LeaveAdminId}',
                        '',
                      );

                   

                      if (Approval == true) {
                        _showDialogLodingAction();
                        setState(() {
                          stdblack = "true";
                        });

                        await Future.delayed(const Duration(seconds: 1), (() async {
                          setState(() async {
                            await providerService.SetLeaveAdminId(
                                providerService.LeaveAdminId, 3);
                            Navigator.pop(context, "true");
                            Navigator.pop(context, "true");
                            Navigator.pop(context, "true");

                            setData();
                          });
                          // Navigator.pop(context, "true");
                        }));
                      } else {
                        _showDialogUnsuccus('');
                      }
                    },
                    borderRadius: BorderRadius.circular(24),
                    child: const Text(
                      'ຕົກລົງ',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    )),
              )
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _showDialogUnsuccus(String? Msg) async {
    final providerService =
        Provider.of<ProviderService>(context, listen: false);

    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('ຂໍ້ຄວາມ'),
        content: Text("${Msg == '' ? 'ລອງໃໝ່ອີກຄັ້ງ' : Msg}"),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> _showDialogLoding() async {
    final providerService =
        Provider.of<ProviderService>(context, listen: false);

    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return WillPopScope(
              onWillPop: () async => true,
              child: const SimpleDialog(
                  backgroundColor: Colors.white,
                  children: <Widget>[
                    Center(
                      child: Column(children: [
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "ກຳລັງໂຫລດ......",
                          style: TextStyle(color: primary),
                        )
                      ]),
                    )
                  ]));
        });
  }

  Future<void> _showDialogLodingAction() async {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return const AlertDialog(
          contentPadding: EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 0.0),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'ສຳເລັດ',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 25.0),
              Icon(
                Icons.check_circle_outline,
                color: Colors.green,
                size: 70.0,
              ),
              SizedBox(height: 60.0),
            ],
          ),
        );
      },
    );
  }
}

class _BezierPainter extends CustomPainter {
  const _BezierPainter({
    required this.color,
    this.drawStart = true,
    this.drawEnd = true,
  });

  final Color color;
  final bool drawStart;
  final bool drawEnd;

  Offset _offset(double radius, double angle) {
    return Offset(
      radius * cos(angle) + radius,
      radius * sin(angle) + radius,
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = color;

    final radius = size.width / 2;

    double angle;
    Offset offset1;
    Offset offset2;

    Path path;

    if (drawStart) {
      angle = 3 * pi / 4;
      offset1 = _offset(radius, angle);
      offset2 = _offset(radius, -angle);
      path = Path()
        ..moveTo(offset1.dx, offset1.dy)
        ..quadraticBezierTo(0.0, size.height / 2, -radius,
            radius) 
        ..quadraticBezierTo(0.0, size.height / 2, offset2.dx, offset2.dy)
        ..close();

      canvas.drawPath(path, paint);
    }
    if (drawEnd) {
      angle = -pi / 4;
      offset1 = _offset(radius, angle);
      offset2 = _offset(radius, -angle);

      path = Path()
        ..moveTo(offset1.dx, offset1.dy)
        ..quadraticBezierTo(size.width, size.height / 2, size.width + radius,
            radius) 
        ..quadraticBezierTo(size.width, size.height / 2, offset2.dx, offset2.dy)
        ..close();

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(_BezierPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.drawStart != drawStart ||
        oldDelegate.drawEnd != drawEnd;
  }
}

final _processes = [
  'ປ້ອນຂໍ້ມູນ',
  'ລໍຖ້າກວດສອບ',
  'ສຳເລັດ',
];
