import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fms_mobile_app/theme/color.dart';

class AwaitLeadLeft extends StatefulWidget {
  const AwaitLeadLeft({super.key});

  @override
  State<AwaitLeadLeft> createState() => _AwaitLeadLeftState();
}

class _AwaitLeadLeftState extends State<AwaitLeadLeft> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: ((context, index) {
          return GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Dialog(
                    shadowColor: appBarColor,
                    insetPadding: const EdgeInsets.only(top: 90, bottom: 90, right: 10, left: 10),
                    child: Stack(
                      alignment: Alignment.topRight,
                      clipBehavior: Clip.none,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10),
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
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: primary,
                                      radius: 35.r,
                                      child: CircleAvatar(
                                        radius: 33.r,
                                        backgroundColor: white,
                                        backgroundImage: const AssetImage('assets/images/bglogo.png'),
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Taithong SESAIKEO",
                                          style: TextStyle(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.bold,
                                            color: primary,
                                          ),
                                        ),
                                        const Text("Execultive"),
                                        const Text("Software Development Divition"),
                                      ],
                                    ),
                                   
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("1/4"),
                                  Row(
                                    children: [
                                      const Text("ເລືອກທັງໝົດ"),
                                      Checkbox(
                                        value: false,
                                        onChanged: (value) => {},
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: 5,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
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
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  const Text(
                                                    "ວັນທີ",
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 15.w,
                                                  ),
                                                  const Text(
                                                    "24 ຕຸລາ 2023",
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
                                                  const Text(
                                                    "Application Development",
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
                                                    "UX/UI",
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 30.h,
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
                                                  const Text(
                                                    "24-10-2023(17:00-20:00)",
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
                                                  const Text(
                                                    "03:00",
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
                                                  const Text(
                                                    "OT1",
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  const Text(
                                                    "ປະເພດໜ້າວຽກ",
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 15.w,
                                                  ),
                                                  const Text(
                                                    "Billable Hour",
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
                                                  const Text(
                                                    "ໄດ້ມີການອອກແບບໜ້າຢືນຢັນຂໍ້ມູນການຂໍໂອທີ, \nຂໍລາພັກ ແລະ ກວດສອບ TimeSheet ໃໝ່",
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
                                                  const Text(
                                                    "ລໍຖ້າອະນຸມັດ",
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
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
                                  Container(
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
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: (() {
                            Navigator.pop(context);
                          }),
                          child: Positioned(
                            
                            child: Container(
                              alignment: Alignment.center,
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: black,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: const Text("X",
                                  style: TextStyle(
                                    color: white,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CircleAvatar(
                    backgroundColor: primary,
                    radius: 35.r,
                    child: CircleAvatar(
                      radius: 33.r,
                      backgroundColor: white,
                      backgroundImage: const AssetImage('assets/images/bglogo.png'),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Taithong SESAIKEO",
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: primary,
                        ),
                      ),
                      const Text("Execultive"),
                      const Text("Software Development Divition"),
                    ],
                  ),
                
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
