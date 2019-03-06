import 'package:flutter/material.dart';
class TabMy extends StatefulWidget{

  @override
  State createState() => TabMyState();
}

class TabMyState extends State<TabMy>{

  @override
  void initState() {

  }

  _onSign(){

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('个人中心'),
        actions: <Widget>[
          FlatButton(onPressed: _onSign, child: Text('签到', style: TextStyle(color: Colors.white),))
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: <Widget>[
                Image.asset('images/scene2.png', fit: BoxFit.fitWidth,),
                Column(
                  children: <Widget>[
                    Image.asset('images/default.png', width: 60, height: 60,),
                    Text('湖南千贯能源科技', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),),
                  ],
                )
              ],
            ),
          ),
          ListTile(
            title: Text('个人资料'),
            leading: Icon(Icons.home),
            trailing: Icon(Icons.chevron_right),
          ),
          ListTile(
            title: Text('用电报告'),
            leading: Icon(Icons.insert_drive_file),
            trailing: Icon(Icons.chevron_right),
          ),
          ListTile(
            title: Text('设置'),
            leading: Icon(Icons.settings),
            trailing: Icon(Icons.chevron_right),
          )
        ],
      )
    );
  }
}