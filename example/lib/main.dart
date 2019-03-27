import 'package:flutter/material.dart';
import 'package:segment_control/segment_control.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
	// This widget is the root of your application.
	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			title: 'SegmentControl Demo',
			theme: ThemeData(
				primarySwatch: Colors.blue,
			),
			home: MyHomePage(title: 'SegmentControl Demo'),
		);
	}
}

class MyHomePage extends StatefulWidget  {
	MyHomePage({Key key, this.title}) : super(key: key);
	
	final String title;
	
	@override
	_MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
	
	bool selectNone = true;
	
	int selectedIndex = 0;
	String Str = "昨天";
	
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				// Here we take the value from the MyHomePage object that was created by
				// the App.build method, and use it to set our appbar title.
				title: Text(widget.title),
			),
			body: Center(
				// Center is a layout widget. It takes a single child and positions it
				// in the middle of the parent.
				child: Column(
					mainAxisAlignment: MainAxisAlignment.center,
					children: <Widget>[
						Text(
							'Style 1',
							style: TextStyle(
								fontSize: 20,
								fontWeight: FontWeight.w600
							),
						),
						
						SegmentControl(tabs: ["昨天", "今天", "明天"], width: 300, selected: (_i, _s) {
							selectedIndex = _i;
							Str = _s;
							setState(() {});
						}),
						Text("你选择了第$selectedIndex项,$Str"),
						Padding(padding: EdgeInsets.only(top:32)),
						Text(
							'Style 2',
							style: TextStyle(
								fontSize: 20,
								fontWeight: FontWeight.w600
							),
						),
						SegmentControl(
							tabs: ["yestoday", "today", "tomorrow"],
							width: 300,
							selected: (_i, _s) {},
							radius: 8,
							normalBackgroundColor: Colors.orange,
							activeBackgroundColor: Colors.green,
							borderColor: Colors.black,
							normalTitleStyle: TextStyle(fontSize: 14, color: Colors.cyan),
							activeTitleStyle: TextStyle(fontSize: 16, color: Colors.black),
						),
						Padding(padding: EdgeInsets.only(top:32)),
						Text(
							'Style selected none',
							style: TextStyle(
								fontSize: 20,
								fontWeight: FontWeight.w600
							),
						),
						SegmentControl(
							tabs: ["昨天", "今天", "明天"],
							width: 300,
							selectNone: selectNone,
							selected: (_i, _s) {},
						),
					],
				),
			),
		);
	}
}
