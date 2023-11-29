import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fms_mobile_app/services/provider_service.dart';
import 'package:fms_mobile_app/shared/mydata.dart';
import 'package:fms_mobile_app/theme/color.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';

class ProfilePreview extends StatefulWidget {
  const ProfilePreview({Key? key}) : super(key: key);

  @override
  _ProfilePreviewState createState() => _ProfilePreviewState();
}

class _ProfilePreviewState extends State<ProfilePreview> {
  // ignore: unused_field
  bool? _isLoading;
  bool? _loding;

  @override
  void initState() {
    super.initState();

    checkingWorks();
  }

  Future checkingWorks() async {
    final providerService = Provider.of<ProviderService>(context, listen: false);
    setState(() {
      _loding = true;
    });

    await providerService.setUserDetailModel();

    setState(() {
      _loding = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final providerService = Provider.of<ProviderService>(context);
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
        title: Text(providerService.langs == 'la' ? "ຂໍ້ມູນສ່ວນໂຕ" : 'Personal Information',
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
    final providerService = Provider.of<ProviderService>(context, listen: false);

    //  final userImageList = providerService.imageHistory!.data;

    var format = providerService.langs == 'la' ? DateFormat.yMMMMd('lo') : DateFormat.yMMMMd('en');

    DateTime dateFull = DateTime.parse(MyData.dob);

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
                                image: NetworkImage('${MyData.profileImg}'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        '${MyData.fullnameLa}',
                        style: const TextStyle(
                          fontSize: 18,
                          color: primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // SizedBox(height: 2),
                      // Text(
                      //   '${MyData.division_name}',
                      //   style: TextStyle(
                      //     fontSize: 14,
                      //     color: Colors.grey,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                      const SizedBox(height: 2),
                      Text(
                        '${MyData.level}',
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
                // const SizedBox(height: 16),
                //    userImageList!.length == 0
                //     ? SizedBox()
                //     : const Text(
                //         'ຮູບພາບ',
                //         style: TextStyle(
                //           fontSize: 14,
                //           fontWeight: FontWeight.bold,
                //         ),
                //       ),
                // const SizedBox(height: 8),
                // Container(
                //     decoration: BoxDecoration(
                //       border: Border(
                //         bottom: BorderSide(
                //           color: Colors.grey.shade200,
                //         ),
                //       ),
                //     ),
                //     child: Consumer<ProviderService>(
                //         builder: (context, model, child) {
                //       return GridView.builder(
                //         itemCount: model.imageHistory?.data?.length,
                //         shrinkWrap: true,
                //         physics: const NeverScrollableScrollPhysics(),
                //         gridDelegate:
                //             const SliverGridDelegateWithFixedCrossAxisCount(
                //           crossAxisCount: 3,
                //           childAspectRatio: 1,
                //           crossAxisSpacing: 8,
                //           mainAxisSpacing: 8,
                //         ),
                //         itemBuilder: (BuildContext context, int index) {
                //           final item = model.imageHistory?.data?[index];
                //           return Container(
                //             child: ClipRRect(
                //               borderRadius: BorderRadius.circular(8),
                //               child: FadeInImage(
                //                 width: 150,
                //                 placeholder: AssetImage(
                //                     "assets/images/loading_plaholder.gif"),
                //                 image:
                //                     NetworkImage("${item?.attendanceImgurl}"),
                //                 fit: BoxFit.cover,
                //               ),
                //             ),
                //           );
                //         },
                //       );
                //     })),
                const SizedBox(height: 16),
                Text(
                  providerService.langs == 'la' ? "ຂໍ້ມູນສ່ວນໂຕ" : ' Personal Information',
                  style: const TextStyle(
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
                              providerService.langs == 'la' ? 'ອາຍຸ ' : ' Age',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 14.sp, color: black),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              providerService.langs == 'la' ? 'ເພດ ' : ' Gender',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 14.sp, color: black),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              providerService.langs == 'la' ? 'ວັນເດືອນປີເກີດ ' : ' Date of birth',
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
                                '${MyData.age}',
                                style: TextStyle(fontSize: 14.sp, color: primary),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                '${MyData.gender}',
                                style: TextStyle(fontSize: 14.sp, color: primary),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                '${formattedDate}',
                                style: TextStyle(fontSize: 14.sp, color: primary),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),
                Text(
                  providerService.langs == 'la' ? 'ສັງກັດ' : ' Affiliation',
                  style: const TextStyle(
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
                              providerService.langs == 'la' ? 'ພະແນກ ' : ' Department',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 14.sp, color: black),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              providerService.langs == 'la' ? 'ໜ່ວຍງານ ' : ' Division',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 14.sp, color: black),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              providerService.langs == 'la' ? 'ບ່ອນປະຈຳການ ' : ' Office',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 14.sp, color: black),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              providerService.langs == 'la' ? 'ປະເພດການເຮັດວຽກ ' : ' Work Type',
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
                                '${MyData.department_name}',
                                style: TextStyle(fontSize: 12.sp, color: primary),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                '${MyData.division_name}',
                                style: TextStyle(fontSize: 12.sp, color: primary),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                '${MyData.workingArea}',
                                style: TextStyle(fontSize: 12.sp, color: primary),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                '${MyData.workingType}',
                                style: TextStyle(fontSize: 14.sp, color: primary),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  providerService.langs == 'la' ? 'ຕິດຕໍ່' : ' Contact',
                  style: const TextStyle(
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
                              providerService.langs == 'la' ? 'ເບີໂທລະສັບ ' : ' Mobile',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 14.sp, color: black),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              providerService.langs == 'la' ? 'ອີເມວ ' : ' Email',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 14.sp, color: black),
                            ),
                          ],
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              const SizedBox(height: 10),
                              Text(
                                '${MyData.mobile}',
                                style: TextStyle(fontSize: 14.sp, color: primary),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                '${MyData.email}',
                                style: TextStyle(fontSize: 14.sp, color: primary),
                              ),
                            ],
                          ),
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
