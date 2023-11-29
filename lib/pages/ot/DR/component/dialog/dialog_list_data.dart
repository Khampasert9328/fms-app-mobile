// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:fms_mobile_app/services/provider_service.dart';
// import 'package:fms_mobile_app/theme/color.dart';
// import 'package:provider/provider.dart';

// class DialogWidget extends StatefulWidget {
//   final int? lenght;
//   final List<String>? name;
//   final List<String>? profile;
//   final List<int>? statusId;
//   final List<int>? statusApproved;

//   const DialogWidget({super.key, required this.lenght, required this.name, this.profile, this.statusId, this.statusApproved});

//   @override
//   State<DialogWidget> createState() => _DialogWidgetState();
// }

// class _DialogWidgetState extends State<DialogWidget> {
//   bool click = false;
//   bool selectAll = false;
//   List<String> checkedIds = [];
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<ProviderService>(
//       builder: ((context, value, child) {
//         return Dialog(
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//           shadowColor: appBarColor,
//           insetPadding: const EdgeInsets.only(top: 90, bottom: 90, right: 10, left: 10),
//           child: Padding(
//             padding: EdgeInsets.only(top: 10.h),
//             child: Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(right: 20),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       GestureDetector(
//                         onTap: () {
//                           Navigator.pop(context);
//                         },
//                         child: Container(
//                           alignment: Alignment.center,
//                           height: 30,
//                           width: 30,
//                           decoration: BoxDecoration(
//                             color: Colors.grey,
//                             borderRadius: BorderRadius.circular(100.r),
//                           ),
//                           child: const Text(
//                             "X",
//                             style: TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10.h,
//                 ),
//                 if (value.status == true)
//                   click == false
//                       ? GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               click = true;
//                             });
//                           },
//                           child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
//                             Padding(
//                               padding: const EdgeInsets.only(right: 20),
//                               child: Container(
//                                 alignment: Alignment.center,
//                                 height: 25.h,
//                                 width: 70.w,
//                                 decoration: BoxDecoration(
//                                   color: Colors.grey[800],
//                                   borderRadius: BorderRadius.circular(10.r),
//                                 ),
//                                 child: Text(
//                                   "Select",
//                                   style: TextStyle(fontSize: 14.sp, color: white),
//                                 ),
//                               ),
//                             )
//                           ]),
//                         )
//                       : Padding(
//                           padding: const EdgeInsets.only(right: 20),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               Row(
//                                 children: [
//                                   GestureDetector(
//                                     onTap: () {
//                                       setState(() {
//                                         click = false;
//                                       });
//                                     },
//                                     child: Container(
//                                       height: 30,
//                                       width: 30,
//                                       alignment: Alignment.center,
//                                       decoration: BoxDecoration(
//                                           border: Border.all(color: primary),
//                                           borderRadius: BorderRadius.circular(100.r)),
//                                       child: Text(
//                                         "X",
//                                         style: TextStyle(fontSize: 16.sp, color: primary, fontWeight: FontWeight.bold),
//                                       ),
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     width: 10.w,
//                                   ),
//                                   const Text("ເລືອກທັງໝົດ"),
//                                   Checkbox(
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(100.r),
//                                       ),
//                                       value: selectAll,
//                                       onChanged: (val) {
//                                         if (checkedIds.isEmpty) {
//                                           for (var i in value.hrLeaveRequest!.data!) {
//                                             if (i.lStatusId == 3 ||
//                                                 ((i.lStatusId == 4 || i.lStatusId == -1) && i.statusApproved! > 0)) {
//                                               checkedIds.add(
//                                                 i.eLeaveId.toString(),
//                                               );
//                                             }
//                                           }
//                                         } else {
//                                           checkedIds.clear();
//                                         }
//                                         setState(() {
//                                           selectAll = !selectAll;
//                                         });
//                                       })
//                                 ],
//                               ),
//                             ],
//                           ),
//                         )
//                 else
//                   const SizedBox(),
//                 Expanded(
//                   child: ListView.builder(
//                       scrollDirection: Axis.horizontal,
//                       itemCount: widget.lenght,
//                       itemBuilder: (context, index) {
//                         //String dateTime = DateFormat.yMMMMd('lo').format(data!.date!);
//                         return Column(
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Stack(
//                                 alignment: Alignment.topRight,
//                                 children: [
//                                   Container(
//                                     height: 70.h,
//                                     width: 320.w,
//                                     decoration: BoxDecoration(
//                                         color: appBgColor,
//                                         borderRadius: BorderRadius.circular(10),
//                                         boxShadow: [
//                                           BoxShadow(
//                                             color: Colors.grey.shade200,
//                                             spreadRadius: 1,
//                                             blurRadius: 1,
//                                             offset: const Offset(0, 0.1),
//                                           ),
//                                           BoxShadow(
//                                             color: Colors.grey.shade200,
//                                             spreadRadius: 1,
//                                             blurRadius: 1,
//                                             offset: const Offset(0, -0.1),
//                                           ),
//                                           BoxShadow(
//                                             color: Colors.grey.shade200,
//                                             spreadRadius: 1,
//                                             blurRadius: 1,
//                                             offset: const Offset(-0.1, 0),
//                                           ),
//                                           BoxShadow(
//                                             color: Colors.grey.shade200,
//                                             spreadRadius: 1,
//                                             blurRadius: 1,
//                                             offset: const Offset(0.1, 0),
//                                           ),
//                                         ]),
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: Row(
//                                         children: [
//                                           ClipRRect(
//                                             borderRadius: BorderRadius.circular(100.r),
//                                             child: CachedNetworkImage(
//                                               height: 57,
//                                               width: 57,
//                                               imageUrl: widget.profile?[index] ?? "",
//                                               placeholder: (context, url) => CircularProgressIndicator(),
//                                               errorWidget: (context, url, error) => Icon(Icons.error),
//                                             ),
//                                           ),
//                                           SizedBox(
//                                             width: 10.w,
//                                           ),
//                                           Column(
//                                             crossAxisAlignment: CrossAxisAlignment.start,
//                                             children: [
//                                               Text(
//                                                 widget.name?[index] ?? "",
//                                                 style: TextStyle(
//                                                   fontSize: 18.sp,
//                                                   fontWeight: FontWeight.bold,
//                                                   color: primary,
//                                                 ),
//                                               ),
//                                               Text(
//                                                 widget.name?[index] ?? "",
//                                               ),
//                                               SizedBox(
//                                                 width: 200.w,
//                                                 child: Text(
//                                                   widget.name?[index] ?? "",
//                                                   overflow: TextOverflow.ellipsis,
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                           const Spacer(),
//                                           if (widget.statusId == 3 ||
//                                               ((widget.statusId == 4 || widget.statusId == -1) &&
//                                                       widget.statusApproved! > 0) &&
//                                                   click == true)
//                                             click == false
//                                                 ? const SizedBox()
//                                                 : Checkbox(
//                                                     shape: RoundedRectangleBorder(
//                                                       borderRadius: BorderRadius.circular(100.r),
//                                                     ),
//                                                     value: isChecked,
//                                                     onChanged: (val) {
//                                                       setState(() {
//                                                         if (val!) {
//                                                           checkedIds.add(data.eLeaveId.toString());
//                                                         } else {
//                                                           checkedIds.remove(data.eLeaveId.toString());
//                                                         }
//                                                       });
//                                                     },
//                                                   )
//                                           else
//                                             const SizedBox()
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             SizedBox(
//                               height: 5.h,
//                             ),
//                             Container(
//                               width: 320.w,
//                               decoration: BoxDecoration(
//                                   color: appBarColor,
//                                   borderRadius: BorderRadius.circular(13),
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: Colors.grey.shade200,
//                                       spreadRadius: 1,
//                                       blurRadius: 1,
//                                       offset: const Offset(0, 0.1),
//                                     ),
//                                     BoxShadow(
//                                       color: Colors.grey.shade200,
//                                       spreadRadius: 1,
//                                       blurRadius: 1,
//                                       offset: const Offset(0, -0.1),
//                                     ),
//                                     BoxShadow(
//                                       color: Colors.grey.shade200,
//                                       spreadRadius: 1,
//                                       blurRadius: 1,
//                                       offset: const Offset(-0.1, 0),
//                                     ),
//                                     BoxShadow(
//                                       color: Colors.grey.shade200,
//                                       spreadRadius: 1,
//                                       blurRadius: 1,
//                                       offset: const Offset(0.1, 0),
//                                     ),
//                                   ]),
//                               child: Padding(
//                                 padding: const EdgeInsets.only(top: 10, bottom: 10, right: 10, left: 10),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Row(
//                                       children: [
//                                         Container(
//                                           child: const Text(
//                                             "ວັນທີ",
//                                             style: TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                             ),
//                                           ),
//                                         ),
//                                         SizedBox(
//                                           width: 15.w,
//                                         ),
//                                         Container(
//                                           child: Text(
//                                             widget.name?[index] ?? "",
//                                           ),
//                                         ), // This will push the following widget to the end
//                                       ],
//                                     ),
//                                     Row(
//                                       children: [
//                                         const Text(
//                                           "ໂຄງການ",
//                                           style: TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                         SizedBox(
//                                           width: 15.w,
//                                         ),
//                                         SizedBox(
//                                           width: 250.w,
//                                           child: Text(
//                                             widget.name?[index] ?? "",
//                                             overflow: TextOverflow.ellipsis,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     Row(
//                                       children: [
//                                         const Text(
//                                           "ໜ້າວຽກ",
//                                           style: TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                         SizedBox(
//                                           width: 15.w,
//                                         ),
//                                         const Text(
//                                           "",
//                                         ),
//                                       ],
//                                     ),
//                                     SizedBox(
//                                       height: 10.h,
//                                     ),
//                                     Row(
//                                       children: [
//                                         const Text(
//                                           "ມື້ຂໍໂອທີ",
//                                           style: TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                         SizedBox(
//                                           width: 15.w,
//                                         ),
//                                         Text(
//                                           widget.name?[index] ?? "",
//                                         ),
//                                       ],
//                                     ),
//                                     Row(
//                                       children: [
//                                         const Text(
//                                           "ເວລາກົດໂຕຈິງ",
//                                           style: TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                         SizedBox(
//                                           width: 15.w,
//                                         ),
//                                         Text(
//                                           widget.name?[index] ?? "",
//                                         ),
//                                       ],
//                                     ),
//                                     Row(
//                                       children: [
//                                         const Text(
//                                           "ປະເພດໂອທີ",
//                                           style: TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                         SizedBox(
//                                           width: 15.w,
//                                         ),
//                                         Text(
//                                           widget.name?[index] ?? "",
//                                         ),
//                                       ],
//                                     ),
//                                     Row(
//                                       children: [
//                                         const Text(
//                                           "ໝາຍເຫດ",
//                                           style: TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                         SizedBox(
//                                           width: 15.w,
//                                         ),
//                                         Text(
//                                           widget.name?[index] ?? "",
//                                         ),
//                                       ],
//                                     ),
//                                     Row(
//                                       children: [
//                                         const Text(
//                                           "ສະຖານະ",
//                                           style: TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                         SizedBox(
//                                           width: 15.w,
//                                         ),
//                                         Text(
//                                           widget.name?[index] ?? "",
//                                         ),
//                                       ],
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         );
//                       }),
//                 ),
//                 SizedBox(
//                   height: 10.h,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: 50),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       GestureDetector(
//                         onTap: () {
//                           // PMService().pmapprove(context, checkedIds, '0', '');
//                         },
//                         child: Container(
//                           alignment: Alignment.center,
//                           height: 30.h,
//                           width: 120.w,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(23.r),
//                             color: red,
//                           ),
//                           child: const Text(
//                             "Unapprovede",
//                             style: TextStyle(color: white),
//                           ),
//                         ),
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           //  PMService().pmapprove(context, checkedIds, '1', '');
//                         },
//                         child: Container(
//                           alignment: Alignment.center,
//                           height: 30.h,
//                           width: 120.w,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(23.r),
//                             color: primary,
//                           ),
//                           child: const Text(
//                             "Approvede",
//                             style: TextStyle(
//                               color: white,
//                             ),
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//         );
//       }),
//     );
//   }
// }
