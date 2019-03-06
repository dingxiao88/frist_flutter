import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:utf/utf.dart';
import 'package:typed_data/typed_data.dart' as typed;

// import 'package:cached_network_image/cached_network_image.dart';


import 'dart:io';
import 'dart:ui';
import 'package:image/image.dart' as ok_image;

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:image_gallery_saver/image_gallery_saver.dart';


class MqttPage extends StatefulWidget{

  @override
  State createState() {
    return MqttPageState();
  }

}

class MqttPageState extends State<MqttPage>{

  var message = '';
  var statusMessage = '';
  var _topic1 = 'pic';
  var _topic2 = 'dx';
  var _mqttUsername = 'qianguan';
  var _mqttPassword = 'qianguan@147258369';
  MqttClient client = MqttClient('dx1023.com', 'dx1546');
  TextEditingController _controller = TextEditingController();

  int flag = 0;
  String _base64;
  Uint8List bytes = base64.decode('iVBORw0KGgoAAAANSUhEUgAAADMAAAAzCAYAAAA6oTAqAAAAEXRFWHRTb2Z0d2FyZQBwbmdjcnVzaEB1SfMAAABQSURBVGje7dSxCQBACARB+2/ab8BEeQNhFi6WSYzYLYudDQYGBgYGBgYGBgYGBgYGBgZmcvDqYGBgmhivGQYGBgYGBgYGBgYGBgYGBgbmQw+P/eMrC5UTVAAAAABJRU5ErkJggg==');

  int Cmd_FY_Value = 5;
  int Cmd_XH_Value = 5;


  Image cap_image;
  String Save_Image_Name = '/data/user/0/com.example.flutterapp/app_flutter/2019-02-27T07:42:44.242841Z.png';

  // var file_image = new File('/storage/emulated/0/DCIM/Camera/IMG_20171024_201036.jpg');

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
    //client.setProtocolV31();
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
      final MqttPublishMessage recMess = c[0].payload as MqttPublishMessage;
//      String pt = MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      String pt = decodeUtf8(recMess.payload.message);

      var pt2 = base64.encode(recMess.payload.message);

      //print("message received, topic:${c[0].topic}, payload:${pt}");

