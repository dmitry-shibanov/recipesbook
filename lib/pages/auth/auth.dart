import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info/device_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:recipesbook/mixins/validator_mixins.dart';
import 'package:recipesbook/services/api.dart';
import 'package:system_info/system_info.dart';

enum AuthMode { SignUp, Login }

class AuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: Regestration());
  }
}

class Regestration extends StatefulWidget {
  @override
  State<Regestration> createState() {
    return RegesrtationState();
  }
}

class RegesrtationState extends State<Regestration>
    with TickerProviderStateMixin, ValidatorMixins {
  String _login = '';
  String _password = '';
  bool _acceptTerms = true;
  final GlobalKey<FormState> _globalKey = GlobalKey();
  final PermissionHandler _permissionHandler = PermissionHandler();
  AnimationController _controller;
  AuthMode authVariant;
  FirebaseUser _user;
  Animation<Offset> _animation;

  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    authVariant = AuthMode.Login;
    _animation = new Tween<Offset>(begin: Offset(0.0, -2.0), end: Offset.zero)
        .animate(
            CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn));
    super.initState();
  }

  DecorationImage _buildBakcgroundImage() {
    return DecorationImage(
      fit: BoxFit.cover,
      colorFilter:
          ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.dstATop),
      image: AssetImage('public/auth.jpg'),
    );
  }

  Future<bool> _requestPermission(PermissionGroup permission) async {
    var result = await _permissionHandler.requestPermissions([permission]);
    if (result[permission] == PermissionStatus.granted) {
      return true;
    }
    return false;
  }

  Future<bool> hasPermission(PermissionGroup permission) async {
    var permissionStatus =
        await _permissionHandler.checkPermissionStatus(permission);
    return permissionStatus == PermissionStatus.granted;
  }

  Widget _buildEmailTextField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          labelText: 'Login', filled: true, fillColor: Colors.white),
      validator: validateEmail,
      onSaved: (String text) {
        _login = text;
      },
    );
  }

  Widget _buildPasswordTextField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      obscureText: true,
      decoration: InputDecoration(
          labelText: 'password', filled: true, fillColor: Colors.white),
      validator: validatePassword,
      onSaved: (String text) {
        _password = text;
      },
    );
  }

  Widget _buildConfirmPasswordTextField() {
    return FadeTransition(
      opacity: CurvedAnimation(curve: Curves.easeIn, parent: _controller),
      child: SlideTransition(
        position: _animation,
        child: TextFormField(
          keyboardType: TextInputType.text,
          obscureText: true,
          decoration: InputDecoration(
              labelText: 'Confirm password',
              filled: true,
              fillColor: Colors.white),
          validator: (String value) {
            if (value != _password && authVariant == AuthMode.SignUp) {
              return 'Passwords should be equal';
            }
          },
          onSaved: (String text) {
            // _password = text;
          },
        ),
      ),
    );
  }

  Widget _buildAcceptSwitch() {
    return SwitchListTile(
      onChanged: (bool value) {
        setState(() {
          _acceptTerms = value;
        });
      },
      value: _acceptTerms,
      title: Text('accept terms'),
    );
  }

  submitForm() async {
    _globalKey.currentState.save();

    if (!_globalKey.currentState.validate()) {
      return;
    }

    if (authVariant == AuthMode.Login) {
      _user = await Api.handleSignInEmail(_login, _password);
    } else {
      _user = await Api.handleSignUp(_login, _password);
    }
    print(_user);
    if (_user != null) {
      Navigator.pushReplacementNamed(context, '/main');
    } else {
      return;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _globalKey.currentState.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 768.0 ? 500.0 : deviceWidth * 0.95;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        decoration: BoxDecoration(
          image: _buildBakcgroundImage(),
        ),
        padding: EdgeInsets.all(10.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _globalKey,
              child: Container(
                width: targetWidth,
                child: Column(
                  children: <Widget>[
                    _buildEmailTextField(),
                    SizedBox(height: 10.0),
                    _buildPasswordTextField(),
                    SizedBox(height: 10.0),
                    _buildConfirmPasswordTextField(),
                    _buildAcceptSwitch(),
                    SizedBox(height: 10.0),
                    FlatButton(
                      child: Text(
                          'Перейти к ${AuthMode.Login == authVariant ? 'Регистрации' : 'Входу'}'),
                      onPressed: () {
                        if (authVariant == AuthMode.Login) {
                          setState(() {
                            authVariant = AuthMode.SignUp;
                          });
                          _controller.forward();
                        } else {
                          setState(() {
                            authVariant = AuthMode.Login;
                          });
                          _controller.reverse();
                        }
                      },
                    ),
                    SizedBox(height: 10.0),
                    RaisedButton(
                      child: Text('finish'),
                      onPressed: submitForm,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
