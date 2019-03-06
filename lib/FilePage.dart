import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';
import 'dart:math' show Random;
import 'package:path_provider/path_provider.dart';
class FilePage extends StatefulWidget{

  @override
  State createState() => FilePageState();
}

class FilePageState extends State<FilePage>{

  TextEditingController _filePathController = TextEditingController();
  TextEditingController _fileContentController = TextEditingController();
  List<FileSystemEntity> files = List<FileSystemEntity>();
  bool showDirectory = true;

  @override
  void initState() {
    _getAppRootDirectory();
  }


  @override
  void dispose() {
    _filePathController.dispose();
    _fileContentController.dispose();
    super.dispose();
  }

  _getAppRootDirectory(){
    getApplicationDocumentsDirectory().then((d){
      _readDirectory(d.path);
    });
  }

  //read directory
  _readDirectory(path){
    print('read directory:');
    showDirectory = true;
    Directory dir = Directory(path);

    files.clear();
    dir.list().forEach((f){
      print(f.path);
      files.add(f);
    });
    _filePathController.text = path;
    setState(() {

    });
  }

  //read file content
  _readFile(path){
    print('read file');
    showDirectory = false;
    String fileContent = File(path).readAsStringSync();
    _filePathController.text = path;
    _fileContentController.text = fileContent;
    setState(() {

    });
  }

  _saveFile(){
    File file = File(_filePathController.text);
    file.writeAsString(_fileContentController.text).then((f){
      print('file saved: $f.path');
      _back();
    });
  }

  //create a file with random name
  _writeRandFile() async{
    String root = (await getApplicationDocumentsDirectory()).path;
    final random = Random().nextInt(100);
    File file = new File('$root/$random');
    await file.writeAsString('hello flutter file write demo!!中文测试');
    _getAppRootDirectory();
  }

  _back(){
    _readDirectory(Directory(_filePathController.text).parent.path);
  }

  _enter(path){
    if(Directory(path).existsSync() == true){
      _readDirectory(path);
    }else{
      _readFile(path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('文件操作')),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ActionChip(onPressed: _getAppRootDirectory, label: Icon(Icons.home, color: Colors.blueGrey,), tooltip: '返回根目录',),
                      ActionChip(onPressed: _back, label: Icon(Icons.subdirectory_arrow_left, color: Colors.blueGrey), tooltip: '进入上层',),
                      ActionChip(onPressed: _getAppRootDirectory, label: Icon(Icons.reorder, color: Colors.blueGrey), tooltip: '读取根目录',),
                      !showDirectory? ActionChip(onPressed: _saveFile, label: Icon(Icons.save, color: Colors.blueGrey), tooltip: '保存文件',):
                      ActionChip(onPressed: _writeRandFile, label: Icon(Icons.create, color: Colors.blueGrey), tooltip: '创建随机文件',)
                    ],
                  ),
                  Row(children: <Widget>[
                    Expanded(child: TextField(controller: _filePathController, style: TextStyle(fontSize: 12, color: Colors.blueGrey),))
                  ],),
                ],
              ),
            ),
            Expanded(
              child: 
              showDirectory? 
              ListView.builder(
                  itemCount: files.length,
                  itemBuilder: (context, index){
                    String path = files[index].path;
                    bool isDirectory = Directory(path).existsSync();
                    String name = path.substring(path.lastIndexOf('/') + 1);
                    return ListTile(
                      title: Text(name, style: TextStyle(color: Colors.blueGrey, fontStyle: FontStyle.italic),),
                      leading: Icon(isDirectory? Icons.folder: Icons.filter_none),
                      onTap: (){
                        _enter(path);
                      },
                    );
                  }
              ) : 
              Container(
                padding: EdgeInsets.only(left: 8, right: 8),
                child: EditableText(controller: _fileContentController, focusNode: FocusNode(), style: TextStyle(color: Colors.blueGrey, fontSize: 12), cursorColor: Colors.blueGrey, maxLines: 65535,)
              )
            )
        ],)
    );
  }
}