import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Create a Paint object {Cascade Operator (..) is used to call multiple methods on the same object}
    final paint = Paint()..color = Colors.red;

    // Draw the icon onto the canvas
    final icon = Icon(
      FontAwesomeIcons.marker,
      size: size.width, // Use the size provided by the CustomPainter
      color: Colors.red,
    );

    // Create a PictureRecorder to record the drawing
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    //icon.paint(canvas, Size(size.width, size.height));

    // End recording and get the picture
    final picture = recorder.endRecording();

    // Draw the picture on the main canvas
    canvas.drawPicture(picture);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false; // No need to repaint unless there are changes
  }
}
