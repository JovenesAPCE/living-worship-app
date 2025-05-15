import 'package:flutter/material.dart';

enum TimedMessageType { success, warning, error, info }

class TimedStatusMessage extends StatefulWidget {
  final String message;
  final TimedMessageType type;
  final Duration duration;
  final VoidCallback? onDismissed; // <-- callback opcional

  const TimedStatusMessage({
    super.key,
    required this.message,
    this.type = TimedMessageType.info,
    this.duration = const Duration(seconds: 10),
    this.onDismissed,
  });

  @override
  State<TimedStatusMessage> createState() => _TimedStatusMessageState();
}

class _TimedStatusMessageState extends State<TimedStatusMessage> {
  bool _visible = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(widget.duration, () {
      if (mounted) {
        setState(() {
          _visible = false;
        });
        if (mounted && widget.onDismissed != null) {
          widget.onDismissed!();
        }
      }
    });
  }

  Color get backgroundColor {
    switch (widget.type) {
      case TimedMessageType.success:
        return Colors.green.shade300;
      case TimedMessageType.warning:
        return Colors.amber.shade400;
      case TimedMessageType.error:
        return Colors.red.shade400;
      case TimedMessageType.info:
        return Colors.blue.shade400;
    }
  }

  IconData get icon {
    switch (widget.type) {
      case TimedMessageType.success:
        return Icons.check_circle;
      case TimedMessageType.warning:
        return Icons.warning;
      case TimedMessageType.error:
        return Icons.error;
      case TimedMessageType.info:
        return Icons.info;
    }
  }


  @override
  Widget build(BuildContext context) {
    if (!_visible) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                child: Row(
                  children: [
                    Icon(icon, color: Colors.white),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        widget.message,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: widget.duration,
                builder: (context, value, child) {
                  return LinearProgressIndicator(
                    value: value,
                    minHeight: 4,
                    backgroundColor: Colors.white.withOpacity(0.2),
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white.withOpacity(0.6)),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}