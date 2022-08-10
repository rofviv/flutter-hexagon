import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'hexagon_path_builder.dart';

/// This class is responsible for painting HexagonWidget color and shadow in proper shape.
class HexagonPainter extends CustomPainter {
  HexagonPainter(this.pathBuilder, {this.color, this.elevation});

  final HexagonPathBuilder pathBuilder;
  final double elevation;
  final Color color;

  final Paint _paint = Paint();
  Path _path;

  @override
  void paint(Canvas canvas, Size size) {
    // _paint.color = color ?? Colors.white;
    _paint.shader = ui.Gradient.linear(
    size.topLeft(ui.Offset(1,1)),
    size.bottomRight(ui.Offset(1,1)),
    [
       Color(0xFFc9284f),
      Color(0xFfff6666),
      // Color(0xFFFFb072),
    ],
  );
    // _paint.isAntiAlias = true;
    // _paint.style = PaintingStyle.fill;

    _path = pathBuilder.build(size);

    if ((elevation ?? 0) > 0)
      canvas.drawShadow(_path, Colors.black, elevation ?? 0, false);
    canvas.drawPath(_path, _paint);
  }

  @override
  bool hitTest(Offset position) {
    return _path?.contains(position) ?? false;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HexagonPainter &&
          runtimeType == other.runtimeType &&
          pathBuilder == other.pathBuilder &&
          elevation == other.elevation &&
          color == other.color;

  @override
  int get hashCode =>
      pathBuilder.hashCode ^ elevation.hashCode ^ color.hashCode;
}
