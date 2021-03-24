import 'package:flutter/material.dart';

BottomAppBar buildBottomAppBar() {
  return BottomAppBar(
    child: Image.asset(
      "asset/images/silhouette.png",
      fit: BoxFit.fitWidth,
      alignment: Alignment.bottomLeft,
    ),
  );
}
