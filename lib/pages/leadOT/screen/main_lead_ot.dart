import 'package:flutter/material.dart';
import 'package:fms_mobile_app/pages/leadOT/component/await_lead_ot.dart';
import 'package:fms_mobile_app/pages/leadOT/component/success_lead_ot.dart';

class MainLeadOT extends StatefulWidget {
  const MainLeadOT({super.key});

  @override
  State<MainLeadOT> createState() => _MainLeadOTState();
}

class _MainLeadOTState extends State<MainLeadOT> with SingleTickerProviderStateMixin {
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
        title: const Text("ອະນຸມັດລາພັກ"),
        bottom: TabBar(
          controller: _tabController, 
          tabs: const [
          Tab(text: 'ລໍຖ້າກວດສອບ'),
          Tab(text: 'ກວດສອບແລ້ວ'),
        ]),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          AwaitLeadOT(),
          SuccessLeadOT(),
        ],
      ),
    );
  }
}
