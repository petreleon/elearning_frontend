import 'package:flutter/material.dart';

Color getLevelColor(String level) {
  switch (level) {
    case 'Beginner':
      return Colors.green;
    case 'Intermediate':
      return Colors.orange;
    case 'Advanced':
      return Colors.red;
    default:
      return Colors.grey;
  }
}
