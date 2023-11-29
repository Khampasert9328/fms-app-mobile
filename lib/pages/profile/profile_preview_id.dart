import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fms_mobile_app/services/provider_service.dart';
import 'package:fms_mobile_app/theme/color.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProfilePreviewID extends StatefulWidget {
  const ProfilePreviewID({Key? key}) : super(key: key);

  @override
  _ProfilePreviewIDState createState() => _ProfilePreviewIDState();
}

class _ProfilePreviewIDState extends State<ProfilePreviewID> {
  bool? _isLoading;
  bool? _loding;

  @override
  void initState() {
    super.initState();

    checkingWorks();
  }

  Future checkingWorks() async {
    final providerService =
        Provider.of<ProviderService>(context, listen: false);
    setState(() {
      _loding = true;
    });
     await providerService.SetItemEmployeeId();
    final userDetailById = providerService.userDetailById;
    // await Future.delayed(Duration(seconds: 2), (() {

    //setState(() => _isLoading = false);
    setState(() {
      _loding = false;
    });
    // }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: white,
          ),
          onPressed: () {
            Navigator.pop(
              context,
              // MYHomePage is another page for showcase
              // replace it with your page name
            );
          },
        ),
        title: new Text("ຂໍ້ມູນສ່ວນໂຕ",
            style: const TextStyle(color: Colors.white)),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[Color(0xff039881), Color(0xff024C41)]),
          ),
        ),
      ),
      body: _loding == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              // ignore: prefer_const_constructors
              child: getBody()),
    );
  }

  Widget getBody() {
    String formattedDate = "";
    final providerService =
        Provider.of<ProviderService>(context, listen: false);

    final userDetailById = providerService.userDetailById!.data;
    // final userImageList = providerService.userImageList!.data;

    var format = providerService.langs == 'la' ?  DateFormat.yMMMMd('lo') :  DateFormat.yMMMMd('en');

    DateTime dateFull = DateTime.parse(userDetailById!.dob.toString());

    formattedDate = format.format(dateFull);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey.shade200,
                ),
              ),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage(
                                    '${userDetailById.profileImgNew}'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        '${userDetailById.fullname}',
                        style: const TextStyle(
                          fontSize: 18,
                          color: primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${userDetailById.level}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              //    userImageList!.length == 0
              //       ? SizedBox()
              //       : const SizedBox(height: 16),
              //   userImageList.length == 0
              //       ? SizedBox()
              //       : const Text(
              //           'ຮູບພາບ',
              //           style: TextStyle(
              //             fontSize: 14,
              //             fontWeight: FontWeight.bold,
              //           ),
              //         ),
              //  userImageList.length == 0
              //       ? SizedBox()
              //       :   const SizedBox(height: 8),
              //    userImageList.length == 0
              //       ? SizedBox()
              //       : Container(
              //       decoration: BoxDecoration(
              //         border: Border(
              //           bottom: BorderSide(
              //             color: Colors.grey.shade200,
              //           ),
              //         ),
              //       ),
              //       child: Consumer<ProviderService>(
              //           builder: (context, model, child) {
              //         return GridView.builder(
              //           itemCount: model.userImageList?.data?.length,
              //           shrinkWrap: true,
              //           physics: const NeverScrollableScrollPhysics(),
              //           gridDelegate:
              //               const SliverGridDelegateWithFixedCrossAxisCount(
              //             crossAxisCount: 3,
              //             childAspectRatio: 1,
              //             crossAxisSpacing: 8,
              //             mainAxisSpacing: 8,
              //           ),
              //           itemBuilder: (BuildContext context, int index) {
              //             final item = model.userImageList?.data?[index];
              //             return Container(
              //               child: ClipRRect(
              //                 borderRadius: BorderRadius.circular(8),
              //                 child: FadeInImage(
              //                   width: 150,
              //                   placeholder: AssetImage(
              //                       "assets/images/loading_plaholder.gif"),
              //                   image:
              //                       NetworkImage("${item?.attendanceImgurl}"),
              //                   fit: BoxFit.cover,
              //                 ),
              //               ),
              //             );
              //           },
              //         );
              //       })),
                const SizedBox(height: 16),
                const Text(
                  'ຂໍ້ມູນສ່ວນໂຕ',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey.shade200,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'ອາຍຸ ',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 14.sp, color: black),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'ເພດ ',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 14.sp, color: black),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'ວັນເດືອນປີເກີດ ',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 14.sp, color: black),
                            ),
                          ],
                        ),
                        Container(
                          // width: MediaQuery.of(context).size.width * 0.4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              const SizedBox(height: 10),
                              Text(
                                overflow: TextOverflow.ellipsis,
                                '${userDetailById.age}',
                                style:
                                    TextStyle(fontSize: 14.sp, color: primary),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                '${userDetailById.gender}',
                                style:
                                    TextStyle(fontSize: 14.sp, color: primary),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                '${formattedDate}',
                                style:
                                    TextStyle(fontSize: 14.sp, color: primary),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'ສັງກັດ',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey.shade200,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'ພະແນກ ',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 14.sp, color: black),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'ໜ່ວຍງານ ',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 14.sp, color: black),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'ບ່ອນປະຈຳການ ',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 14.sp, color: black),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'ປະເພດການເຮັດວຽກ ',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 14.sp, color: black),
                            ),
                          ],
                        ),
                        Container(
                          // width: MediaQuery.of(context).size.width * 0.4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              const SizedBox(height: 10),
                              Text(
                                overflow: TextOverflow.ellipsis,
                                '${userDetailById.departmentName}',
                                style:
                                    TextStyle(fontSize: 12.sp, color: primary),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                '${userDetailById.divisionName}',
                                style:
                                    TextStyle(fontSize: 12.sp, color: primary),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                '${userDetailById.workingArea}',
                                style:
                                    TextStyle(fontSize: 12.sp, color: primary),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                '${userDetailById.workingType}',
                                style:
                                    TextStyle(fontSize: 14.sp, color: primary),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'ຕິດຕໍ່',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey.shade200,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            Text(
                              'ເບີໂທລະສັບ ',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 14.sp, color: black),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'ອີເມວ ',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 14.sp, color: black),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            const SizedBox(height: 10),
                            Text(
                              '${userDetailById.mobile}',
                              style:
                                  TextStyle(fontSize: 14.sp, color: primary),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              '${userDetailById.email}',
                              style:
                                  TextStyle(fontSize: 14.sp, color: primary),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
