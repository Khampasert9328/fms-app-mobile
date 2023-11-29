// ignore_for_file: deprecated_member_use

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fms_mobile_app/services/provider_service.dart';
import 'package:fms_mobile_app/theme/color.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:timelines/timelines.dart';

class OTPageDetail extends StatefulWidget {
  const OTPageDetail({Key? key}) : super(key: key);

  @override
  _OTPageDetailState createState() => _OTPageDetailState();
}

class _OTPageDetailState extends State<OTPageDetail> {
  bool? _loding;
  double totalh = 0.0;
  Color completeColor = Colors.grey.shade500;
  Color inProgressColor = Color(0xff5ec792);
  Color todoColor = Color(0xffd1d2d7);

  DateTime? _fromDateStart;
  DateTime? _fromDateEnd;
  TextEditingController _remark = TextEditingController();

  String? TeamID;

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

 

  @override
  void initState() {
    setData();
    // WidgetsBinding.instance.addPostFrameCallback((_) {

    // });
    super.initState();
  }

   void setData() async {
    final providerService =
        Provider.of<ProviderService>(context, listen: false);
    setState(() {
      _loding = true;
    });

    _processIndex = providerService.OTProcessIndex!;

    print(providerService.OTProcessIndex!);
    await providerService.setOTByID();

    setState(() {
      _loding = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final providerService = Provider.of<ProviderService>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        // systemOverlayStyle: SystemUiOverlayStyle.dark,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: black,
          ),
          onPressed: () {
            Navigator.pop(
              context,
              // MYHomePage is another page for showcase
              // replace it with your page name
            );
          },
        ),
        title: Text(
         providerService.langs == 'la' ? "ປ້ອນຂໍ້ມູນ OT": "OT",
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
                            var color;
                            var child;
                            if (index == _processIndex) {
                              color = primary;
                              child = Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircularProgressIndicator(
                                  strokeWidth: 3.0,
                                  valueColor:
                                      AlwaysStoppedAnimation(Colors.white),
                                ),
                              );
                            } else if (index < _processIndex) {
                              color = primary;
                              child = Icon(
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
                                    size: Size(15.0, 15.0),
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
                    SizedBox(height: 20),
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

    final leavesById = providerService.leavesById?.data![0];
    final otId = providerService.otById?.data![0];
    print(otId?.detail);

    DateTime? startDate = otId?.startTime;
    DateTime? endDate = otId?.endTime;
    DateTime? Dates = otId?.date;
    DateTime? end;
    String? startCheckout;
    DateTime? start;
    String? startCheckin;
    if (otId?.checkinTime != null) {
      start = otId?.checkinTime;
      startCheckin = DateFormat('Hm').format(start!);
    } else {
      startCheckin = "-";
    }

    if (otId?.checkoutTime != null) {
      end = otId?.checkoutTime;
      startCheckout = DateFormat('Hm').format(end!);
    } else {
      startCheckout = "-";
    }
    String? TimeToUse;
    String? TimeToUse1;
    String? TotalHour;
    String? TotalMinute;

    if (otId?.checkoutTime != null && otId?.checkinTime != null) {
      TotalHour = otId?.hoursDiff.toString();
      TotalMinute = otId?.minutesDiff.toString();

      TimeToUse = "1";
      TimeToUse1 =       providerService.langs == 'la' ? "ລວມຊົ່ວໂມງເຮັດວຽກ: ${TotalHour}.${TotalMinute} ຊົ່ວໂມງ":   "Total : ${TotalHour}.${TotalMinute} h";
    } else {
      TimeToUse = "-";
    }
var format = providerService.langs == 'la' ?  DateFormat.yMMMMd('lo') :  DateFormat.yMMMMd('en');
    String datenow = format.format(Dates!);
    String dateRangeString =
        '${DateFormat('Hm').format(startDate!)} - ${DateFormat('Hm').format(endDate!)}';

    return Row(
      children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: 20,
          ),
          Text(
               providerService.langs == 'la' ? "ວັນທິ່": "Date",
            style: TextStyle(
              fontSize: 12.sp,
              color: black,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 10,
          ),

          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              "${datenow}",
              style: TextStyle(
                fontSize: 12.sp,
                color: black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
              providerService.langs == 'la' ?  "ເວລາຂໍ OT": "Time ",
            style: TextStyle(
              fontSize: 12.sp,
              color: black,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 10,
          ),

          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              "${dateRangeString}",
              style: TextStyle(
                fontSize: 12.sp,
                color: black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          SizedBox(
            height: 20,
          ),
          Text(
            providerService.langs == 'la' ?    "ສະຖານະ": "Stutas ",
            style: TextStyle(
              fontSize: 12.sp,
              color: black,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              otId?.isApproved == -1
                  ?    providerService.langs == 'la' ?    'ບໍ່ອະນຸມັດ': "Disapproved "
                  : otId?.isApproved == 1
                      ?  providerService.langs == 'la' ?    'ອະນຸມັດ': "Approved "
                      : otId?.isApproved == 0
                          ?providerService.langs == 'la' ?    "ລໍຖ້າອະນຸມັດ": "Pending " 
                          : '',
              style: TextStyle(
                  fontSize: 10.sp,
                  color: otId?.isApproved == -1
                      ? Color.fromRGBO(244, 67, 54, 1)
                      : otId?.isApproved == 1
                          ? Color.fromRGBO(76, 175, 79, 1)
                          : otId?.isApproved == 0
                              ? Color.fromRGBO(255, 153, 0, 1)
                              : primary),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(
          providerService.langs == 'la' ?     "ໂຄງການ": "Project " ,
            style: TextStyle(
              fontSize: 12.sp,
              color: black,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              "${otId?.projectName}",
              style: TextStyle(
                  fontSize: 12.sp, fontWeight: FontWeight.w300, color: black),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(
             providerService.langs == 'la' ?      "ໜ້າວຽກ": "Work Code " ,
            style: TextStyle(
              fontSize: 12.sp,
              color: black,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              "${otId?.workcode}",
              style: TextStyle(
                  fontSize: 12.sp, fontWeight: FontWeight.w300, color: black),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(
            "ເວລາກົດໂຕຈິງ",
            style: TextStyle(
              fontSize: 12.sp,
              color: black,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),

          TimeToUse != '-'
              ? Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: RichText(
                    text: TextSpan(
                      text:  providerService.langs == 'la' ?    'ເລີ່ມຕັ້ງແຕ່ເວລາ ' : " Start  " ,
                      style: TextStyle(color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(
                          text: '${startCheckin} ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: primary,
                          ),
                        ),
                        TextSpan(
                          text: providerService.langs == 'la' ?    'ໂມງ ຈົນເຖິງ ' : " to  " ,
                          style: TextStyle(color: Colors.black),
                        ),
                        TextSpan(
                          text: '${startCheckout} ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: primary,
                          ),
                        ),
                        TextSpan(
                          text: providerService.langs == 'la' ?    'ໂມງ ' : " " ,
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ))
              : Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    "-",
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

          TimeToUse != '-'
              ? Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: RichText(
                    text: TextSpan(
                      text: providerService.langs == 'la' ?    "ລວມຊົ່ວໂມງເຮັດວຽກ: " : " Total" ,
                      style: TextStyle(color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(
                          text: '${TotalHour}.${TotalMinute} ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: primary,
                          ),
                        ),
                        TextSpan(
                          text: providerService.langs == 'la' ?     'ຊົ່ວໂມງ ' : " " ,
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                )
              : SizedBox(),

          SizedBox(
            height: 20.0,
          ),

          Text(
            providerService.langs == 'la' ?     "ໝາຍເຫດ" : "Remark ",
            style: TextStyle(
              fontSize: 12.sp,
              color: black,
              fontWeight: FontWeight.w600,
            ),
          ),

          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              "${otId?.detail}",
              style: TextStyle(
                  fontSize: 12.sp, fontWeight: FontWeight.w300, color: black),
            ),
          ),

          SizedBox(
            height: 20.0,
          ),

          //     ],
          //   ),
          // )
        ]),
      ],
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

    var angle;
    var offset1;
    var offset2;

    var path;

    if (drawStart) {
      angle = 3 * pi / 4;
      offset1 = _offset(radius, angle);
      offset2 = _offset(radius, -angle);
      path = Path()
        ..moveTo(offset1.dx, offset1.dy)
        ..quadraticBezierTo(0.0, size.height / 2, -radius,
            radius) // TODO connector start & gradient
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
            radius) // TODO connector end & gradient
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
