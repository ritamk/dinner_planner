import 'package:dinner_planner/services/authentication.dart';
import 'package:dinner_planner/shared/loading.dart';
import 'package:dinner_planner/shared/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignIn extends StatefulWidget {
  SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String mail = "";
  String pass = "";
  String error = "";
  bool _hidePassword = true;
  bool loading = false;
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
                          focusNode: _mailFocusNode,
                          validator: (val) =>
                              val!.isEmpty ? "Enter your email" : null,
                          onChanged: (val) => mail = val,
                          decoration: authInputDecoration().copyWith(
                            prefixIcon: const Icon(Icons.person),
                            labelText: "Email",
                          ),
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (val) {
                            _mailFocusNode.unfocus();
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
                              ? "Your password has atleast 6 characters"
                              : null,
                          onChanged: (val) => pass = val,
                          obscureText: _hidePassword,
                          decoration: authInputDecoration().copyWith(
                            prefixIcon: const Icon(Icons.vpn_key),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _hidePassword = !_hidePassword;
                                });
                              },
                              icon: (_hidePassword)
                                  ? const Icon(Icons.visibility)
                                  : const Icon(Icons.visibility_off),
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
                                .signInWithEmailAndPass(mail, pass);
                            result != null
                                ? Navigator.pop(context, "/")
                                : setState(() {
                                    loading = false;
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: const Text(
                                          "Couldn't sign-in, try again later.\nPlease check credentials and/or network connection."),
                                    ));
                                  });
                          }
                        },
                        child: const Text(
                          "Sign In",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold),
                        ),
                        style: authButtonStyle(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
