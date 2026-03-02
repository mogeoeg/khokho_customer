// ignore_for_file: file_names

import 'package:flutter/material.dart';

class TTrackDetailColumn extends StatelessWidget {
  final String info;
  final String topic;

  const TTrackDetailColumn({
    super.key,
    required this.info,
    required this.topic,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          info,
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
        ),
        Text(
          topic,
          style: TextStyle(
            fontWeight: FontWeight.normal,
            color: Colors.black54,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}


