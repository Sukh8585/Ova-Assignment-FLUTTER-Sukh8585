import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ova_assignment/commons/global_variable.dart';
import 'package:ova_assignment/models/user_model.dart';
import 'package:ova_assignment/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class SearchServices {
  Future<List<User>> findNewFrieds(
      {required String value, required BuildContext context}) async {
    final List<User> friends = [];
    final User user = Provider.of<UserProvider>(context, listen: false).user;
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/api/find-new-friends'), headers: {
        "content-type": "application/json; charset=UTF-8",
        "x-auth-token": user.token,
        "username": value
      });

      for (var i = 0; i < jsonDecode(res.body).length; i++) {
        User temp = User.fromJson(jsonEncode(jsonDecode(res.body)[i]));
        friends.add(temp);
        print(user.sentrequests!
            .any((element) => element['requestedUserId'] == temp.id));
      }
    } catch (e) {
      print(e);
    }

    return friends;
  }

  Future<bool> isrequested(BuildContext context, String id) async {
    User user = Provider.of<UserProvider>(context, listen: false).user;
    try {
      //! send the http request to send request to the user
      // Todo : get the res ponse in usermodel add lists for friendrequests and sentrequests parse through it and save it return a bool of request sent
      http.Response res = await http.post(Uri.parse('$uri/api/send-request'),
          headers: {
            'content-type': 'application/json; charset=UTF-8',
            'x-auth-token': user.token
          },
          body: jsonEncode({'sendto': id}));

      print(jsonDecode(res.body));
    } catch (e) {
      print(e);
    }
    return true;
  }
}
