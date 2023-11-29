// ignore_for_file: override_on_non_overriding_member

import 'package:flutter/material.dart';
import 'package:fms_mobile_app/pages/ot/HR/hr_checking_success.dart';
import 'package:fms_mobile_app/pages/ot/HR/hr_screen.dart';

class MainHR extends StatefulWidget {
  const MainHR({super.key});

  @override
  State<MainHR> createState() => _MainHRState();
}

class _MainHRState extends State<MainHR> with SingleTickerProviderStateMixin {
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

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ອະນຸມັດໂອທີຈາກHR'),
        bottom: TabBar(controller: _tabController, tabs: const [
          Tab(text: 'ລໍຖ້າກວດສອບ'),
          Tab(text: 'ກວດສອບແລ້ວ'),
        ]),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          HRScreenOT(),
          HRCheckingSuccess(),
        ],
      ),
    );
  }
}
