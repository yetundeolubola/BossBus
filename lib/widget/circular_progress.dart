import 'package:flutter/material.dart';

class CircularButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 25,
      height: 25,
      child: CircularProgressIndicator(
        backgroundColor: Theme.of(context).accentColor,
      ),
    );
  }
}
