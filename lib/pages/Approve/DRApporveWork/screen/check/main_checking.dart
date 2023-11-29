import 'package:flutter/material.dart';
import 'package:fms_mobile_app/pages/Approve/DRApporveWork/components/await_timesheet.dart';
import 'package:fms_mobile_app/pages/Approve/DRApporveWork/components/success_timesheets.dart';

class MainChecking extends StatefulWidget {
  const MainChecking({super.key});

  @override
  State<MainChecking> createState() => _MainCheckingState();
}

class _MainCheckingState extends State<MainChecking> with SingleTickerProviderStateMixin{
   @override
  TabController? _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }
  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ລາຍການ TimeSheets'),
        bottom: TabBar(controller: _tabController, tabs: const [
          Tab(text: 'ລໍຖ້າກວດສອບ'),
          Tab(text: 'ກວດສອບແລ້ວ'),
        ]),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
         AwaitTimeSheets(),
         SuccessTimeSheets()
         
        ],
      ),
    );
  }
}