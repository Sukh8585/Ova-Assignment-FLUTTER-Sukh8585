import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:ova_assignment/commons/common_widgets.dart';
import 'package:ova_assignment/models/user_model.dart';
import 'package:ova_assignment/providers/user_provider.dart';
import 'package:ova_assignment/searchUsers/services/search_services.dart';
import 'package:provider/provider.dart';

class SearchUsers extends StatefulWidget {
  const SearchUsers({super.key});

  @override
  State<SearchUsers> createState() => _SearchUsersState();
}

class _SearchUsersState extends State<SearchUsers> {
  TextEditingController _searchcontroller = TextEditingController();
  List<User>? userList;
  bool isSearching = false;
  bool isfollowing = false;
  @override
  Widget build(BuildContext context) {
    User _user = Provider.of<UserProvider>(context, listen: true).user;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          backgroundColor: Colors.black,
          title: Container(
              decoration: BoxDecoration(
                  color: Colors.grey,
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10)),
              width: 250,
              child: Center(
                  child: TextFormField(
                controller: _searchcontroller,
                onFieldSubmitted: (value) async {
                  setState(() {
                    isSearching = true;
                  });
                  userList = await SearchServices()
                      .findNewFrieds(value: value, context: context);
                  setState(() {
                    isSearching = false;
                  });
                },
                decoration: InputDecoration(
                    prefixIconConstraints: BoxConstraints(maxWidth: 30),
                    prefixIcon: InkWell(
                      child: Icon(
                        Icons.search,
                      ),
                    ),
                    labelText: 'search username ',
                    contentPadding: EdgeInsets.symmetric(horizontal: 5)),
              )))),
      body: userList == null
          ? Center(
              child: Text(
                'search to see users here',
                style: TextStyle(color: Colors.white),
              ),
            )
          : isSearching
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : userList!.isEmpty
                  ? Center(
                      child: Text(
                        'oops!! no users available with this name',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  : ListView.builder(
                      itemCount: userList!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                            title: Text(
                              userList![index].username,
                              style: TextStyle(color: Colors.white),
                            ),
                            trailing: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                        _user.sentrequests!.any((element) =>
                                                element['requestedUserId'] ==
                                                userList![index].id)
                                            ? Colors.grey
                                            : Colors.blue)),
                                onPressed: () async {
                                  //! create the api for unfollowing the user and also canceling a request

                                  _user.sentrequests!.any((element) =>
                                          element['requestedUserId'] ==
                                          userList![index].id)
                                      ? await SearchServices().cancelrequest(
                                          context, userList![index].id)
                                      : await SearchServices().sendrequested(
                                          context, userList![index].id);

                                  setState(() {});
                                },
                                child: _user.sentrequests!.any((element) =>
                                        element['requestedUserId'] ==
                                        userList![index].id)
                                    ? Text(
                                        'Requested',
                                      )
                                    : !_user.friendList!.any((e) =>
                                            e['id'] == userList![index].id)
                                        ? Text(
                                            'Follow',
                                            style:
                                                TextStyle(color: Colors.white),
                                          )
                                        : Text("Unfollow")));
                      },
                    ),
    );
  }
}
