import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class SessionCard extends Equatable {
  final String id;
  final Color color;
  final String title;
  final String topic;
  final String topic2;
  final int capacity;
  final String description;
  final int available;
  final List<SessionCard> guests;

  const SessionCard({required this.id, this.color = Colors.white70, this.title = "", this.topic = "", this.topic2 = "", this.description = "", this.guests = const [], this.capacity = 0, this.available = 0});

  @override
  List<Object?> get props => [title, guests, description, guests, color, topic, topic2, capacity, available];

  SessionCard copyWith({
    String? id,
    Color? color,
    String? title,
    String? topic,
    String? topic2,
    int? capacity,
    int? available,
    String? description,
    List<SessionCard>? guests,
  }){
    return SessionCard(
        id: id??this.id,
        color: color??this.color,
        title: title??this.title,
        topic: topic??this.topic,
      topic2: topic2??this.topic2,
      capacity: capacity??this.capacity,
      description: description??this.description,
      guests: guests??this.guests,
        available: available??this.available
    );
  }
}