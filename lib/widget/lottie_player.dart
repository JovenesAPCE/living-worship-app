import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottiePlayer extends StatefulWidget {
  final String assetPath;
  final double speed; // 1.0 = normal, 0.5 = más lento, 2.0 = más rápido
  final bool repeat;
  final bool playToHalf;

  const LottiePlayer({
    super.key,
    required this.assetPath,
    this.speed = 1.0,
    this.repeat = false,
    this.playToHalf = false,
  });

  @override
  LottiePlayerState createState() => LottiePlayerState();
}

class LottiePlayerState extends State<LottiePlayer> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  int _playCount = 0;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      widget.assetPath,
      controller: _controller,
      onLoaded: (composition) {
        final duration = composition.duration * (1 / widget.speed);
        _controller.duration = duration;
        widget.repeat ? _controller.repeat() : _controller.forward();
        if(widget.repeat){
          if (widget.playToHalf) {
            _controller.addStatusListener((status) {
              if (status == AnimationStatus.completed) {
                _playCount++;
                if (_playCount == 1) {
                  // Segunda vez: reproducir hasta la mitad
                  _controller.value = 0.0;
                  _controller.animateTo(
                    0.5,
                    duration: duration * 0.45,
                    curve: Curves.decelerate, // 👈 detención suave
                  );
                }
              }
            });

            _controller.forward(); // Primera reproducción completa
          }
        }

      },
    );
  }
}