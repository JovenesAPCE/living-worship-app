import 'package:flutter/material.dart';
import 'package:jamt/constants/constants.dart';

enum ProgressType { loading, success, error }

typedef ProgressStatusCallback = void Function();

class ProgressStatus extends StatelessWidget {
  final String message;
  final ProgressType type;
  final ProgressStatusCallback onRefreshPressed;
  const ProgressStatus({
    super.key,
    required this.message,
    required this.type,
    required this.onRefreshPressed
  });

  @override
  Widget build(BuildContext context) {
    Widget progress;
    switch (type) {
      case ProgressType.loading:
        progress = const CircularProgressIndicator(color: Colors.orange);
        break;
      case ProgressType.success:
        progress = const CircularProgressIndicator(color: Colors.green);
        break;
      case ProgressType.error:
        progress = const CircularProgressIndicator(color: Colors.red);
        break;
    }

    return Container(
      padding: EdgeInsets.only(
        left: 32,
        right: 32
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if(type != ProgressType.error)
            Padding(
              padding: EdgeInsets.all(24),
              child: progress,
            ),
          if(type == ProgressType.error)
            Padding(padding: EdgeInsets.all(12)),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
          ),
          if(type == ProgressType.error)
            Padding(
              padding: EdgeInsets.only(
                  top: 12
              ),
              child: ElevatedButton.icon(
                onPressed: () {
                  onRefreshPressed.call();
                },
                icon: const Icon(Icons.refresh),
                label: const Text('Reintentar'),
              ),
            )

        ],
      ),
    );
  }
}