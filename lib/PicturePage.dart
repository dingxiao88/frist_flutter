import 'package:flutter/material.dart';

class PicturePage extends StatefulWidget{

  @override
  State createState() {
    return PicturePageState();
  }
}

class PicturePageState extends State<PicturePage>{
  var fontStyle = TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.bold
  );
  var imgAsset = 'images/scene1.png';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('学习强国'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Image.asset(
              imgAsset, width: 300, height: 150,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,

              children: <Widget>[
                RaisedButton(
                  child: Text(
                    '图片1',
                    style: fontStyle,
                  ),
                  color: Colors.blueGrey,
                  onPressed: (){
                    setState(() {
                      imgAsset = '/data/user/0/com.example.flutterapp/app_flutter/2019-02-27T07:42:44.242841Z.png';
                    });
                  },
                ),
                RaisedButton(
                  child: Text(
                    '图片2',
                    style: fontStyle,
                  ),
                  color: Colors.blueGrey,
                  onPressed: (){
                    setState(() {
                      imgAsset = 'images/scene2.png';
                    });
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}