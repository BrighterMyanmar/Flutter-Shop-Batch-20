import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TrianglePainter extends CustomPainter {
  var mSize;

  TrianglePainter(this.mSize);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.pink;

    var upPath = Path();
    upPath.moveTo(mSize.width / 3, 0);
    upPath.lineTo(mSize.width, 0);
    upPath.lineTo(mSize.width, mSize.height / 3);

    var downPath = Path();
    downPath.moveTo(0, (mSize.height / 3) * 2);
    downPath.lineTo(0, mSize.height);
    downPath.lineTo((mSize.width / 4) * 3, mSize.height);

    canvas.drawPath(upPath, paint);
    canvas.drawPath(downPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
