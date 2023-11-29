import 'package:flutter/material.dart';
import 'package:fms_mobile_app/pages/Approve/HRApproveVacation/components/await_leave.dart';
import 'package:fms_mobile_app/pages/Approve/HRApproveVacation/components/checking_succes.dart';

class HRMainOT extends StatefulWidget {
  const HRMainOT({super.key});

  @override
  State<HRMainOT> createState() => _HRMainOTState();
}

class _HRMainOTState extends State<HRMainOT> with SingleTickerProviderStateMixin {
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
        bottom: TabBar(controller: _tabController, tabs: const [
          Tab(text: 'ລໍຖ້າກວດສອບ'),
          Tab(text: 'ກວດສອບແລ້ວ'),
        ]),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          AwaitOT(),
          CheckingSuccess(),
        ],
      ),
    );
  }
}
