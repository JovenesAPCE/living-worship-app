import 'dart:ui';
import 'package:flutter/material.dart';

class BlurLoadingOverlay extends StatelessWidget {
  final String message;

  const BlurLoadingOverlay({super.key, this.message = 'Cargando...'});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Stack(
        children: [
          // Fondo difuminado
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0),
            child: Container(
              color: Colors.black.withOpacity(0.3),
            ),
          ),
          // Card con el indicador
          Center(
            child: Card(
              color: Colors.black.withOpacity(0.7),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      message,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}