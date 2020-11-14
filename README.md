# Widget To Image
[![pub package](https://img.shields.io/pub/v/dart_jsonwebtoken.svg)](https://pub.dev/packages/widget_to_image)

A simple package to convert any of your widgets into an image

## Usage

### Import the package
```dart
import 'package:widget_to_image/widget_to_image.dart';
```

### Use the package

```dart
Image image = await WidgetToImage.widgetToImage(Container(
    width: 100,
    height: 100,
    color: Colors.blue
));
```

## Example

Find the example wiring in the [Widget_to_image example application](https://github.com/nbrucker/widget_to_image/tree/main/example/lib/main.dart).

## Details

See the [widget_to_image.dart](https://github.com/nbrucker/widget_to_image/blob/main/lib/widget_to_image.dart) for more details.

## Issues and feedback

Please file [issues](https://github.com/nbrucker/widget_to_image/issues/new)
to send feedback or report a bug. Thank you!