import 'package:flutter/material.dart';
import 'package:jamt/constants/constants.dart';

class ZoomImageScreen extends StatelessWidget {
  final String imagePath;
  final String title;

  const ZoomImageScreen({
    super.key,
    required this.imagePath,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 24,
              color: Colors.white,
            fontFamily: AppFont.fontTwo
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: InteractiveViewer(
        panEnabled: true,
        minScale: 1.0,
        maxScale: 5.0,
        child: Center(
          child: Image.asset(imagePath),
        ),
      ),
    );
  }
}