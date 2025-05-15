import 'dart:math';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_animate/flutter_animate.dart';


class ZoomImageCarousel extends StatelessWidget {

  final List<String> images;

  ZoomImageCarousel({
    super.key,
    required this.images});

  final Random random = Random();

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: images.length,
      itemBuilder: (context, index, realIdx) {
        double zoomFactor = 1.0 + random.nextDouble() * 0.5; // entre 1.0 y 1.5

        return Animate(
          effects: [
            ScaleEffect(
              begin: Offset(1, 1),
              end: Offset(zoomFactor, zoomFactor),
              duration: 8.seconds,
              curve: Curves.easeInOut,
              delay: 0.ms,
            ),
          ],
          child:  Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(images[index]),
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
      options: CarouselOptions(
        height: 400,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 10),
        viewportFraction: 1.0,
        enlargeCenterPage: false,
      ),
    );
  }
}