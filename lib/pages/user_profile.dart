import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recipesbook/services/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return UserProfileState();
  }
}

class UserProfileState extends State<UserProfile> {
  final GlobalKey<FormState> _globalKey = GlobalKey();
  String _login = '';
  String _password = '';
  bool _notifications = false;
  bool _stayLogin = true;

  Widget _buildEmailTextField() {
    Api.currentUser.then((user) => _login = user.email);
    return TextFormField(
      initialValue: _login,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          labelText: 'Login', filled: true, fillColor: Colors.transparent),
      validator: (String value) {
        if (value.isEmpty ||
            !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                .hasMatch(value)) {
          return 'The mail is not valid';
        }
      },
      onSaved: (String text) {
        _login = text;
      },
    );
  }

  void submitForm() {
    if (!_globalKey.currentState.validate()) {
      return;
    }
    _globalKey.currentState.save();
  }



  showMyDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Удалить аккаунт ?'),
            actions: <Widget>[
              FlatButton(
                child: Text('Отмена'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                child: Text('Подтвердить'),
                onPressed: () async {
                  FirebaseUser user = await Api.currentUser;
                  print(user.uid);
                  var userUpdateInfo = new UserUpdateInfo();
                  userUpdateInfo.photoUrl = "dkaslkadls";

                  user.updateProfile(userUpdateInfo);
                  
                  user.providerData.forEach((item){
                    print(item.displayName);
                    print(item.email);
                    print(item.phoneNumber);
                    print(item.photoUrl);
                    print(user.providerData.length);

                  });
                  // await user.delete();
                  // Navigator.of(context).pushNamedAndRemoveUntil(
                  //     '/auth', (Route<dynamic> route) => false);
                  // Navigator.pop(context);
                },
              )
            ],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            content: Container(
              width: 190.0,
              height: 130.0,
              child: Center(
                child: Text(
                    'Вы действительно хотите удалить аккаунт, все ваши рецепты будут удалены ?'),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Form(
            key: _globalKey,
            child: Container(
              child: Column(
                children: <Widget>[
                  _buildEmailTextField(),
                  SizedBox(height: 10.0),
                  SizedBox(height: 10.0),
                  FutureBuilder(
                    future: SharedPreferences.getInstance(),
                    builder: (context,dataSnapshot){
                      if(!dataSnapshot.hasData){
                        return Text("Loading");
                      }else{
                        return SwitchListTile(
                      secondary: Icon(Icons.verified_user),
                      title: Text('Оставаться в системе'),
                      value: (dataSnapshot.data as SharedPreferences).getBool("result")??true,
                      onChanged: (value) {
                        setState(() {
                          (dataSnapshot.data as SharedPreferences).setBool("result", value);
                          _stayLogin = value;
                        });
                      });
                      }
                    },
                  ),

                  SizedBox(height: 10.0),
                  ListTile(
                      title: Center(
                        child: Text(
                          'Удалить аккаунт',
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ),
                      onTap: () => showMyDialog(context)),
                  SizedBox(height: 10.0),
                  ButtonTheme(
                    minWidth: MediaQuery.of(context).size.width / 2,
                    child: RaisedButton(
                      child: Text('Сохранить'),
                      onPressed: submitForm,
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(
                            MediaQuery.of(context).size.height / 2),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
