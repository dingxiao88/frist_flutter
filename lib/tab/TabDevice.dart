import 'package:flutter/material.dart';
class TabDevice extends StatefulWidget{

  @override
  State createState() => TabDeviceState();
}

class TabDeviceState extends State<TabDevice>{

  bool isGridview = false;

  @override
  void initState() {

  }

  _onTurnate(){

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('设备列表'),
        actions: <Widget>[
          IconButton(icon: Icon(isGridview?Icons.border_all:Icons.list), onPressed: _onTurnate)
        ],
      ),
      body: Center(child: Text('device'),)
    );
  }
}