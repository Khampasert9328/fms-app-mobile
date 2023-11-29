// ignore_for_file: override_on_non_overriding_member

import 'package:flutter/material.dart';
import 'package:fms_mobile_app/pages/ot/PM/component/await_checking.dart';
import 'package:fms_mobile_app/pages/ot/PM/component/success_checking.dart';

class PMMain extends StatefulWidget {
  const PMMain({super.key});

  @override
  State<PMMain> createState() => _PMMainState();
}

class _PMMainState extends State<PMMain> with SingleTickerProviderStateMixin{
  
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
        title: const Text('ອະນຸມັດໂອທີຈາກ PM'),
        bottom: TabBar(controller: _tabController, tabs: const [
          Tab(text: 'ລໍຖ້າກວດສອບ'),
          Tab(text: 'ກວດສອບແລ້ວ'),
        ]),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          PMAwaitChecking(),
          PMSuccessChecking()
         
        ],
      ),
    );
  }
}