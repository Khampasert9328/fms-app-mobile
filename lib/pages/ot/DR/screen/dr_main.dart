import 'package:flutter/material.dart';
import 'package:fms_mobile_app/pages/ot/DR/component/dr_await.dart';
import 'package:fms_mobile_app/pages/ot/DR/component/dr_success.dart';

class DRMainOT extends StatefulWidget {
  const DRMainOT({super.key});

  @override
  State<DRMainOT> createState() => _DRMainOTState();
}

class _DRMainOTState extends State<DRMainOT> with SingleTickerProviderStateMixin{
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
        title: const Text('ອະນຸມັດໂອທີຈາກ DR'),
        bottom: TabBar(controller: _tabController, tabs: const [
          Tab(text: 'ລໍຖ້າກວດສອບ'),
          Tab(text: 'ກວດສອບແລ້ວ'),
        ]),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          DRAwait(),
          DRSuccess()
         
        ],
      ),
    );
  }
}