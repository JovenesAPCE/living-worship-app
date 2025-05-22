import 'package:flutter/material.dart';

extension HexColor on Color {
  String toHex({bool leadingHashSign = true}) {
    return '${leadingHashSign ? '#' : ''}'
        '${r.toInt().toRadixString(16).padLeft(2, '0')}'
        '${g.toInt().toRadixString(16).padLeft(2, '0')}'
        '${b.toInt().toRadixString(16).padLeft(2, '0')}';
  }
}