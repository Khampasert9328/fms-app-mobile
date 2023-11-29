import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SuccessLeadLeft extends StatefulWidget {
  const SuccessLeadLeft({super.key});

  @override
  State<SuccessLeadLeft> createState() => _SuccessLeadLeftState();
}

class _SuccessLeadLeftState extends State<SuccessLeadLeft> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("success Lead Left"),),
    );
  }
}