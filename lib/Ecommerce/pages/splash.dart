import 'package:flutter/material.dart';


class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: CircularProgressIndicator(
          valueColor:AlwaysStoppedAnimation<Color>(Colors.deepOrange),
        ),
      ),
    );
  }
}
