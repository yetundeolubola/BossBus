import 'package:bossbus/widget/bottomAppBar.dart';
import 'package:bossbus/widget/logo_widget.dart';
import 'package:bossbus/widget/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bossbus/widget/button_widget.dart';
import 'package:bossbus/constant/constants.dart' as constants;

class CreateScreen extends StatefulWidget {
  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
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
      body: SingleChildScrollView(
        child: Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: 30),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              TextBlackWidget(
                text1: 'Select Category',
                text2: 'Create an account by choosing\nfrom following.  ',
              ),
              SizedBox(height: 40),
              ButtonTextWidget(text: 'Individual'),
              SizedBox(height: 20),
              ButtonTextWidget(text: 'Organisation'),
              SizedBox(height: MediaQuery.of(context).size.height * 0.15),
              ButtonWidget(
                color: Theme.of(context).primaryColor,
                text: 'Continue',
                style: TextStyle(color: Theme.of(context).accentColor),
                onPress: () => Navigator.pushReplacementNamed(
                    context, constants.create_individual_route),
              ),
            ])),
      ),
    );
  }
}

class ButtonTextWidget extends StatelessWidget {
  final String text;

  ButtonTextWidget({this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
          color: Color(0xFFF5F5F5)),
      child: ListTile(
          title: Text(text, style: Theme.of(context).textTheme.headline4)),
    );
  }
}
