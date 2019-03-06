import 'package:flutter/material.dart';
import 'tab/TabHome.dart';
import 'tab/TabDevice.dart';
import 'tab/TabMy.dart';
class TabPage extends StatefulWidget{

  @override
  State createState() => TabPageState();
}

class TabPageState extends State<TabPage> with SingleTickerProviderStateMixin{

  TabController _tabController;
  
  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
  }


  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text('底部Tab示例'),),
      body: TabBarView(
        controller: _tabController,
        children: [
          TabHome(),
          TabDevice(),
          TabMy()
        ]
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: TabBar(
          controller: _tabController,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorWeight: 3,
          labelColor: Colors.blueGrey,
          labelStyle: TextStyle(fontSize: 14),
          tabs: [
            Tab(
              text: '首页',
              icon: Icon(Icons.home, color: Colors.blueGrey),
            ),
            Tab(
              text: '设备列表',
              icon: Icon(Icons.cloud_queue, color: Colors.blueGrey),
            ),
            Tab(
              text: '个人中心',
              icon: Icon(Icons.people, color: Colors.blueGrey),
            )
          ]
        ),
      ),
    );
  }
}