import 'package:flutter/material.dart';

enum Severity { high, medium, low }

class AlertItem {
  final String title;
  final String description;
  final String time;
  final String node;
  final Severity severity;
  final IconData icon;

  const AlertItem({
    required this.title,
    required this.description,
    required this.time,
    required this.node,
    required this.severity,
    required this.icon,
  });
}

class NodeInfo {
  final String name;
  final String code;
  final IconData icon;
  final Color color;
  final Color background;
  final bool online;
  final List<String> sensors;

  const NodeInfo({
    required this.name,
    required this.code,
    required this.icon,
    required this.color,
    required this.background,
    required this.online,
    required this.sensors,
  });
}
