import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'PicturePage.dart';
import 'LoginPage.dart';
import 'MqttPage.dart';
import 'LayoutPage.dart';
import 'FilePage.dart';
import 'TabPage.dart';
import 'JsonPage.dart';
import 'CapPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
	// This widget is the root of your application.
	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			title: 'DX',
			theme: ThemeData(
				// This is the theme of your application.
				//
				// Try running your application with "flutter run". You'll see the
				// application has a blue toolbar. Then, without quitting the app, try
				// changing the primarySwatch below to Colors.green and then invoke
				// "hot reload" (press "r" in the console where you ran "flutter run",
				// or simply save your changes to "hot reload" in a Flutter IDE).
				// Notice that the counter didn't reset back to zero; the application
				// is not restarted.
				primarySwatch: Colors.blueGrey,
			),
			home: ListDemo(),
				routes: <String, WidgetBuilder>{
					'/picture': (context) => PicturePage(),
					'/login': (context) => LoginPage(),
					'/mqtt': (context) => MqttPage(),
					'/layout': (context) => LayoutPage(),
					'/file': (context) => FilePage(),
					'/tab': (context) => TabPage(),
					'/json': (context) => JsonPage(),
          '/cap' : (context) => CapPage(),
				}
		);
	}

}

