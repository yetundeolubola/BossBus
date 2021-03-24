import 'package:bossbus/widget/bottomAppBar.dart';
import 'package:bossbus/widget/logo_widget.dart';
import 'package:bossbus/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class TokenIndividual extends StatefulWidget {
  @override
  _TokenIndividualState createState() => _TokenIndividualState();
}

class _TokenIndividualState extends State<TokenIndividual> {
  String phoneNo = '08067896543';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        elevation: 0.0,
        title: LogoTextWidget(20),
        actions: [
          IconButton(
            icon: Icon(
              Icons.chevron_left,
              color: Theme.of(context).secondaryHeaderColor,
            ),
          )
        ],
      ),
      bottomNavigationBar: buildBottomAppBar(),
      body: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextBlackWidget(
              text1: 'Phone Number\nVerification',
              text2: 'Enter the 4 digit verification code\nsent to $phoneNo',
            ),
          ],
        ),
      ),
    );
  }
}
