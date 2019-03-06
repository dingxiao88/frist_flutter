import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';
import 'package:path_provider/path_provider.dart';



class CapPage extends StatefulWidget{

  @override
  State createState() {
    return CapPageState();
  }

}


class CapPageState extends State<CapPage>
{
    int Image_count = 0;
    List<String> image_list = new List();
    var image_conten;

    //@1-初始化
    @override
    void initState()
    {
      _getLocalFile();
    }


    //@2-获得图片信息
    _getLocalFile() async {

      //@-获取应用目录
      String dir = (await getApplicationDocumentsDirectory()).path;
      var dir_temp = Directory(dir);
      //@-获取目录列表
      var list = dir_temp.list();

      //@-等待完成png格式图片目录获取
      await list.forEach((fs){
          if(fs.path.endsWith('png'))
          {
            Image_count = Image_count + 1;
            image_list.add(fs.path);
          }
      });

      //@-图片内容获取
      image_conten = new Container(

  

        child: GridView.builder(

          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 2.0,
          crossAxisSpacing: 2.0,
          childAspectRatio: 0.7,
          ),

          itemCount: Image_count,

          itemBuilder: (context,index){
            return Image.asset(image_list[index],fit: BoxFit.cover,);
          },

        )
      );

      //@-刷新图片列表
      setState(() {

          image_conten;
      
      });
  }

  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
        title: '监控图片',
        home: Scaffold(
          appBar: new AppBar(title: new Text('监控图片' + Image_count.toString() + '张'),),
          body: image_conten,
        ),
      );
  }

  
}