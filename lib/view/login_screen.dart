import 'package:bossbus/provider/userProvider.dart';
import 'package:bossbus/widget/bottomAppBar.dart';
import 'package:bossbus/widget/button_widget.dart';
import 'package:bossbus/widget/circular_progress.dart';
import 'package:bossbus/widget/logo_widget.dart';
import 'package:bossbus/widget/text_form_widget.dart';
import 'package:bossbus/widget/text_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bossbus/constant/constants.dart' as constant;
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  String _name = "";
  String _email = "";
  String _phoneNumber = "";
  String _password = "";
  String _confirmPass = "";
  String errorMessage = "";
  String _userId = "";
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  bool _accept = true;
  bool _isLoading = false;

  TextEditingController _emailAddressController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  void _tryLogin(String email, String password) async {
    UserCredential authResult;
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context)
        .unfocus(); //remove the keyboard and make all form field back to unfocus

    try {
      if (isValid) {
        _formKey.currentState.save();
        setState(() {
          _isLoading = true;
        });

        authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        String userId = authResult.user.uid;
        dynamic userData = await FirebaseFirestore.instance
            .collection("users")
            .doc(userId)
            .get();
        _userId = userId;
        Provider.of<UserProvider>(context, listen: false)
            .signUpWithEmail(userId, _name, _email, _password, _phoneNumber);
        Navigator.pushReplacementNamed(
            context, constant.token_individual_route);
      }
    } on FirebaseAuthException catch (error) {
      errorMessage = "An error occurred, please check your credentials";
      print(error);
      if (error.message != null) {
        errorMessage = error.message;
      }

      setState(() {
        _isLoading = false;
      });
    } catch (err) {
      errorMessage = err.message;
      setState(() {
        _isLoading = false;
      });
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).accentColor,
          elevation: 0.0,
          title: LogoTextWidget(20.0),
        ),
        bottomNavigationBar: buildBottomAppBar(),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 40),
                  TextBlackWidget(
                    text1: 'Welcome back :)',
                    text2: 'Hope you’ve been enjoying the\nride.',
                  ),
                  SizedBox(height: 40),
                  TextFormField(
                    controller: _emailAddressController,
                    validator: (input) => input.isEmpty || !input.contains("@")
                        ? 'Enter a valid email address'
                        : null,
                    onSaved: (input) => _email = input,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(
                        color: Theme.of(context).secondaryHeaderColor),
                    decoration: new InputDecoration(
                      contentPadding: EdgeInsets.only(left: 20),
                      fillColor: Color(0xFFF5F5F5),
                      filled: true,
                      hintText: 'Email',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFF5F5F5)),
                      ),
                      focusedBorder: OutlineInputBorder(),
                      border: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                        const Radius.circular(10),
                      )),
                    ),
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                    controller: _passwordController,
                    validator: (input) => input.isEmpty || input.length < 6
                        ? 'Password must be at least 6 characters'
                        : null,
                    onSaved: (input) => _password = input,
                    obscureText: _obscureText,
                    style: TextStyle(
                        color: Theme.of(context).secondaryHeaderColor),
                    decoration: new InputDecoration(
                      contentPadding: EdgeInsets.only(left: 20),
                      fillColor: Color(0xFFF5F5F5),
                      filled: true,
                      hintText: 'Password',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFF5F5F5)),
                      ),
                      focusedBorder: OutlineInputBorder(),
                      border: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                        const Radius.circular(10),
                      )),
                    ),
                  ),
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      child: Text('Forget Password?',
                          style: TextStyle(
                              fontSize: 12.0,
                              color: Theme.of(context).secondaryHeaderColor)),
                    ),
                  ),
                  SizedBox(height: 30),
                  CircularProgressButton(
                      bgColor: Theme.of(context).secondaryHeaderColor,
                      child: _isLoading
                          ? CircularButton()
                          : Text(
                              "Login",
                              style: TextStyle(
                                  color: Theme.of(context).accentColor),
                            ),
                      textColor: Theme.of(context).primaryColor,
                      onTap: _isLoading
                          ? null
                          : () {
                              _tryLogin(_emailAddressController.text,
                                  _passwordController.text);
                            }),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('New here?',
                          style: Theme.of(context).textTheme.headline4),
                      InkWell(
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0),
                        ),
                        onTap: () => Navigator.pushReplacementNamed(
                            context, constant.create_route),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
