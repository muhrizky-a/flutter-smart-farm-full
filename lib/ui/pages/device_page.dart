import 'package:flutter/material.dart';
import '../constant.dart';
import 'main_page/main_control_tab.dart';
import 'main_page/main_dashboard_tab.dart';
import 'main_page/main_monitoring_tab.dart';

class DevicePage extends StatefulWidget {
  const DevicePage({super.key});

  @override
  State<DevicePage> createState() => _DevicePageState();
}

class _DevicePageState extends State<DevicePage>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;
  late final List<Widget> tabs;
  late final List<Widget> tabView;
  // Widget selectedWidget = const SizedBox();

  @override
  void initState() {
    super.initState();

    tabs = [
      const Tab(icon: Icon(Icons.dashboard), text: "Dashboard"),
      const Tab(icon: Icon(Icons.gas_meter), text: "Monitoring"),
      const Tab(icon: Icon(Icons.control_camera), text: "Kontrol"),
    ];
    tabView = [
      const MainDashboardTab(),
      const MainMonitoringTab(),
      const MainControlTab(),
    ];
    // selectedWidget = tabView.first;

    tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: greenMainColor,
          title: const Text("AgroSense"),
          bottom: TabBar(
            controller: tabController,
            tabs: tabs,
          ),
        ),
        body: TabBarView(
          controller: tabController,
          children: tabView,
        ),
      ),
    );
  }
}
