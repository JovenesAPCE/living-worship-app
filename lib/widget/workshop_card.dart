import 'package:flutter/material.dart';

class WorkshopCard extends StatelessWidget {
  final Color color;
  final String name;
  final String topic;
  final String topic2;
  final int capacity;
  final int available;
  final String description;

  const WorkshopCard({
    super.key,
    required this.color,
    required this.name,
    required this.topic,
    required this.topic2,
    required this.capacity,
    required this.description,
    required this.available
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: color
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.mic, size: 16, color: Colors.black),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      'Tema: $topic',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.gesture_outlined, size: 16, color: Colors.black),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      'Horario: $topic2',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.add_business, size: 16, color: Colors.black),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      'Aforo: $capacity',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.add_chart_sharp, size: 16, color: Colors.black),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      'Disponible: $available',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: const TextStyle(fontSize: 14, color: Colors.black87),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
