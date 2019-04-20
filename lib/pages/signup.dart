import 'package:flutter/material.dart';




class SignUp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthPageState();
  }
}

class _AuthPageState extends State<SignUp> {
  String _emailValue;
  String _passwordValue;
  bool _acceptTerms = false;
  final GlobalKey<FormState> _formkey= new GlobalKey<FormState>();

 

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
      decoration: InputDecoration(
          labelText: 'Password', filled: true, fillColor: Colors.white),
      obscureText: true,
      onSaved: (String value) {
        
           _passwordValue = value;
   
         
      },
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
   
   Map<String,String> user={
     'email': _emailValue,
      'password': _passwordValue,

   };
    
  }

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home:Scaffold(
      appBar: AppBar(
        title: Text('Login'),
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
                  _buildAcceptSwitch(),
                  SizedBox(
                    height: 10.0,
                  ),
                  RaisedButton(
                    color: Colors.deepOrange,
                    textColor: Colors.white,
                    child: Text('SIGNUP'),
                    onPressed: _submitForm,
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
