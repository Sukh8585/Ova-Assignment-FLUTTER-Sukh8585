import 'package:flutter/material.dart';
import 'package:ova_assignment/searchUsers/screens/search_users.dart';
import 'package:ova_assignment/user/screens/user_homescreen.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _page = 0;
  void updatepage(int index) {
    setState(() {
      _page = index;
    });
  }

  List<Widget> pages = [
    HomeScreen(),
    Center(child: Text('2nd page')),
    Center(child: Text('3rd page')),
  ];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => SearchUsers()));
              },
              icon: Icon(
                Icons.add,
                size: 30,
                color: Colors.white,
              ))
        ],
      ),
      drawer: Drawer(),
      backgroundColor: Colors.black,
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        currentIndex: _page,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: updatepage,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.feed), label: 'feed'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'chats'),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), label: 'notifications')
        ],
      ),
    );
  }
}
