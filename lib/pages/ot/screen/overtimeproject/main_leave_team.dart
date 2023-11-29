import 'package:flutter/material.dart';
import 'package:fms_mobile_app/pages/ot/screen/overtimeproject/await_checking.dart';
import 'package:fms_mobile_app/pages/ot/screen/overtimeproject/success_checking_team.dart';

class MainLeaveTeams extends StatefulWidget {
  const MainLeaveTeams({super.key});

  @override
  State<MainLeaveTeams> createState() => _MainLeaveTeamsState();
}


class _MainLeaveTeamsState extends State<MainLeaveTeams>with SingleTickerProviderStateMixin  {
  @override
   TabController? _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: const Text("ອະນຸມັດລາພັກ"),
        bottom: TabBar(controller: _tabController, tabs: const [
          Tab(text: 'ລໍຖ້າກວດສອບ'),
          Tab(text: 'ກວດສອບແລ້ວ'),
        ]),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
         AwaitCheckingCompo(),
         SuccessCheckingTeams()
        ],
      ),
    );
  }
}