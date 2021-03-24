import 'package:bossbus/widget/button_widget.dart';
import 'package:bossbus/widget/logo_widget.dart';
import 'package:bossbus/widget/page_indicator.dart';
import 'package:bossbus/widget/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bossbus/constant/constants.dart' as constants;

class SliderScreen extends StatefulWidget {
  SliderScreen({Key key}) : super(key: key);
  @override
  _SliderScreenState createState() => _SliderScreenState();
}

class _SliderScreenState extends State<SliderScreen> {
  int currentPageValue = 0;
  PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void getChangedPageAndMoveBar(int page) {
    setState(() {
      currentPageValue = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Flex(
          direction: Axis.vertical,
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(top: 50),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      LogoWidget(),
                      SizedBox(width: 10),
                      Text('Bossbus',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).secondaryHeaderColor,
                              fontSize: 27.0)),
                    ])),
            Flexible(flex: 2, child: mainView()),
            Expanded(
              flex: 2,
              child: Container(
                color: Theme.of(context).secondaryHeaderColor,
                child: Column(
                  children: <Widget>[
                    Flexible(
                      child: PageView(
                        controller: pageController,
                        physics: BouncingScrollPhysics(),
                        onPageChanged: (int page) {
                          getChangedPageAndMoveBar(page);
                        },
                        children: <Widget>[
                          TextWidget(
                              text1: 'End to End \nTransport Solution',
                              text2: 'Easy and comfortable rides'),
                          TextWidget(
                              text1: 'Earn as you ride',
                              text2: 'Make money on rides'),
                          TextWidget(
                              text1: 'Join our Community',
                              text2: 'Step into the Bossbus world'),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        for (int i = 0; i < 3; i++)
                          if (i == currentPageValue) ...[
                            pageIndicator(true)
                          ] else
                            pageIndicator(false),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.07),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 30),
                      child: ButtonWidget(
                          color: Theme.of(context).accentColor,
                          text: 'Login',
                          style: TextStyle(
                              color: Theme.of(context).secondaryHeaderColor),
                          onPress: () => Navigator.pushReplacementNamed(
                              context, constants.logIn_route)),
                    ),
                    SizedBox(height: 20),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 30),
                      child: ButtonWidget(
                          color: Theme.of(context).primaryColor,
                          text: 'Create Account',
                          style:
                              TextStyle(color: Theme.of(context).accentColor),
                          onPress: () => Navigator.pushReplacementNamed(
                              context, constants.create_route)),
                    ),
                    SizedBox(height: 20)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
