import 'package:flutter/material.dart';

class ListDemo extends StatelessWidget{
  var items = {
    '/layout':'Layout示例',
    '/picture':'图片切换',
    '/login':'登录表单',
    '/mqtt':'监控测试',
    '/file':'文件操作',
    'tab':'Tab示例',
    '/json':'JSON序列化',
    '/cap': '监控图片'
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flutter Demo')),
      body: ListView.builder(
          itemCount: items.length,
          itemBuilder:(context, index){
            return ListTile(
              title: Text(items.values.toList()[index]),
              trailing: Icon(
                Icons.chevron_right,
                color: Colors.blueGrey,
              ),
              leading: Icon(Icons.settings),
              onTap: (){_onListTap(context, items.keys.toList()[index]);},
            );
          }
      ),
    );
  }
  _onListTap(ctx, url){
    print('list tap, url=$url');
    Navigator.pushNamed(ctx, url);
  }
}
