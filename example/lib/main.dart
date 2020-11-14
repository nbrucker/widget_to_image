import 'package:flutter/material.dart';

import 'package:widget_to_image/widget_to_image.dart';

void main() {
	runApp(MyApp());
}

class MyApp extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			title: 'Widget To Image',
			home: MyHomePage(),
		);
	}
}

class MyHomePage extends StatefulWidget {
	const MyHomePage({
		Key key
	});

	@override
	MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
	Image _image;
	GlobalKey _globalKey = new GlobalKey();

	@override
	void initState() {
		super.initState();
	}

	@override
	void dispose() {
		super.dispose();
	}

	@override
	Widget build(BuildContext context) {
		return  RepaintBoundary(
			key: _globalKey,
			child: Scaffold(
				body: Center(
					child: Column(
						mainAxisAlignment: MainAxisAlignment.center,
						children: [
							RaisedButton(
								onPressed: _callRepaintBoundaryToImage,
								child: Text('Repaint Boundary To Image'),
							),
							RaisedButton(
								onPressed: _callWidgetToImage,
								child: Text('Widget To Image'),
							),
							_image != null ? Container(
								height: 200,
								decoration: BoxDecoration(
									border: Border.all(color: Colors.black)
								),
								child: _image,
							) : Container()
						],
					),
				)
			),
		);
	}

	_callRepaintBoundaryToImage() async {
		Image image = await WidgetToImage.repaintBoundaryToImage(this._globalKey);
		setState(() => _image = image);
	}

	_callWidgetToImage() async {
		Image image = await WidgetToImage.widgetToImage(Container(
			width: 100,
			height: 100,
			color: Colors.blue,
		));
		setState(() => _image = image);
	}
}
