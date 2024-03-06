import 'package:flutter/material.dart';
import 'package:ova_assignment/models/user_model.dart';
import 'package:ova_assignment/providers/user_provider.dart';
import 'package:provider/provider.dart';

class RequestScreen extends StatefulWidget {
  RequestScreen({required this.context, super.key});
  BuildContext context;
  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  @override
  Widget build(BuildContext context) {
    User _user = Provider.of<UserProvider>(context, listen: true).user;
    return Container(
      padding: EdgeInsets.all(8),
      color: Colors.white,
      child: ListView.builder(
        itemCount:
            _user.friendrequests == null ? 0 : _user.friendrequests!.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            //! leading: Yaha photo dalo,
            title: Text(_user.friendrequests![index]['senderId']),
          );
        },
      ),
    );
  }
}
