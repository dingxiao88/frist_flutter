import 'package:flutter/material.dart';
class LoginPage extends StatefulWidget{
  @override
  State createState() {
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage>{
  var usernameCtl = TextEditingController();
  var passwordCtl = TextEditingController();
  var fontStyle = TextStyle(
      color: Colors.blueGrey,
      fontSize: 16,
      fontWeight: FontWeight.bold
  );
  _onLoginButtonPress(){
    print('登录');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('登录表单')),
      body: Form(
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 70,
                child: TextField(
                  controller: usernameCtl,
                  style: fontStyle,
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      labelText: '用户名：'
                  ),
                ),
              ),
              SizedBox(
                height: 70,
                child: TextField(
                  controller: passwordCtl,
                  style: fontStyle,
                  keyboardType: TextInputType.numberWithOptions(),
                  obscureText: true,
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      labelText: '密码：'
                  ),
                ),
              ),
              SizedBox(
                height: 50,
                child: Center(
                  child: RaisedButton(
                      child: Text('登录', style: TextStyle(color: Colors.white),),
                      color: Colors.blueGrey,
                      onPressed: _onLoginButtonPress
                  ),
                ),
              )
            ],
          )
      ),
    );
  }
}