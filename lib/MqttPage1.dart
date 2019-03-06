import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:utf/utf.dart';
import 'package:typed_data/typed_data.dart' as typed;

import 'package:cached_network_image/cached_network_image.dart';


class MqttPage extends StatefulWidget{

  @override
  State createState() {
    return MqttPageState();
  }

}

class MqttPageState extends State<MqttPage>{

  var message = '';
  var statusMessage = '';
  // var _topic = '/topic/sample';
  var _topic1 = 'pic';
  var _topic2 = 'dx';
  var _mqttUsername = 'qianguan';
  var _mqttPassword = 'qianguan@147258369';
  var imgAsset = 'images/scene1.png';
  MqttClient client = MqttClient('dx1023.com', 'dx1546');
  TextEditingController _controller = TextEditingController();

  String _base64;


  Uint8List bytes = base64.decode('iVBORw0KGgoAAAANSUhEUgAAADMAAAAzCAYAAAA6oTAqAAAAEXRFWHRTb2Z0d2FyZQBwbmdjcnVzaEB1SfMAAABQSURBVGje7dSxCQBACARB+2/ab8BEeQNhFi6WSYzYLYudDQYGBgYGBgYGBgYGBgYGBgZmcvDqYGBgmhivGQYGBgYGBgYGBgYGBgYGBgbmQw+P/eMrC5UTVAAAAABJRU5ErkJggg==');

  int flag = 0;
  int count = 0;

  @override
  void didUpdateWidget(MqttPage oldWidget) {
    print('didUpdateWidget');
  }

