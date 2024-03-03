import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ova_assignment/auth/services/auth_services.dart';
import 'package:ova_assignment/commons/common_widgets.dart';

enum auth { Login, Signup }

class AuthScreen extends StatefulWidget {
  AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  var currentAuth = auth.Login;
  GlobalKey signupFormKey = GlobalKey();
  TextEditingController _namecontroller = TextEditingController();
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();
  TextEditingController _phonecontroller = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _namecontroller.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    _phonecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Material(
              child: ListTile(
                tileColor: currentAuth == auth.Signup
                    ? Color.fromARGB(255, 35, 53, 188)
                    : Color.fromARGB(255, 49, 48, 48),
                leading: Radio(
                    activeColor: Color.fromARGB(255, 29, 33, 70),
                    value: auth.Signup,
                    groupValue: currentAuth,
                    onChanged: (auth? value) {
                      if (value != null) {
                        setState(() {
                          currentAuth = value;
                        });
                      }
                    }),
                title: Text('SignUp'),
              ),
            ),
            SizedBox(
              height: 3,
            ),
            if (currentAuth == auth.Signup)
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 1, color: Color.fromARGB(255, 35, 53, 188))),
                height: 300,
                width: double.infinity,
                child: Column(
                  children: [
                    Form(
                        key: signupFormKey,
                        child: Column(
                          children: [
                            Material(
                              child: inputTextFiled(
                                  controller: _namecontroller,
                                  maxline: 1,
                                  hint: 'Username'),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Material(
                              child: inputTextFiled(
                                  controller: _emailcontroller,
                                  maxline: 1,
                                  hint: 'Enter Email'),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Material(
                              child: inputTextFiled(
                                  controller: _passwordcontroller,
                                  maxline: 1,
                                  hint: 'Enter Password'),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ElevatedButton.icon(
                                onPressed: () {
                                  AuthServices().signUp(
                                      username: _namecontroller.text,
                                      email: _emailcontroller.text,
                                      password: _passwordcontroller.text,
                                      context: context);
                                },
                                icon: Icon(Icons.login),
                                label: Text(
                                  'signup',
                                  style: TextStyle(),
                                ))
                          ],
                        )),
                  ],
                ),
              ),
            SizedBox(
              height: 3,
            ),
            Material(
              child: ListTile(
                tileColor: currentAuth == auth.Login
                    ? Color.fromARGB(255, 56, 72, 191)
                    : const Color.fromARGB(255, 49, 48, 48),
                leading: Radio(
                    activeColor: Color.fromARGB(255, 29, 33, 70),
                    value: auth.Login,
                    groupValue: currentAuth,
                    onChanged: (auth? value) {
                      if (value != null) {
                        setState(() {
                          currentAuth = value;
                        });
                      }
                    }),
                title: Text('Login'),
              ),
            ),
            SizedBox(
              height: 3,
            ),
            if (currentAuth == auth.Login)
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 1, color: Color.fromARGB(255, 35, 53, 188))),
                height: 220,
                width: double.infinity,
                child: Column(children: [
                  Form(
                      key: signupFormKey,
                      child: Column(
                        children: [
                          Material(
                            child: inputTextFiled(
                                controller: _emailcontroller,
                                maxline: 1,
                                hint: 'Enter Name'),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Material(
                            child: inputTextFiled(
                                controller: _passwordcontroller,
                                maxline: 1,
                                hint: 'Enter password'),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ElevatedButton.icon(
                              onPressed: () {
                                AuthServices().login(
                                    username: '',
                                    email: _emailcontroller.text,
                                    password: _passwordcontroller.text,
                                    context: context);
                              },
                              icon: Icon(Icons.login),
                              label: Text(
                                'login',
                                style: TextStyle(),
                              ))
                        ],
                      )),
                ]),
              ),
            SizedBox(
              height: 3,
            ),
          ],
        ),
      ),
    );
  }
}
