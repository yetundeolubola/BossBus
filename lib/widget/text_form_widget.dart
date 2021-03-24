import 'package:flutter/material.dart';

class TextFormWidget extends StatelessWidget {
  final String text;

  TextFormWidget(this.text);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.phone,
      style: TextStyle(color: Theme.of(context).secondaryHeaderColor),
      decoration: new InputDecoration(
        contentPadding: EdgeInsets.only(left: 20),
        fillColor: Color(0xFFF5F5F5),
        filled: true,
        hintText: text,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFF5F5F5)),
        ),
        focusedBorder: OutlineInputBorder(),
        border: new OutlineInputBorder(
            borderRadius: const BorderRadius.all(
          const Radius.circular(10),
        )),
      ),
    );
  }
}