      if(c[0].topic == 'dx')
      {
        setState(() {
          message += '\n$pt';
        });
      }
      else if(c[0].topic == 'pic')
      {
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
    
          setState(() {
              bytes = base64.decode(pt2);
           });

         //print('${pt2}');
      }

    });
  }

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

  _onChangeButtonPress(){
    var text_change = _controller.text;
    var message = 'python3 /home/pi/Rec/pinyin_New.py -t ' + text_change + ' -n ok';
    print('text=$message');
    MqttClientPayloadBuilder builder = new MqttClientPayloadBuilder();
    var _buf = typed.Uint8Buffer();
    _buf.addAll(encodeUtf8(message));
    builder.addBuffer(_buf);
    client.publishMessage("change", MqttQos.exactlyOnce, builder.payload);
    _controller.text = '';
  }


  _onVoiceButtonPress(){
  var message = 'ok';
  print('text=$message');
  MqttClientPayloadBuilder builder = new MqttClientPayloadBuilder();
  var _buf = typed.Uint8Buffer();
  _buf.addAll(encodeUtf8(message));
  builder.addBuffer(_buf);
  client.publishMessage("voice", MqttQos.exactlyOnce, builder.payload);
  _controller.text = '';
  }

  _setFYUp()
  {
      Cmd_FY_Value =  Cmd_FY_Value + 1;
      if(Cmd_FY_Value >=9 )
      {
        Cmd_FY_Value = 9;
      }
      _onSendCmd();
  }
  _setFYDown()
  {
      Cmd_FY_Value =  Cmd_FY_Value - 1;
      if(Cmd_FY_Value <= 1 )
      {
        Cmd_FY_Value = 1;
      }
      _onSendCmd();
  }
  _setXHLeft()
  {
      Cmd_XH_Value =  Cmd_XH_Value - 1;
      if(Cmd_XH_Value <= 1 )
      {
        Cmd_XH_Value = 1;
      }
      _onSendCmd();
  }
  _setXHRight()
  {
      Cmd_XH_Value =  Cmd_XH_Value + 1;
      if(Cmd_XH_Value >=9 )
      {
        Cmd_XH_Value = 9;
      }
      _onSendCmd();
  }

  _onSendCmd(){

    var message = 'python /home/pi/Python/servo.py -f ${Cmd_FY_Value} -x ${Cmd_XH_Value}';
    
    MqttClientPayloadBuilder builder = new MqttClientPayloadBuilder();
    var _buf = typed.Uint8Buffer();
    _buf.addAll(encodeUtf8(message));
    builder.addBuffer(_buf);
    client.publishMessage('servo', MqttQos.exactlyOnce, builder.payload);

  }


  _saveimage() async
  {

      // final directory = await getApplicationDocumentsDirectory();
      // final recorder = new PictureRecorder();
      // final canvas = new Canvas(
      //     recorder,
      //     new Rect.fromPoints(
      //         new Offset(0.0, 0.0), new Offset(200.0, 200.0)));
      // final picture = recorder.endRecording();
      // final img = picture.toImage(200, 200);
      // final pngBytes = await img.toByteData(format: new EncodingFormat.png());

      //   File('your-path/filename.png')
      // .writeAsBytesSync(pngBytes.buffer.asInt8List());

      // final result = await ImageGallerySaver.save(bytes);

      // File('your-path/filename.png').writeAsBytesSync(bytes);

      // getApplicationDocumentsDirectory
      // final directory = await getExternalStorageDirectory();


      final directory = await getApplicationDocumentsDirectory();

      var path = await (directory.path);

      // var path = '/storage/emulated/0/DCIM/Camera';

      // Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_DCIM).getAbsolutePath();
      // new File(Environment.getExternalStorageDirectory(), "DCIM");

      var image_name = '$path/${DateTime.now().toUtc().toIso8601String()}.png';

      Save_Image_Name = image_name;

      print(image_name);

      new File(image_name)..writeAsBytesSync(bytes);  


      // final String state = Environment.getExternalStorageState(); 


  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text('监控测试'),),
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
            child: new Column(

              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,

              children: <Widget>[
                RaisedButton(
                    child: Text('发送'),
                    onPressed: _onChangeButtonPress
                ),

                Container(
                  child: cap_image =  Image.memory(bytes,fit: BoxFit.fill,),
                  width: 320.0,
                  height: 240.0,
                  color: Colors.lightBlue,
                ),

                new Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,

                  children:<Widget>[

                    Image.asset(Save_Image_Name,width: 150,height: 120,), 

                    IconButton(
                      icon: Icon(Icons.keyboard_arrow_left),
                      tooltip: '向左',
                      color: Colors.redAccent,
                      onPressed: _setXHLeft,
                    ),

                    new Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.keyboard_arrow_up),
                          tooltip: '向上',
                          color: Colors.redAccent,
                          onPressed: _setFYUp,
                        ),
                        IconButton(
                          icon: Icon(Icons.fiber_manual_record),
                          color: Colors.redAccent,
                          tooltip: '保存',
                          onPressed: _saveimage,
                        ),
                        IconButton(
                          icon: Icon(Icons.keyboard_arrow_down),
                          tooltip: '向下', 
                          color: Colors.redAccent,
                          onPressed: _setFYDown,
                        ),
                      ],

                    ),

                    IconButton(
                      icon: Icon(Icons.keyboard_arrow_right),
                      tooltip: '向右',
                      color: Colors.redAccent,
                      onPressed: _setXHRight,
                    ),

                    IconButton(
                      icon: Icon(Icons.voice_chat),
                      tooltip: '播放',
                      color: Colors.redAccent,
                      onPressed: _onVoiceButtonPress,
                    ),

                  ]
                ),


              ]
            )
          ),
          // Text('$statusMessage'),

        ],
      ),
    );
  }

}



// class SaveFile {

//   Future<String> get _localPath async {
//     final directory = await getApplicationDocumentsDirectory();

//     return directory.path;
//   }
//    Future<File> getImageFromNetwork(String url) async {

//      var cacheManager = await CacheManager.getInstance();
//      File file = await cacheManager.getFile(url);
//      return file;
//    }

//   //  Future<File> saveImage(String url) async {

//   //   final file = await getImageFromNetwork(url);
//   //   //retrieve local path for device
//   //   var path = await _localPath;
//   //   ok_image.Image image = ok_image.decodeImage(file.readAsBytesSync());

//   //   ok_image.Image thumbnail = ok_image.copyResize(image, 120);

//   //   // Save the thumbnail as a PNG.
//   //   return new File('$path/${DateTime.now().toUtc().toIso8601String()}.png')
//   //     ..writeAsBytesSync(ok_image.encodePng(thumbnail));
//   // }

//     saveImage(ok_image.Image cap_image) async {

//     // final file = await getImageFromNetwork(url);
//     // //retrieve local path for device
//     var path = await _localPath;
//     // ok_image.Image image = ok_image.decodeImage(file.readAsBytesSync());

//     ok_image.Image thumbnail = ok_image.copyResize(cap_image, 120);

//     // Save the thumbnail as a PNG.
//     new File('$path/${DateTime.now().toUtc().toIso8601String()}.png')
//       ..writeAsBytesSync(ok_image.encodePng(thumbnail));

//   }

// }


