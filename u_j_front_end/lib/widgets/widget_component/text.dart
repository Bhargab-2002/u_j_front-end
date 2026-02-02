import 'package:flutter/material.dart';

Widget buildTextComponent(Map<String, dynamic> json) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Text(
      json['label'] ?? '',
      style: TextStyle(
        fontSize: (json['ui']?['fontSize'] ?? 16).toDouble(),
        fontWeight: json['ui']?['fontWeight'] == 'bold'
            ? FontWeight.bold
            : FontWeight.normal,
      ),
    ),
  );
}