  @override
  void initState() {
    print('init state.');
    print('--connecting to server.');
    statusMessage = '--connect to server...';
    _connect().then((_){
      print('--connected.');
      //订阅
      _subscribe(_topic1);
      _subscribe(_topic2);

      setState(() {
        statusMessage += '\n--connected.';
      });
    }).catchError((e){
      setState(() {
        statusMessage += '\n--connection failed.';
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    client.disconnect();
    super.dispose();
  }

  Future _connect() async{
    // client.setProtocolV31();
    // client.useWebSocket = true;
    client.port = 8881;
    client.logging(false);
    client.keepAlivePeriod=20;
    client.onDisconnected = _onDisconnect;
    client.onSubscribed = _onSubscribed;
    // await client.connect(_mqttUsername, _mqttPassword);
    await client.connect();
  }

  _subscribe(String topic){
    var status = client.connectionState.toString();
    print('connectionState=$status');
    if(status != 'ConnectionState.connected'){
      _connect();
      return;
    }
    client.subscribe(topic, MqttQos.atMostOnce);
    client.updates.listen((List<MqttReceivedMessage> c) {
      // final MqttPublishMessage recMess = c[0].payload as MqttPublishMessage;

     MqttReceivedMessage myMessage = c[0] as MqttReceivedMessage;
     final MqttPublishMessage recMess = myMessage.payload as MqttPublishMessage;
     final String pt = MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

      String pt1 = decodeUtf8(recMess.payload.message);

      // String pt2 = decodeUtf8(c[0].payload); wrong

      if(c[0].topic == 'dx')
      {
        // String pt = decodeUtf8(recMess.payload.message);
        //print("message received, topic:${c[0].topic}, payload:${pt}");
        setState(() {
          message += '\n$pt1';
        });
      }
 
      else if(c[0].topic == 'pic')
      {
        // _base64 = base64.encode(recMess.payload.message);  wrong

        // String TT = MqttPublishPayload.bytesToStringAsString(recMess.payload.message);   

      //  _base64 = utf8.decode(recMess.payload.message);

           if(flag == 1)
           {
              flag = 0;
              
              _base64 = 'iVBORw0KGgoAAAANSUhEUgAAADMAAAAzCAYAAAA6oTAqAAAAEXRFWHRTb2Z0d2FyZQBwbmdjcnVzaEB1SfMAAABQSURBVGje7dSxCQBACARB+2/ab8BEeQNhFi6WSYzYLYudDQYGBgYGBgYGBgYGBgYGBgZmcvDqYGBgmhivGQYGBgYGBgYGBgYGBgYGBgbmQw+P/eMrC5UTVAAAAABJRU5ErkJggg==';  //十字
           }
           else if(flag ==0)
           {
             flag = 1;

              _base64 = 'iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAMAAAAoLQ9TAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAwBQTFRF7c5J78kt+/Xm78lQ6stH5LI36bQh6rcf7sQp671G89ZZ8c9V8c5U9+u27MhJ/Pjv9txf8uCx57c937Ay5L1n58Nb67si8tVZ5sA68tJX/Pfr7dF58tBG9d5e8+Gc6chN6LM+7spN1pos6rYs6L8+47hE7cNG6bQc9uFj7sMn4rc17cMx3atG8duj+O7B686H7cAl7cEm7sRM26cq/vz5/v767NFY7tJM78Yq8s8y3agt9dte6sVD/vz15bY59Nlb8txY9+y86LpA5LxL67pE7L5H05Ai2Z4m58Vz89RI7dKr+/XY8Ms68dx/6sZE7sRCzIEN0YwZ67wi6rk27L4k9NZB4rAz7L0j5rM66bMb682a5sJG6LEm3asy3q0w3q026sqC8cxJ6bYd685U5a457cIn7MBJ8tZW7c1I7c5K7cQ18Msu/v3678tQ3aMq7tNe6chu6rgg79VN8tNH8c0w57Q83akq7dBb9Nld9d5g6cdC8dyb675F/v327NB6////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA/LvB3QAAAMFJREFUeNpiqIcAbz0ogwFKm7GgCjgyZMihCLCkc0nkIAnIMVRw2UhDBGp5fcurGOyLfbhVtJwLdJkY8oscZCsFPBk5spiNaoTC4hnqk801Qi2zLQyD2NlcWWP5GepN5TOtSxg1QwrV01itpECG2kaLy3AYiCWxcRozQWyp9pNMDWePDI4QgVpbx5eo7a+mHFOqAxUQVeRhdrLjdFFQggqo5tqVeSS456UEQgWE4/RBboxyC4AKCEI9Wu9lUl8PEGAAV7NY4hyx8voAAAAASUVORK5CYII=';  //黄星
           }

        // var kk = base64.decode('/9j/4AAQSkZJRgABAgAAAQABAAD/2wBDAAgGBgcGBQgHBwcJCQgKDBQNDAsLDBkSEw8UHRofHh0aHBwgJC4nICIsIxwcKDcpLDAxNDQ0Hyc5PTgyPC4zNDL/2wBDAQkJCQwLDBgNDRgyIRwhMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjL/wAARCAEgAWADASIAAhEBAxEB/8QAHwAAAQUBAQEBAQEAAAAAAAAAAAECAwQFBgcICQoL/8QAtRAAAgEDAwIEAwUFBAQAAAF9AQIDAAQRBRIhMUEGE1FhByJxFDKBkaEII0KxwRVS0fAkM2JyggkKFhcYGRolJicoKSo0NTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uHi4+Tl5ufo6erx8vP09fb3+Pn6/8QAHwEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoL/8QAtREAAgECBAQDBAcFBAQAAQJ3AAECAxEEBSExBhJBUQdhcRMiMoEIFEKRobHBCSMzUvAVYnLRChYkNOEl8RcYGRomJygpKjU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6goOEhYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0tba3uLm6wsPExcbHyMnK0tPU1dbX2Nna4uPk5ebn6Onq8vP09fb3+Pn6/9oADAMBAAIRAxEAPwDw+ikpaACkpaKAEpaSigQtJRRQAtFFJQMKKKKACiiigAooooAKKKKACiiigAooozQAUUUUAFFFFAgooooGFFFFABRRRQAUUUUAFFFFABRRRQAUtJS0AFJS0UCCiiigYlFFFABRRRQAZoo');

        // print("topic:${utf8.decode(recMess.payload.message)}");
        // setState(() 
        // {
        //    _base64 = base64.encode(kk); 
        // });


        bytes = base64.decode(_base64);

        print('pic');

      }

    });
  }
//
//  Future<int> _connect() async{
//    print('connecting to server.');
//    statusMessage = '--connect to server...';
//    client.setProtocolV31();
//    client.port = 1883;
//    client.logging(false);
//    client.keepAlivePeriod = 20;
//    client.onDisconnected = _onDisconnect;
//    client.onSubscribed = _onSubscribed;
//
//    try {
//      await client.connect();
//      statusMessage += '\n--connected.';
//    } catch (e) {
//      print("EXAMPLE::client exception - $e");
//      statusMessage += '--connect failed.';
//      client.disconnect();
//    }
//
//    client.subscribe(_topic, MqttQos.atMostOnce);
//    client.updates.listen((List<MqttReceivedMessage> c) {
//      final MqttPublishMessage recMess = c[0].payload as MqttPublishMessage;
//      String pt = MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
//
//      /// The above may seem a little convoluted for users only interested in the
//      /// payload, some users however may be interested in the received publish message,
//      /// lets not constrain ourselves yet until the package has been in the wild
//      /// for a while.
//      /// The payload is a byte buffer, this will be specific to the topic
//      ///
//      print("message received, topic:${c[0].topic}, payload:${pt}");
//      print("");
//      setState(() {
//        message = pt;
//      });
//    });
//  }

  _onDisconnect(){
    print('--disconnected');
    setState(() {
      statusMessage += '\ndisconnected.';
    });
  }

  _onSubscribed(topic){
    print('--subscribed, topic=$topic');
    setState(() {
      statusMessage += '\n--subscribed, topic=$topic';
    });
  }

  _onSendButtonPress(){
    var message = _controller.text;
    print('text=$message');
    MqttClientPayloadBuilder builder = new MqttClientPayloadBuilder();
    var _buf = typed.Uint8Buffer();
    _buf.addAll(encodeUtf8(message));
    builder.addBuffer(_buf);
    client.publishMessage(_topic2, MqttQos.exactlyOnce, builder.payload);
    _controller.text = '';
  }

  @override
  Widget build(BuildContext context) {

    // Uint8List bytes = base64.decode('iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAMAAAAoLQ9TAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAwBQTFRF7c5J78kt+/Xm78lQ6stH5LI36bQh6rcf7sQp671G89ZZ8c9V8c5U9+u27MhJ/Pjv9txf8uCx57c937Ay5L1n58Nb67si8tVZ5sA68tJX/Pfr7dF58tBG9d5e8+Gc6chN6LM+7spN1pos6rYs6L8+47hE7cNG6bQc9uFj7sMn4rc17cMx3atG8duj+O7B686H7cAl7cEm7sRM26cq/vz5/v767NFY7tJM78Yq8s8y3agt9dte6sVD/vz15bY59Nlb8txY9+y86LpA5LxL67pE7L5H05Ai2Z4m58Vz89RI7dKr+/XY8Ms68dx/6sZE7sRCzIEN0YwZ67wi6rk27L4k9NZB4rAz7L0j5rM66bMb682a5sJG6LEm3asy3q0w3q026sqC8cxJ6bYd685U5a457cIn7MBJ8tZW7c1I7c5K7cQ18Msu/v3678tQ3aMq7tNe6chu6rgg79VN8tNH8c0w57Q83akq7dBb9Nld9d5g6cdC8dyb675F/v327NB6////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA/LvB3QAAAMFJREFUeNpiqIcAbz0ogwFKm7GgCjgyZMihCLCkc0nkIAnIMVRw2UhDBGp5fcurGOyLfbhVtJwLdJkY8oscZCsFPBk5spiNaoTC4hnqk801Qi2zLQyD2NlcWWP5GepN5TOtSxg1QwrV01itpECG2kaLy3AYiCWxcRozQWyp9pNMDWePDI4QgVpbx5eo7a+mHFOqAxUQVeRhdrLjdFFQggqo5tqVeSS456UEQgWE4/RBboxyC4AKCEI9Wu9lUl8PEGAAV7NY4hyx8voAAAAASUVORK5CYII=');



    return Scaffold(
      appBar: AppBar(title: Text('MQTT测试'),),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('收到消息:$message'),
          TextField(
            controller: _controller,
            decoration: InputDecoration(
              labelText: '发送内容'
            ),
          ),
          Center(
            child: RaisedButton(
                child: Text('发送'),
                onPressed: _onSendButtonPress
            ),
          ),
          Text('$statusMessage'),

          // new CachedNetworkImage(
          //   placeholder: new CircularProgressIndicator(),
          //   imageUrl:
          //       'https://raw.githubusercontent.com/xqwzts/flutter_sparkline/master/screenshots/example_line_gradient.png',
          
          // ),

          new Image.memory(bytes),
          
        ],
      ),
    );
  }

}