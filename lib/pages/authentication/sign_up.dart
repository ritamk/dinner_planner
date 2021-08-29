import 'package:dinner_planner/services/authentication.dart';
import 'package:dinner_planner/shared/loading.dart';
import 'package:dinner_planner/shared/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String username = "";
  String mail = "";
  String pass = "";
  String error = "";
  bool _hidePassword = true;
  bool loading = false;
  FocusNode _nameFocusNode = FocusNode();
  FocusNode _mailFocusNode = FocusNode();
  FocusNode _passFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextFormField(
                          focusNode: _nameFocusNode,
                          validator: (val) =>
                              val!.isEmpty ? "Enter a name" : null,
                          onChanged: (val) => username = val,
                          decoration: authInputDecoration().copyWith(
                            prefixIcon: Icon(Icons.person),
                            labelText: "Name",
                          ),
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (val) {
                            FocusScope.of(context).requestFocus(_mailFocusNode);
                          },
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextFormField(
                          focusNode: _mailFocusNode,
                          validator: (val) =>
                              val!.isEmpty ? "Enter an email" : null,
                          onChanged: (val) => mail = val,
                          decoration: authInputDecoration().copyWith(
                            prefixIcon: Icon(Icons.mail),
                            labelText: "Email",
                          ),
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (val) {
                            FocusScope.of(context).requestFocus(_passFocusNode);
                          },
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextFormField(
                          focusNode: _passFocusNode,
                          validator: (val) => (val!.length < 6)
                              ? "Enter a password with more than 6 characters"
                              : null,
                          onChanged: (val) => pass = val,
                          obscureText: _hidePassword,
                          decoration: authInputDecoration().copyWith(
                            prefixIcon: Icon(Icons.vpn_key),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _hidePassword = !_hidePassword;
                                });
                              },
                              icon: (_hidePassword)
                                  ? Icon(Icons.visibility)
                                  : Icon(Icons.visibility_off),
                            ),
                            labelText: "Password",
                          ),
                        ),
                      ),
                      const SizedBox(height: 25.0),
                      TextButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              loading = true;
                            });
                            dynamic result = await AuthenticationService()
                                .registerWithEmailAndPass(mail, pass, username);
                            result == null
                                ? setState(() {
                                    loading = false;
                                    error =
                                        "There was an error. Check credentials and/or network connection.";
                                  })
                                : Navigator.pop(context, "/");
                          }
                        },
                        child: Text(
                          "Sign Up",
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                        ),
                        style: authButtonStyle(),
                      ),
                      const SizedBox(height: 25.0),
                      Flex(
                        direction: Axis.vertical,
                        children: <Widget>[
                          Container(
                            child: Text(
                              error,
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.red, fontSize: 14.0),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
