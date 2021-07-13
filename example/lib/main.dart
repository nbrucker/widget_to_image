import 'package:flutter/material.dart';
import 'dart:typed_data';

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
		Key? key
	}) : super(key: key);

	@override
	MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
	ByteData? _byteData;
	GlobalKey _globalKey = GlobalKey();

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
							ElevatedButton(
								onPressed: _callRepaintBoundaryToImage,
								child: Text('Repaint Boundary To Image'),
							),
							ElevatedButton(
								onPressed: _callWidgetToImage,
								child: Text('Widget To Image'),
							),
							_byteData != null ? Container(
								height: 200,
								decoration: BoxDecoration(
									border: Border.all(color: Colors.black)
								),
								child: Image.memory(
									_byteData!.buffer.asUint8List()
								),
							) : Container()
						],
					),
				)
			),
		);
	}

	_callRepaintBoundaryToImage() async {
		ByteData byteData = await WidgetToImage.repaintBoundaryToImage(this._globalKey);
		setState(() => _byteData = byteData);
	}

	_callWidgetToImage() async {
		ByteData byteData = await WidgetToImage.widgetToImage(Container(
			width: 100,
			height: 100,
			color: Colors.blue,
		));
		setState(() => _byteData = byteData);
	}
}
