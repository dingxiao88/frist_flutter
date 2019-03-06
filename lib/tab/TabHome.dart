import 'package:flutter/material.dart';
class TabHome extends StatefulWidget{

  @override
  State createState() => TabHomeState();
}

class TabHomeState extends State<TabHome>{

  @override
  void initState() {

  }

  _onPlusPress(){

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('千贯能源科技'), automaticallyImplyLeading: false,),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FloatingActionButton(onPressed: _onPlusPress, child: Icon(Icons.add, color: Colors.white),),
            Text('请添加设备', style: TextStyle(color: Colors.blueGrey, fontSize: 14),)
          ],
        )
      ),
    );
  }
}