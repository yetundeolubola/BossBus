import 'package:bossbus/constant/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ButtonWidget extends StatelessWidget {
  final Color color;
  final String text;
  final Function onPress;
  final TextStyle style;

  ButtonWidget({this.color, this.text, this.onPress, this.style});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
            color: color),
        child: FlatButton(
          child: Text(
            text,
            style: style,
          ),
        ),
      ),
      onTap: onPress,
    );
  }
}

class CircularProgressButton extends StatelessWidget {
  final Function onTap;
  final Widget child;
  final Color bgColor, textColor;
  final String iconPath;
  final bool enabled;

  CircularProgressButton(
      {this.child,
      this.onTap,
      this.bgColor,
      this.textColor,
      this.iconPath,
      this.enabled});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: Theme.of(context).primaryColorLight,
          onTap: onTap,
          borderRadius: BorderRadius.circular(0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              iconPath == null
                  ? Text(
                      "",
                      style: TextStyle(color: textColor),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: SvgPicture.asset(
                        iconPath,
                        width: 20,
                        height: 20,
                      ),
                    ),
              child,
            ],
          ),
        ),
      ),
    );
  }
}



Widget pageIndicate(bool isActive) {
  return Container(
    height: 4,
    width: 6,
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
