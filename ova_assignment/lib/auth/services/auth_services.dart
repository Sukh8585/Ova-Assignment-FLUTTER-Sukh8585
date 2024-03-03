import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ova_assignment/commons/api_error_handel.dart';
import 'package:ova_assignment/commons/common_widgets.dart';
import 'package:ova_assignment/commons/global_variable.dart';
import 'package:ova_assignment/models/user_model.dart';
import 'package:ova_assignment/providers/user_provider.dart';
import 'package:ova_assignment/user/screens/user_homescreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthServices {
  void signUp(
      {required String username,
      required String email,
      required String password,
      required BuildContext context}) async {
    User user = User(
        username: username,
        email: email,
        displayName: username,
        token: '',
        profilePicture: '',
        password: password);
    print(user.toJson());
    http.Response res = await http.post(Uri.parse('$uri/api/sign'),
        headers: <String, String>{
          "content-type": 'application/json; charset=UTF-8',
        },
        body: user.toJson());
    httpErrorHandel(
        response: res,
        context: context,
        onSuccess: () {
          showsnackbar(context, 'account created!! please login to continue');
        });
  }

  void login(
      {required String username,
      required String email,
      required String password,
      required BuildContext context}) async {
    print(jsonEncode({"email": email, "password": password}));
    http.Response res = await http.post(Uri.parse('$uri/api/login'),
        headers: <String, String>{
          "content-type": 'application/json; charset=UTF-8',
        },
        body: jsonEncode({"email": email, "password": password}));
    print(jsonDecode(res.body));
    httpErrorHandel(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences pref = await SharedPreferences.getInstance();
          Provider.of<UserProvider>(context, listen: false).setuser(res.body);
          await pref.setString('x-auth-token', jsonDecode(res.body)['token']);
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (context) {
            return HomeScreen();
          }));
          showsnackbar(context, 'Welcome!');
        });
  }

  void getdata(BuildContext context) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? token = pref.getString("x-auth-token");
      if (token == null) {
        pref.setString('x-auth-token', "");
      }
      var res = await http.post(Uri.parse('$uri/tokenIsvalid'),
          headers: <String, String>{
            'content-type': 'application/json; charset=UTF-8',
            'x-auth-token': token!
          });
      var response = jsonDecode(res.body);
      if (response) {
        http.Response userres = await http.get(Uri.parse("$uri/"),
            headers: <String, String>{
              'content-type': 'application/json; charset=UTF-8',
              'x-auth-token': token
            });

        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setuser(userres.body);
      }
    } catch (e) {
      print(e);
    }
  }
}
