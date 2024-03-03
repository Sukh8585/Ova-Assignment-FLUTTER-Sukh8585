// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  final String username;
  final String email;
  final String displayName;
  final String token;
  final String profilePicture;
  final String password;

  User(
      {required this.username,
      required this.email,
      required this.displayName,
      required this.token,
      required this.profilePicture,
      required this.password});
  //! Uncomment
  // final List<String> friendList; // Assuming friendList is a list of user IDs or usernames
  // final List<String> friendRequests; // Assuming friendRequests is a list of user IDs or usernames

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'email': email,
      'displayName': displayName,
      'token': token,
      'profilePicture': profilePicture,
      'password': password
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      displayName: map['displayName'] ?? '',
      token: map['token'] ?? '',
      profilePicture: map['profilePicture'] ?? '',
      password: map['password'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
