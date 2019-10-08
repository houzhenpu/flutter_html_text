import 'dart:ui' as ui;

import 'package:flutter/material.dart';

/// 图片裁剪
class ImageClipper extends CustomPainter {
  final ui.Image image;
  final double left;
  final double top;
  final double right;
  final double bottom;
  final BuildContext context;

  ImageClipper(this.image, this.context,
      {this.left = 0.3, this.top = 0.3, this.right = 0.6, this.bottom = 0.6});

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    Paint paint = Paint();
    canvas.drawImageRect(
        image,
        Rect.fromLTRB(
            left,
            top,
            image.width * 1.0,
            MediaQuery.of(context).size.height *
                (image.width * 1.0 / MediaQuery.of(context).size.width)),
        Rect.fromLTWH(0, 0, size.width, size.height),
        paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}
