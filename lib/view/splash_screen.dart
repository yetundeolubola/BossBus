import 'dart:async';
import 'package:bossbus/widget/bottomAppBar.dart';
import 'package:bossbus/widget/logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:bossbus/constant/constants.dart' as constants;

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),
        () => Navigator.pushReplacementNamed(context, constants.slider_route));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: buildBottomAppBar(),
        body:
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          Center(child: LogoWidget()),
          SizedBox(width: 10),
          Align(
            alignment: Alignment.center,
            child: Text('Bossbus',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).secondaryHeaderColor,
                    fontSize: 27.0)),
          ),
        ]));
  }
}
