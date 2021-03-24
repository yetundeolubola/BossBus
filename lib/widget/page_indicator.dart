import 'package:bossbus/constant/color.dart';
import 'package:flutter/material.dart';

Widget pageIndicator(bool isActive) {
  return Container(
    height: 4,
    width: 15,
    margin: EdgeInsets.only(left: 10, right: 10),
    child: DecoratedBox(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: isActive ? kColorActive : kColorInActive,
        borderRadius: BorderRadius.all(
          Radius.elliptical(4, 4),
        ),
      ),
    ),
  );
}
