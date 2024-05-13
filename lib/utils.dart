import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

Future<Color> extractColorFromBottom(
    Uint8List imageBuffer, int width, int height,
    {double bottomPercentage = 0.2}) async {
  final Completer<Color> completer = Completer();
  final int bottomHeight = (height * bottomPercentage).toInt();

  final int bottomIndex = (height - bottomHeight) * width * 4;
  final List<int> bottomImageBuffer = imageBuffer.sublist(bottomIndex);

  final ui.Codec codec =
      await ui.instantiateImageCodec(Uint8List.fromList(bottomImageBuffer));
  final ui.FrameInfo frameInfo = await codec.getNextFrame();
  final ui.Image image = frameInfo.image;

  final PaletteGenerator paletteGenerator =
      await PaletteGenerator.fromImage(image, maximumColorCount: 20);

  completer.complete(paletteGenerator.dominantColor!.color);

  return completer.future;
}

Future<ui.Image> imageFromImageBuffer(
    Uint8List imageBuffer, int width, int height) async {
  final Completer<ui.Image> completer = Completer();
  final Uint8List encodedImage = Uint8List.fromList(imageBuffer);
  final ui.Codec codec = await ui.instantiateImageCodec(encodedImage);

  // Decodificar la imagen
  final ui.FrameInfo frameInfo = await codec.getNextFrame();
  completer.complete(frameInfo.image);

  return completer.future;
}

bool isColorTooLight(Color color, {double threshold = 0.5}) {
  double luminance = color.computeLuminance();
  print(
      luminance > threshold ? 'Color is too light' : 'Color is not too light');
  return luminance > threshold;
}
