import 'package:flutter/material.dart';

import 'package:widget_to_image/widget_to_image.dart';

void main() async {
	WidgetsFlutterBinding.ensureInitialized();
	Image image = await WidgetToImage.widgetToImage(Container(
		width: 100,
		height: 100,
		color: Colors.blue
	));
}
