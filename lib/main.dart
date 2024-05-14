import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_x/screens/home.dart';
import 'package:user_x/utils.dart';

late SharedPreferences preferences;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  preferences = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User X',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: PRIMARY_COLOR),
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}

/*
SOME IMPORTANT NOTE:

Because of the device issue i couldn't complete some parts like testing, objectbox, etc.
However, I have implemented Shared Preferences as quick alternative to local storage.

Also, I admit the accessibility of the features and buttons are not better enough as i needed some time to think about
placing things in right places. But please judge me with these negative points.

I know it's not right, but I am attaching one of my recent projects for a client, which is entirely created by me,
that is published on the App Store
=> https://apps.apple.com/us/app/inside-edge-events/id6468079470?platform=iphone
*/