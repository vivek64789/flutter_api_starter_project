import 'package:flutter/material.dart';
import 'package:project_api/http/user_http.dart';
import 'package:project_api/model/user.dart';

import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = '/register';
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _fname;
  String? _lname;
  String? _username;
  String? _password;
  final HttpConnectUser _connectUser = HttpConnectUser();
  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'First Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                onSaved: (value) => _fname = value,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Last Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                onSaved: (value) => _lname = value,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                onSaved: (value) => _username = value,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                // password type
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                onSaved: (value) => _password = value,
              ),
              const SizedBox(
                height: 20,
              ),
              _loading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            _loading = true;
                          });
                          _formKey.currentState!.save();
                          final _userData = User(
                            fname: _fname,
                            lname: _lname,
                            username: _username,
                            password: _password,
                          );
                          var response = await _connectUser.registerUser(
                              _userData, 'register');
                          if (response['success'] == true) {
                            setState(() {
                              _loading = false;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Registered Successfully'),
                              ),
                            );
                            Navigator.pushReplacementNamed(
                                context, LoginScreen.routeName);
                          } else {
                            setState(() {
                              _loading = false;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Registration failed'),
                              ),
                            );
                            print(response['message']);
                          }
                          ;
                        }
                      },
                      child: const Text("Register"),
                    ),
              Row(
                children: [
                  const Text("Already an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).restorablePushReplacementNamed(
                          LoginScreen.routeName);
                    },
                    child: const Text("Sign in"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
