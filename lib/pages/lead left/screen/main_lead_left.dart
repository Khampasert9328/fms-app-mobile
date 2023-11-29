import 'package:flutter/material.dart';
import 'package:fms_mobile_app/pages/lead%20left/component/await_lead_left.dart';
import 'package:fms_mobile_app/pages/lead%20left/component/success_lead_left.dart';

class MainLeadLeft extends StatefulWidget {
  const MainLeadLeft({super.key});

  @override
  State<MainLeadLeft> createState() => _MainLeadLeftState();
}

class _MainLeadLeftState extends State<MainLeadLeft> with SingleTickerProviderStateMixin {
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
          AwaitLeadLeft(),
          SuccessLeadLeft()
        ],
      ),
    );
  }
}
