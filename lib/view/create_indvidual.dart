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
import 'package:bossbus/constant/constants.dart' as constants;
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

class CreateIndividual extends StatefulWidget {
  @override
  _CreateIndividualState createState() => _CreateIndividualState();
}

class _CreateIndividualState extends State<CreateIndividual> {
  int currentPageValue = 0;
  PageController pageController;
  final _auth = FirebaseAuth.instance;

  String _name = "";
  String _email = "";
  String _phoneNumber = "";
  String _password = "";
  String _confirmPass = "";
  String errorMessage = "";
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  bool _accept = true;
  bool _isLoading = false;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailAddressController = TextEditingController();
  TextEditingController _phoneNoController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPassController = TextEditingController();

  void _trySignUp(
      String email, String name, String password, String phone) async {
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

        authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        String userId = authResult.user.uid;

        await FirebaseFirestore.instance
            .collection("users")
            .doc(authResult.user.uid)
            .set({
          "email": email,
          "password": _password,
          "firstName": name,
          "phoneNumber": _phoneNumber,
        });

        Provider.of<UserProvider>(context, listen: false)
            .signUpWithEmail(userId, _name, _email, _password, _phoneNumber);

        Navigator.pushReplacementNamed(context, constants.logIn_route);
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
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });
    pageController = PageController();
  }

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
              size: 25,
              color: Theme.of(context).secondaryHeaderColor,
            ),
            onPressed: () =>
                Navigator.pushReplacementNamed(context, constants.logIn_route),
          )
        ],
      ),
      bottomNavigationBar: buildBottomAppBar(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(horizontal: 30),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: TextBlackWidget(
                      text1: 'Individual',
                      text2: 'Easy, and affordable\nrides just for you',
                    ),
                  ),
                  for (int i = 0; i < 2; i++)
                    if (i == currentPageValue) ...[pageIndicate(true)] else
                      pageIndicate(false),
                ],
              ),
              SizedBox(height: 60),
              Flexible(
                child: PageView(
                  controller: pageController,
                  physics: BouncingScrollPhysics(),
                  onPageChanged: (int page) {
                    getChangedPageAndMoveBar(page);
                  },
                  children: <Widget>[
                    buildColumn(),
                    buildColumnSlide(),
                  ],
                ),
              ),
              CircularProgressButton(
                bgColor: Theme.of(context).primaryColor,
                child: _isLoading
                    ? CircularButton()
                    : Text(
                        "Continue",
                        style: TextStyle(color: Theme.of(context).accentColor),
                      ),
                textColor: Theme.of(context).primaryColor,
                onTap: _isLoading
                    ? null
                    : () {
                        if (_formKey.currentState.validate() &&
                            _passwordController.text ==
                                _confirmPassController.text) {
                          _trySignUp(
                              _emailAddressController.text,
                              _nameController.text,
                              _passwordController.text,
                              _phoneNoController.text);
                        }
                      },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column buildColumn() {
    return Column(
      children: [
        TextFormField(
          controller: _nameController,
          validator: (input) =>
              input.trim().isEmpty ? 'Enter your FirstName' : null,
          onSaved: (input) => _name = input,
          keyboardType: TextInputType.name,
          style: TextStyle(color: Theme.of(context).secondaryHeaderColor),
          decoration: new InputDecoration(
            contentPadding: EdgeInsets.only(left: 20),
            fillColor: Color(0xFFF5F5F5),
            filled: true,
            hintText: 'Name',
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
          controller: _emailAddressController,
          validator: (input) => input.isEmpty || !input.contains("@")
              ? 'Enter a valid email address'
              : null,
          onSaved: (input) => _email = input,
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(color: Theme.of(context).secondaryHeaderColor),
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
          controller: _phoneNoController,
          validator: (input) =>
              input.trim().isEmpty ? 'Enter your Phone Number' : null,
          onSaved: (input) => _phoneNumber = input,
          keyboardType: TextInputType.phone,
          style: TextStyle(color: Theme.of(context).secondaryHeaderColor),
          decoration: new InputDecoration(
            contentPadding: EdgeInsets.only(left: 20),
            fillColor: Color(0xFFF5F5F5),
            filled: true,
            hintText: 'Phone Number',
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
      ],
    );
  }

  Column buildColumnSlide() {
    return Column(
      children: [
        TextFormField(
          controller: _passwordController,
          validator: (input) => input.isEmpty || input.length < 6
              ? 'Password must be at least 6 characters'
              : null,
          onSaved: (input) => _password = input,
          obscureText: _obscureText,
          style: TextStyle(color: Theme.of(context).secondaryHeaderColor),
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
        SizedBox(height: 30),
        TextFormField(
          controller: _confirmPassController,
          validator: (input) => input.isEmpty || input.length < 6
              ? 'Password must be at least 6 characters'
              : null,
          onSaved: (input) => _confirmPass = input,
          obscureText: _obscureText,
          style: TextStyle(color: Theme.of(context).secondaryHeaderColor),
          decoration: new InputDecoration(
            contentPadding: EdgeInsets.only(left: 20),
            fillColor: Color(0xFFF5F5F5),
            filled: true,
            hintText: 'Confirm Password',
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: _accept
                  ? IconButton(
                      icon: Icon(Icons.check_box_outline_blank),
                      color: Theme.of(context).secondaryHeaderColor,
                      onPressed: () {
                        setState(() {
                          _accept = false;
                        });
                      },
                    )
                  : IconButton(
                      icon: Icon(Icons.check_box),
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        setState(() {
                          _accept = true;
                        });
                      },
                    ),
            ),
            Text('Accept terms and Conditions',
                style: TextStyle(color: Colors.black, fontSize: 16.0))
          ],
        )
      ],
    );
  }
}
