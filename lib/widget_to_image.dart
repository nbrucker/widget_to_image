import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;

class WidgetToImage {
	static Future<Image> widgetToImage(Widget widget) async {
		RenderRepaintBoundary repaintBoundary = RenderRepaintBoundary();

		RenderView renderView = RenderView(
			child: RenderPositionedBox(alignment: Alignment.center, child: repaintBoundary),
			configuration: ViewConfiguration(
				size: ui.window.physicalSize / ui.window.devicePixelRatio,
				devicePixelRatio: 1.0,
			),
			window: null
		);

		PipelineOwner pipelineOwner = PipelineOwner();
		pipelineOwner.rootNode = renderView;
		renderView.prepareInitialFrame();

		BuildOwner buildOwner = BuildOwner();
		RenderObjectToWidgetElement rootElement = RenderObjectToWidgetAdapter(
			container: repaintBoundary,
			child: widget,
		).attachToRenderTree(buildOwner);
		buildOwner.buildScope(rootElement);
		buildOwner.buildScope(rootElement);
		buildOwner.finalizeTree();

		pipelineOwner.flushLayout();
		pipelineOwner.flushCompositingBits();
		pipelineOwner.flushPaint();

		ui.Image image = await repaintBoundary.toImage(pixelRatio: 1.0);
		ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);

		return Image.memory(byteData.buffer.asUint8List());
	}
}
