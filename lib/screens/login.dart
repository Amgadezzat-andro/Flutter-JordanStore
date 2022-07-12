// ignore_for_file: prefer_const_constructors, deprecated_member_use
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:generalshop/customer/user.dart';
import 'package:generalshop/screens/homepage.dart';
import 'package:generalshop/screens/utilities/screen_utilites.dart';
import 'package:generalshop/api/authentication.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  Authentication authentication = Authentication();
  var _formKey = GlobalKey<FormState>();

  bool _loading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Transform.translate(
        offset: Offset(0, -125),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 24,
            right: 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sign In',
                    style: Theme.of(context).textTheme.titleLarge.copyWith(
                          fontSize: 32,
                          fontFamily: 'Nunito',
                        ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Login to continue to your account',
                    style: Theme.of(context).textTheme.titleMedium.copyWith(
                          fontSize: 18,
                          color: ScreenUtilities.darkerGreyText,
                        ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 24,
                  bottom: 24,
                ),
                child: _loginForm(context),
              ),
              Container(
                width: double.infinity,
                height: 65,
                margin: EdgeInsets.only(top: 24, bottom: 24),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(34),
                  ),
                  color: ScreenUtilities.mainBlue,
                  onPressed: (_loading) ? null : _loginUser,
                  child: (_loading)
                      ? Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.white,
                          ),
                        )
                      : Text(
                          'LOGIN',
                          style:
                              Theme.of(context).textTheme.titleMedium.copyWith(
                                    color: Colors.white,
                                    fontSize: 18,
                                    letterSpacing: 1.5,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account',
                    style: Theme.of(context).textTheme.titleMedium.copyWith(
                          fontSize: 18,
                          color: ScreenUtilities.darkerGreyText,
                        ),
                  ),
                  FlatButton(
                    onPressed: () {
                      //TODO : send them to sign up screen
                    },
                    child: Transform.translate(
                      offset: Offset(0, 0),
                      child: Text(
                        'Sign Up',
                        style: Theme.of(context).textTheme.titleMedium.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _loginForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              hintText: 'Email',
              hintStyle: TextStyle(
                fontSize: 24,
              ),
              labelStyle: TextStyle(
                fontSize: 24,
              ),
            ),
            style: TextStyle(fontSize: 24),
            validator: (value) {
              if (value.isEmpty) {
                return 'Email is required';
              }
              return null;
            },
          ),
          SizedBox(height: 24),
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'Password',
              hintStyle: TextStyle(
                fontSize: 24,
              ),
              labelStyle: TextStyle(
                fontSize: 24,
              ),
            ),
            style: TextStyle(fontSize: 24),
            validator: (value) {
              if (value.isEmpty) {
                return 'Password is required';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  void _loginUser() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _loading = true;
      });
      String email = _emailController.text;
      String password = _passwordController.text;
      User user = await authentication.login(email, password);
      if (user != null) {
        setState(() {
          _loading = false;
        });
        Navigator.push(
            context, MaterialPageRoute(builder: ((context) => HomePage())));
      } else {
        setState(() {
          _loading = false;
        });
      }
    }
  }
}
