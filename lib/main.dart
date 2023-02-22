import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';

import 'login_signup_page.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_new
    return new MaterialApp(
        title: 'Flutter Login Demo',
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyLoginPage(
          key: null,
        ));
  }
}

// Platform  Firebase App Id
// android   1:509555505672:android:2e204e800624c6efbdefbd
// ios       1:509555505672:ios:4305232188a58fe2bdefbd