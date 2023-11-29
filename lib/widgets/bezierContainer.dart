// ignore_for_file: prefer_const_constructors, duplicate_ignore

import 'dart:math';

import 'package:flutter/material.dart';

import 'customClipper.dart';

class BezierContainer extends StatelessWidget {
  const BezierContainer({Key ?key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Container(
      child: Transform.rotate(
        angle: -pi / 3.5, 
        child: ClipPath(
        clipper: ClipPainter(),
        child: Container(
          height: MediaQuery.of(context).size.height *.5,
          width: MediaQuery.of(context).size.width,
          // ignore: prefer_const_constructors, duplicate_ignore
          decoration: BoxDecoration(
              // ignore: prefer_const_constructors
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                // ignore: prefer_const_literals_to_create_immutables
                colors: [Color(0xff1C9A7F),Color(0xff1C9A7F)]
              )
            ),
        ),
      ),
      )
    );
  }
}