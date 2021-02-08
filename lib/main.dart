import 'package:clear/src/HomePage.dart';
import 'package:clear/src/Intropage.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      color: Colors.blue,
      home: Splash(),
    );
  }
}

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  Future firstScreen() async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    bool _seen = (preference.getBool('seen') ?? false);

    if (_seen) {
      // await preference.setBool('seen', false);
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new HomePage()));
    } else {
      await preference.setBool('seen', true);
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new Intropage()));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimeout(3000);
  }

  var timeout = const Duration(seconds: 5);
  var ms = const Duration(milliseconds: 1);

  startTimeout([int milliseconds]) {
    var duration = milliseconds == null ? timeout : ms * milliseconds;
    return new Timer(duration, firstScreen);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Text('Loading....'),
      ),
    );
  }

  // @override
  // void afterFirstLayout(BuildContext context) {
  //   // Calling the same function "after layout" to resolve the issue.
  //   firstScreen();
  // }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Hello'),
      ),
      body: new Center(
        child: new Text('This is the second page'),
      ),
    );
  }
}

class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('IntroScreen'),
      ),
      body: new Center(
        child: new Text('This is the IntroScreen'),
      ),
    );
  }
}
