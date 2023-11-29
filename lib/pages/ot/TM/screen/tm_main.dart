import 'package:flutter/material.dart';
import 'package:fms_mobile_app/pages/ot/TM/components/tm_await.dart';
import 'package:fms_mobile_app/pages/ot/TM/components/tm_success.dart';

class TMMain extends StatefulWidget {
  const TMMain({super.key});

  @override
  State<TMMain> createState() => _TMMainState();
}

class _TMMainState extends State<TMMain> with SingleTickerProviderStateMixin {
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
        title: const Text('ອະນຸມັດລາພັກ'),
        bottom: TabBar(controller: _tabController, tabs: const [
          Tab(text: 'ລໍຖ້າກວດສອບ'),
          Tab(text: 'ກວດສອບແລ້ວ'),
        ]),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          TMAwaitCompo(),
          TMSuceesCompo(),
        ],
      ),
    );
  
  }
}
