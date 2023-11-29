import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fms_mobile_app/pages/teams/team_work_list.dart';

import 'package:fms_mobile_app/services/provider_service.dart';
import 'package:fms_mobile_app/theme/color.dart';

import 'package:fms_mobile_app/widgets/team_item.dart';
import 'package:fms_mobile_app/widgets/team_item_shimmer.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class TeamWork extends StatefulWidget {
  const TeamWork({super.key});

  @override
  State<TeamWork> createState() => _TeamWorkState();
}

late Map<DateTime, List<Appointment>> _dataCollection;

class _TeamWorkState extends State<TeamWork> {
  @override
  void initState() {
    super.initState();
    checkingWorks();
  }

  _FuctionNewTap(BuildContext context) async {
    String refresh = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => const TeamWorkList()));

    if (refresh == "") {
      // setDataCalendarWorkRe();
      // setData();
    }
  }

  Future checkingWorks() async {
    final providerService =
        Provider.of<ProviderService>(context, listen: false);

    await providerService.setTeamWork();

    setState(() {
      providerService.loadding_teamwork = false;
      providerService.loadding_teamworkstad = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        leading: IconButton(
          icon: Icon(
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
        title: new Text("ທີມງານ", style: const TextStyle(color: Colors.white)),
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
      body: getHeader(),
    );
  }

  getHeader() {
    final providerService = Provider.of<ProviderService>(context);
    final teamwork = providerService.teamwork;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 0, left: 10, right: 10),
        child: Column(
          children: <Widget>[
            teamwork.length > 0
                ? SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height - 100,
                    child: RefreshIndicator(
                      onRefresh: () async {
                        setState(() {
                          providerService.loadding_teamwork = true;
                          providerService.loadding_teamworkstad = 1;
                        });
                        await Future.delayed(Duration(seconds: 2));
                        await providerService.Refreshteamwork_page();
                        setState(() {
                          providerService.loadding_teamwork = false;
                          providerService.loadding_teamworkstad = 0;
                        });
                      },
                      child: providerService.loadding_teamwork == true &&
                              providerService.loadding_teamworkstad == 1
                          ? ListView.builder(
                              physics: AlwaysScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: 7,
                              itemBuilder: (context, index) {
                                return TeamItemShimmer();

                                // return PostItemShimmer();
                              },
                              // separatorBuilder: (context, index) {
                              //   return ();
                              // },
                            )
                          : ListView.builder(
                              physics: AlwaysScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: teamwork.length,
                              itemBuilder: (context, index) {
                                final item = teamwork[index];

                                // print(item.profileImgNew);
                                return TeamItem(
                                  onPressed: () async {
                                    final providerService =
                                        Provider.of<ProviderService>(context,
                                            listen: false);
                                   // print(1);
                                    await providerService.SetEmployeeId(
                                        item.employeeId);
                                    _FuctionNewTap(context);
                                  },
                                  profileImg: item.profileImgNew.toString(),
                                  fullname: item.fullname.toString(),
                                  level: item.level.toString(),
                                  cout : '0',
                                  divisionname: item.divisionName.toString(),
                                );

                                // return PostItemShimmer();
                              },
                              // separatorBuilder: (context, index) {
                              //   return ();
                              // },
                            ),
                    ),
                  )
                : SizedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search_outlined,
                              color: Colors.grey,
                            ),
                            Text(
                              "ບໍ່ມີທີມ",
                              style: TextStyle(color: Colors.grey),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
