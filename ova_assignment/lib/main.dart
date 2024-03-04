import 'package:flutter/material.dart';
import 'package:ova_assignment/auth/screens/auth_screen.dart';
import 'package:ova_assignment/auth/services/auth_services.dart';
import 'package:ova_assignment/models/user_model.dart';
import 'package:ova_assignment/providers/user_provider.dart';
import 'package:ova_assignment/user/screens/user_homescreen.dart';
import 'package:ova_assignment/user/widgets/bottom_bar.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => UserProvider())],
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  void initState() {
    // TODO: implement initState
    AuthServices().getdata(context);
    super.initState();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Provider.of<UserProvider>(context).user.token.isNotEmpty
          ? BottomBar()
          : AuthScreen(),
    );
  }
}
