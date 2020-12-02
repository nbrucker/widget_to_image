import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;

class WidgetToImage {
	static Future<ByteData> repaintBoundaryToImage(GlobalKey key, {double pixelRatio = 1.0}) {
		return new Future.delayed(const Duration(milliseconds: 20), () async {
			RenderRepaintBoundary repaintBoundary = key.currentContext.findRenderObject();

			ui.Image image = await repaintBoundary.toImage(pixelRatio: pixelRatio);
			ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);

			return byteData;
		});
	}

	static Future<ByteData> widgetToImage(Widget widget, {double pixelRatio = 1.0}) async {
		RenderRepaintBoundary repaintBoundary = RenderRepaintBoundary();

		RenderView renderView = RenderView(
			child: RenderPositionedBox(alignment: Alignment.center, child: repaintBoundary),
			configuration: ViewConfiguration(
				size: Size(double.maxFinite, double.maxFinite),
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
		buildOwner.finalizeTree();

		pipelineOwner.flushLayout();
		pipelineOwner.flushCompositingBits();
		pipelineOwner.flushPaint();

		ui.Image image = await repaintBoundary.toImage(pixelRatio: pixelRatio);
		ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);

		return byteData;
	}
}
