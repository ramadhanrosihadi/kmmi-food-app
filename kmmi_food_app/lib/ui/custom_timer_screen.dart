import 'dart:async';

import 'package:flutter/material.dart';

class CustomTimerScreen extends StatefulWidget {
  const CustomTimerScreen({Key? key}) : super(key: key);

  @override
  _CustomTimerScreenState createState() => _CustomTimerScreenState();
}

class _CustomTimerScreenState extends State<CustomTimerScreen> {
  int second = 0;
  @override
  void initState() {
    super.initState();
    runTimer();
  }

  void runTimer() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        second = timer.tick;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("$second seconds"),
      ),
    );
  }
}
