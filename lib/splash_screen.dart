import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(50),
        child: SafeArea(
          child: Center(
            child:
           Text("splash screen"),
          ),
        ),
      ),
    );
  }
}
