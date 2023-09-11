import 'dart:async';

import 'package:flutter/material.dart';

class Loading extends StatefulWidget {
  final dynamic then;
  Loading({required this.then});
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<Loading> {
  @override
  void initState() {
    super.initState();
    // Add a delay of 5 seconds using a Timer
    Timer(Duration(seconds: 5), () {
      // After the delay, navigate to your desired screen
      widget.then;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
