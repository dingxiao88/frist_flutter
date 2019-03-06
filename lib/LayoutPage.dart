import 'package:flutter/material.dart';
class LayoutPage extends StatelessWidget{

  Widget _buildButton(IconData icon, String text){
    Column col = Column(
      children: <Widget>[
        Icon(icon, color: Colors.blueGrey),
        Container(
          padding: EdgeInsets.only(top: 8),
          child: Text(text, style: TextStyle(color: Colors.blueGrey)),
        )
      ],
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
    );
    return col;
  }

  Widget _buildComment(String icon, String name, String time, String text){
    Row row = Row(
      children: <Widget>[
        Container(
            child: Image.asset(icon, width: 50, height: 50,),
            padding: EdgeInsets.only(top: 8, right: 9, bottom: 8)
        ),
        Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(name, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey, fontSize: 14)),
                    Text(' $time', style: TextStyle(color: Colors.black26, fontSize: 12))
                  ],
                ),
                Container(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Text(text)
                )
              ],
            )
        ),
      ],
    );
    return row;
  }
  
  @override
  Widget build(BuildContext context) {
    //1> title section
    Container titleSection = Container(
      padding: EdgeInsets.all(30),
      child: Row(
        children: <Widget>[
          Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Text('Oeschinen Lake Campground', style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold, fontSize: 16))
                  ),
                  Text('Kandersteg, Switzerland', style: TextStyle(color: Colors.blueGrey))
                ],
              ),
          ),
          Icon(
            Icons.star_border,
            color: Colors.redAccent,
          ),
          Text('59')
        ],
      ),
    );

    //2> buttons section
    Row buttonSection = Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        _buildButton(Icons.call, 'CALL'),
        _buildButton(Icons.near_me, 'ROUTE'),
        _buildButton(Icons.share, 'SHARE')
      ],
    );

    //3> article section
    String article = 'Lake Oeschinen lies at the foot of the Bluemlisalp in the Bernese Alps. Situated 1,578 meters above sea level, it is one of the larger Alpine Lakes. A gondala ride from Kandersteg, followed by a half-hour walk through pasture and pine forest, leads you to the lake, which warms to 20 degress Celsius in the summer. Activities enjoyed here include rowing, and riding the summer toboggan run.Lake Oeschinen lies at the foot of the Bluemlisalp in the Bernese Alps. Situated 1,578 meters above sea level, it is one of the larger Alpine Lakes. A gondala ride from Kandersteg, followed by a half-hour walk through pasture and pine forest, leads you to the lake, which warms to 20 degress Celsius in the summer. Activities enjoyed here include rowing, and riding the summer toboggan run.';
    Container textSection = Container(
      padding: EdgeInsets.all(30),
      child: Text(
        article,
        style: TextStyle(color: Colors.blueGrey, fontSize: 15),
        softWrap: true,
      ),
    );

    //4> comments section
    Container commentSection = Container(
      padding: EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(bottom: 8),
            child: Text('Comments', style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold, fontSize: 16)),
          ),
          _buildComment('images/default.png', 'David', '2018/05/15 13:06', 'I fucking like this place.'),
          _buildComment('images/default.png', 'Crash.Willam', '2018/03/15 09:05', 'I have been there twice, and I really hope to back, really great!!!.'),
        ],
      )
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Layout Demo'),
      ),
      body: ListView(
        children: <Widget>[
          Image.asset('images/scene2.png', fit: BoxFit.fitWidth,),
          titleSection,
          buttonSection,
          textSection,
          commentSection
        ],
      ),
    );
  }
}