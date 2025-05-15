import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottiePause extends StatefulWidget {
  final String lottiePath;
  final double progress;
  final double width;

  const LottiePause({
    super.key,
    required this.lottiePath,
    required this.progress,
    required this.width
  });

  @override
  LottiePauseState createState() => LottiePauseState();
}

class LottiePauseState extends State<LottiePause> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isGrey = true;

  void start() {
    setState(() {
      _isGrey = false;
    });
    _controller.forward(from: widget.progress);
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this);

    // Espera a que la animación se cargue para pausar en un frame
    _controller.addListener(() {
      // Pausa en el frame equivalente al 50% del progreso
      if (_controller.value >= widget.progress) {
        _controller.stop();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lottieWidget = Lottie.asset(
      widget.lottiePath,
      controller: _controller,
      width: widget.width,
      onLoaded: (composition) {
        _controller.duration = composition.duration;
        _controller.value = widget.progress;
      },
    );

    return _isGrey
        ? ColorFiltered(
      colorFilter: const ColorFilter.matrix([
        0.2126, 0.7152, 0.0722, 0, 0, // R
        0.2126, 0.7152, 0.0722, 0, 0, // G
        0.2126, 0.7152, 0.0722, 0, 0, // B
        0, 0, 0, 1, 0, // A
      ]),
      child: lottieWidget,
    )
        : lottieWidget;
  }
}