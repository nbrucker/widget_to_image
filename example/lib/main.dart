import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:widget_to_image/widget_to_image.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Widget To Image',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  ByteData? _byteData;
  final GlobalKey _globalKey = GlobalKey();

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
    return RepaintBoundary(
      key: _globalKey,
      child: Scaffold(
          body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _callRepaintBoundaryToImage,
              child: const Text('Repaint Boundary To Image'),
            ),
            ElevatedButton(
              onPressed: _callWidgetToImage,
              child: const Text('Widget To Image'),
            ),
            if (_byteData != null)
              Container(
                height: 200,
                decoration: BoxDecoration(border: Border.all()),
                child: Image.memory(_byteData!.buffer.asUint8List()),
              )
            else
              Container()
          ],
        ),
      )),
    );
  }

  Future<void> _callRepaintBoundaryToImage() async {
    final byteData = await WidgetToImage.repaintBoundaryToImage(_globalKey);
    setState(() => _byteData = byteData);
  }

  Future<void> _callWidgetToImage() async {
    final byteData = await WidgetToImage.widgetToImage(Container(
      width: 100,
      height: 100,
      color: Colors.blue,
    ));
    setState(() => _byteData = byteData);
  }
}
