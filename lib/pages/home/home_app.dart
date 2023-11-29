import 'package:flutter/material.dart';
import 'package:fms_mobile_app/pages/acount/account.dart';
import 'package:badges/badges.dart' as badges;
import 'package:fms_mobile_app/pages/home/home_page.dart';
import 'package:fms_mobile_app/pages/noti/noti_page.dart';
import 'package:fms_mobile_app/services/provider_service.dart';
import 'package:fms_mobile_app/shared/mydata.dart';
import 'package:fms_mobile_app/theme/color.dart';

import 'package:provider/provider.dart';

class HomeApp extends StatefulWidget {
  const HomeApp({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeAppState createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  // ignore: prefer_final_fields
  var _pages = [
    const HomePages(),
    // const ChatPage(),
    // const ActivePage(),
    const NotiPage(),
    const AccountPage(),
  ];

  // ignore: prefer_final_fields

  //TabController? _tabController;
  @override
  void initState() {
    super.initState();
    checkingWork();
    //  _tabController = TabController(length: 2, vsync: this);
  }

  Future checkingWork() async {
    final providerService = Provider.of<ProviderService>(context, listen: false);

    await providerService.setPendingDay();
    if (providerService.NotiCout != '0') {
      providerService.setNotiCout();
    }
  }

  @override
  Widget build(BuildContext context) {
    final providerService = Provider.of<ProviderService>(context, listen: false);
    String Home = providerService.langs == 'la' ? "ໜ້າຫຼັກ" : "Home";
    String Chat = providerService.langs == 'la' ? "ສົນທະນາ" : "Chat";
    String Active = providerService.langs == 'la' ? "ປະຈຳການ" : "Active";
    String Notification = providerService.langs == 'la' ? "ແຈ້ງເຕືອນ" : "Notification";
    String Setting = providerService.langs == 'la' ? "ຕັ້ງຄ່າ" : "Setting";

    var _bottomItems = <NavigationDestination>[
      NavigationDestination(
        icon: Icon(Icons.home_outlined, size: 25.0),
        label: '${Home}',
        selectedIcon: Icon(Icons.home_outlined, color: primary, size: 25.0),
      ),
      // NavigationDestination(
      //   icon: Icon(Icons.chat_bubble_outline_outlined, size: 25.0),
      //   label: '${Chat}',
      //   selectedIcon: Icon(Icons.chat_bubble_outline_outlined,
      //       color: primary, size: 25.0),
      // ),
      // NavigationDestination(
      //   icon: Icon(Icons.auto_graph_rounded, size: 25.0),
      //   label: '${Active}',
      //   selectedIcon:
      //       Icon(Icons.auto_graph_rounded, color: primary, size: 25.0),
      // ),
      NavigationDestination(
        icon: MyData.noticout > 0
            ? badges.Badge(
                badgeContent: Text(
                  MyData.noticout > 99 ? '99+' : '${MyData.noticout}',
                  style: TextStyle(color: appBarColor, fontSize: 11),
                ),
                child: Icon(Icons.notifications_none, size: 25.0))
            : const Icon(Icons.notifications_none, size: 25.0),
        label: '${Notification}',
        selectedIcon: MyData.noticout > 0
            ? badges.Badge(
                badgeContent: Text(
                  MyData.noticout > 99 ? '99+' : '${MyData.noticout}',
                  style: TextStyle(color: appBarColor, fontSize: 11),
                ),
                child: Icon(Icons.notifications_none, color: primary, size: 25.0))
            : Icon(Icons.notifications_none, color: primary, size: 25.0),
      ),
      NavigationDestination(
        icon: const Icon(
          Icons.settings_outlined,
          size: 25.0,
        ),
        label: '${Setting}',
        selectedIcon: Icon(Icons.settings_outlined, color: primary, size: 25.0),
      ),
    ];

    return Scaffold(
      body: PageView(
        controller: Provider.of<ProviderService>(context, listen: true).pageController,
        children: [_pages.elementAt(providerService.pageSelected)],
      ),
      bottomNavigationBar: NavigationBar(
        destinations: _bottomItems,
        selectedIndex: providerService.pageSelected,
        onDestinationSelected: onBarTap,
      ),
    );
  }

  onBarTap(index) {
    final providerService = Provider.of<ProviderService>(context, listen: false);
    setState(() {
      providerService.pageSelected = index;
    });
  }
}
