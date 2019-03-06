import 'package:flutter/material.dart';
import 'dart:convert';
import 'model/user.dart';

class JsonPage extends StatefulWidget{
  @override
  State createState() => JsonPageState();
}

class JsonPageState extends State<JsonPage>{
  var result;

  @override
  void initState() {

  }

  _decode(){
    final String json = '{"name": "flutter", "desc": "great tool!"}';
    Map<String, dynamic> obj = jsonDecode(json);
    print(obj);
    setState(() {
      result = obj.toString();
    });
  }

  _encode(){
    Map<String, dynamic> obj = Map<String, dynamic>();
    obj['name'] = 'Dart';
    obj['range'] = 1;
    String json = jsonEncode(obj);
    print(json);
    setState(() {
      result = json;
    });
  }

  _decodeAuto(){
    final String tmp = '{"name": "flutter", "email": "824783146@qq.com"}';
    Map<String, dynamic> json = jsonDecode(tmp);
    User user = User.fromJson(json);
    print(user);
    setState(() {
      result = user.toString();
    });
  }

  _encodeAuto(){
    User user = User('JsonSerializable', '824783146@qq.com');
    Map<String, dynamic> json = user.toJson();
    setState(() {
      result = jsonEncode(json);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('JSON序列化'),),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('结果：$result'),
          Text('手动序列化示例'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              RaisedButton(
                  child: Text('序列化'),
                  onPressed: _encode
              ),
              RaisedButton(
                  child: Text('反序列化'),
                  onPressed: _decode
              ),
            ],
          ),
          Text('@JsonSerializable示例'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              RaisedButton(
                  child: Text('序列化'),
                  onPressed: _encodeAuto
              ),
              RaisedButton(
                  child: Text('反序列化'),
                  onPressed: _decodeAuto
              ),
            ],
          ),
        ],
      )


    );
  }
}