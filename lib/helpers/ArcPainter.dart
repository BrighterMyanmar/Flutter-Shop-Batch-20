import 'package:flutter/cupertino.dart';
import 'package:shop/utils/Cons.dart';
import 'dart:math' as math;

class ArcPainter extends CustomPainter {
  var mSize;

  ArcPainter(this.mSize);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Cons.secondary;

    final rect = Rect.fromLTRB(-850, 100, mSize.width, mSize.height + 550);

    final startAngle = -_degreeToRadian(100);
    final sweepAngle = _degreeToRadian(200);
    final useCenter = false;

    canvas.drawArc(rect, startAngle, sweepAngle, useCenter, paint);
  }

  _degreeToRadian(value) {
    return value * (math.pi / 180);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
