import 'package:flutter/material.dart';
import 'package:fms_mobile_app/pages/hr_leave/component/await_hr_leave.dart';
import 'package:fms_mobile_app/pages/hr_leave/component/succes_hr_leave.dart';

class MainHRLeave extends StatefulWidget {
  const MainHRLeave({super.key});

  @override
  State<MainHRLeave> createState() => _MainHRLeaveState();
}

class _MainHRLeaveState extends State<MainHRLeave> with SingleTickerProviderStateMixin {
  TabController? _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ອະນຸມັດ ລາພັກ"),
        bottom: TabBar(controller: _tabController, tabs: const [
          Tab(text: 'ລໍຖ້າກວດສອບ'),
          Tab(text: 'ກວດສອບແລ້ວ'),
        ]),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          AwaitHRLeave(),
          SuccessHRLeave(),
        ],
      ),
    );
  }
}
