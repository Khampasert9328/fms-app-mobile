import 'package:flutter/material.dart';

class TextBetweenBold extends StatelessWidget {
  final String title;
  final String detail;
  const TextBetweenBold({super.key, required this.title, required this.detail});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("$title :", style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87)),
        Text("$detail :", style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87)),
      ],
    );
  }
}
