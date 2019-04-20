import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

enum AuthMode{
  SignUp,
  Login
}



class SignUp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthPageState();
  }
}

class _AuthPageState extends State<SignUp> {
  AuthMode _authMode = AuthMode.Login;
  String _emailValue;
  String _passwordValue;
  bool _acceptTerms = false;
  final GlobalKey<FormState> _formkey= new GlobalKey<FormState>();
  TextEditingController _passwordController = new TextEditingController();

 

  Widget _buildEmailTextField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'E-Mail', filled: true, fillColor: Colors.white),
      keyboardType: TextInputType.emailAddress,
      onSaved: (String value) {
       
           _emailValue = value;
      
         
      },
    );
  }

  Widget _buildPasswordTextField() {
    return TextFormField(
      controller: _passwordController,
      decoration: InputDecoration(
          labelText: 'Confirm Password', filled: true, fillColor: Colors.white),
      obscureText: true,
      validator: (String value){
        if(_passwordController.text!=value){
          return 'passwords do not match';
        }
      },
      onSaved: (String value) {
        
           _passwordValue = value;
   
         
      },
    );
  }
  Widget _confirmPasswordTextField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Password', filled: true, fillColor: Colors.white),
      obscureText: true,
      
    );
  }

  Widget _buildAcceptSwitch() {
    return SwitchListTile(
      value: _acceptTerms,
      onChanged: (bool value) {
        setState(() {
          _acceptTerms = value;
        });
      },
      title: Text('Accept Terms'),
    );
  }

  void _submitForm() {
  _formkey.currentState.save();
  _authMode==AuthMode.Login ? Login(_emailValue,_passwordValue) : Signup(_emailValue, _passwordValue);
   
  }
  Future <Map<String,dynamic>> Signup( String email, String password)
   async{
     final Map<String,dynamic> user={
       'email': email,
       'password': password,
       'returnSecureToken': true
     };
    final http.Response response = await http.post('https://www.googleapis.com/identitytoolkit/v3/relyingparty/signupNewUser?key=AIzaSyDzhDqanWOy7-GOyCgoi8NjN9bMSp40Fbc',
       body: json.encode(user),
       headers: {'Content-Type': 'application/json'},
       );
   }

   Future <Map<String,dynamic>> Login(String email,String password)
   async{
     final Map<String,dynamic> user={
       'email': email,
       'password': password,
       'returnSecureToken': true
     };

    final http.Response response = await http.post('https://www.googleapis.com/identitytoolkit/v3/relyingparty/verifyPassword?key=AIzaSyDzhDqanWOy7-GOyCgoi8NjN9bMSp40Fbc',
    body: json.encode(user),
    headers: {'Content-Type': 'application/json'});
   }

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home:Scaffold(
      appBar: AppBar(
        title: Text('Signup'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Container(
        
        padding: EdgeInsets.all(10.0),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: 420.0,
              child: Form(
                key: _formkey,
                child: Column(
                children: <Widget>[
                  _buildEmailTextField(),
                  SizedBox(
                    height: 10.0,
                  ),
                  _buildPasswordTextField(),
                  SizedBox(
                    height: 10.0,
                  ),

                  _authMode == AuthMode.SignUp ? _confirmPasswordTextField() : Container(),

                  _buildAcceptSwitch(),
                  SizedBox(
                    height: 10.0,
                  ),
                  RaisedButton(
                    color: Colors.deepOrange,
                    textColor: Colors.white,
                    child: Text('${_authMode == AuthMode.Login? 'LOGIN': 'SIGNUP'}'),
                    onPressed: _submitForm,
                  ),
                  SizedBox(height: 10.0,),

                  FlatButton(
                    child: Text('Switch to ${_authMode == AuthMode.Login? 'SIGNUP': 'LOGIN'}'),
                    onPressed: (){
                      setState(() {
                         _authMode = _authMode == AuthMode.Login? AuthMode.SignUp : AuthMode.Login;
                      });
                     
                    },
                  ),
                ],
              ),
            ),
            ),
          ),
        ),
      ),
    ),
    );
  }
}
