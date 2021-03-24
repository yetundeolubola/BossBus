import 'package:bossbus/provider/theme_provider.dart';
import 'package:bossbus/provider/userProvider.dart';
import 'package:bossbus/view/create.dart';
import 'package:bossbus/view/create_indvidual.dart';
import 'package:bossbus/view/login_screen.dart';
import 'package:bossbus/view/slider_screen.dart';
import 'package:bossbus/view/splash_screen.dart';
import 'package:bossbus/view/token_individual.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'constant/constants.dart' as constants;
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (cxt) {
          return ThemeProvider();
        }),
        ChangeNotifierProvider(create: (cxt) {
          return UserProvider();
        }),
      ],
      child: Consumer<ThemeProvider>(
        builder: (bCTx, themeProvider, _) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                      fontFamily: 'Wavehaus',
                      scaffoldBackgroundColor: themeProvider.accent,
                      primarySwatch: themeProvider.primary,
                      accentColor: themeProvider.accent,
                      secondaryHeaderColor: themeProvider.secondary,
                      inputDecorationTheme: InputDecorationTheme(
                          labelStyle: TextStyle(color: themeProvider.secondary),
                          hintStyle: TextStyle(color: themeProvider.secondary)))
                  .copyWith(
                      textTheme: TextTheme(
                          headline1: TextStyle(
                              color: themeProvider.accent, fontSize: 16.0),
                          bodyText2: TextStyle(
                              color: themeProvider.accent, fontSize: 20.0),
                          bodyText1: TextStyle(
                              color: themeProvider.secondary, fontSize: 30.0),
                          headline4: TextStyle(
                              color: themeProvider.secondary, fontSize: 16.0))),
              home: SplashScreen(),
              routes: {
                constants.slider_route: (context) => SliderScreen(),
                constants.logIn_route: (context) => LoginScreen(),
                constants.create_route: (context) => CreateScreen(),
                constants.create_individual_route: (context) =>
                    CreateIndividual(),
                constants.token_individual_route: (context) =>
                    TokenIndividual(),
              });
        },
      ),
    );
  }
}
