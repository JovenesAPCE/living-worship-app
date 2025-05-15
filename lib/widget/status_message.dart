import 'package:flutter/material.dart';

enum MessageType { success, warning, error, info }

class StatusMessage extends StatelessWidget {
  final String text;
  final MessageType type;

  const StatusMessage({
    super.key,
    required this.text,
    this.type = MessageType.info,
  });

  Color get backgroundColor {
    switch (type) {
      case MessageType.success:
        return Colors.green.shade300;
      case MessageType.warning:
        return Colors.amber.shade400;
      case MessageType.error:
        return Colors.red.shade400;
      case MessageType.info:
        return Colors.blue.shade400;
    }
  }

  IconData get icon {
    switch (type) {
      case MessageType.success:
        return Icons.check_circle;
      case MessageType.warning:
        return Icons.warning;
      case MessageType.error:
        return Icons.error;
      case MessageType.info:
        return Icons.info;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}