// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:ova_assignment/models/request_model.dart';

class User {
  final String username;
  final String id;
  final String email;
  final String displayName;
  final String token;
  final String profilePicture;
  final String password;
  final List? friendList;
  final List? friendrequests;
  final List? sentrequests;
  User({
    required this.username,
    required this.email,
    required this.displayName,
    required this.token,
    required this.profilePicture,
    required this.password,
    required this.id,
    required this.friendList,
    required this.friendrequests,
    required this.sentrequests,
  });
  //! Uncomment
  // final List<String> friendRequests; // Assuming friendRequests is a list of user IDs or usernames

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'email': email,
      'displayName': displayName,
      'token': token,
      'profilePicture': profilePicture,
      'password': password,
      'friendRequests': friendRequests,
      'sendRequests': sendRequests,
      'friendRequests': friendRequests
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
        id: map['_id'] ?? " ",
        username: map['username'] ?? '',
        email: map['email'] ?? '',
        displayName: map['displayName'] ?? '',
        token: map['token'] ?? '',
        profilePicture: map['profilePicture'] ?? '',
        password: map['password'] ?? '',
        friendList: map['friendlist'] != null
            ? List<User>.from(map['friendlist']?.map((x) => User.fromMap(x)))
            : [],
        friendrequests: List<Map<String, dynamic>>.from(
            map['friendRequests']?.map((x) => Map<String, dynamic>.from(x))),
        sentrequests: List<Map<String, dynamic>>.from(
            map['sendRequests']?.map((x) => Map<String, dynamic>.from(x))));
  }
  User copyWith({
    String? username,
    String? id,
    String? email,
    String? displayName,
    String? token,
    String? profilePicture,
    String? password,
    List? friendList,
    List? friendrequests,
    List? sentrequests,
  }) {
    return User(
      username: username ?? this.username,
      id: id ?? this.id,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      token: token ?? this.token,
      profilePicture: profilePicture ?? this.profilePicture,
      password: password ?? this.password,
      friendList: friendList ?? this.friendList,
      friendrequests: friendrequests ?? this.friendrequests,
      sentrequests: sentrequests ?? this.sentrequests,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
