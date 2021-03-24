import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 50.0,
        height: 50.0,
        decoration: new BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).primaryColor,
            image: new DecorationImage(
                fit: BoxFit.scaleDown,
                image: new AssetImage("asset/images/logo.png"))));
  }
}

class LogoTextWidget extends StatelessWidget {
  final double size;

  LogoTextWidget(this.size);

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      LogoWidget(),
      SizedBox(width: 10),
      Text('Bossbus',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).secondaryHeaderColor,
              fontSize: size)),
    ]);
  }
}
