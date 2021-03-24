import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String text1;
  final String text2;

  TextWidget({this.text1, this.text2});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 50),
        Text(text1,
            maxLines: 3,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText2),
        Text(text2,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline1),
      ],
    );
  }
}

class TextBlackWidget extends StatelessWidget {
  final String text1;
  final String text2;

  TextBlackWidget({this.text1, this.text2});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 50),
        Text(text1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyText1),
        SizedBox(height: 10),
        Text(text2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.headline4),
      ],
    );
  }
}

Widget mainView() {
  return Column(
    children: <Widget>[
      Expanded(
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'asset/images/building.png',
                fit: BoxFit.fitWidth,
                alignment: Alignment.bottomLeft,
              ),
            ),
            Positioned(
              bottom: 0.0,
              child: Image.asset(
                'asset/images/bus.png',
                alignment: Alignment.bottomLeft,
              ),
            )
          ],
        ),
      ),
    ],
  );
}
