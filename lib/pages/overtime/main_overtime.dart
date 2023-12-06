import 'package:flutter/material.dart';
import 'package:fms_mobile_app/pages/overtime/screen/ot_await.dart';
import 'package:fms_mobile_app/pages/overtime/screen/ot_success.dart';
import 'package:fms_mobile_app/theme/color.dart';

class MainOverTime extends StatefulWidget {
  const MainOverTime({super.key});

  @override
  State<MainOverTime> createState() => _MainOverTimeState();
}

class _MainOverTimeState extends State<MainOverTime> with SingleTickerProviderStateMixin {
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
        title: const Text("ຂໍ້ມູນໂອທີ"),
        bottom: TabBar(controller: _tabController, tabs: const [
          Tab(text: 'ລໍຖ້າກວດສອບ'),
          Tab(text: 'ກວດສອບແລ້ວ'),
        ]),
        actions: [
          IconButton(
            onPressed: () {
              //to do
            },
            icon: const Icon(
              Icons.add,
              color: primary,
            ),
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          AwaitMyOT(),
          SuccessMyOT(),
        ],
      ),
    );
  }
}
