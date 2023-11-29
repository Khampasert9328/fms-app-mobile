import 'package:flutter/material.dart';

class SuccessHRLeave extends StatefulWidget {
  const SuccessHRLeave({super.key});

  @override
  State<SuccessHRLeave> createState() => _SuccessHRLeaveState();
}

class _SuccessHRLeaveState extends State<SuccessHRLeave> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("success hr "),
      ),
    );
  }
}