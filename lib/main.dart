import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';

import 'login_signup_page.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart'; // new

void main() async {
  // Modify from here...

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
  // ...to here.
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
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
      ),
      routes: <String, WidgetBuilder>{
        '/login_signup_page': (BuildContext context) => new MyLoginPage()
      },
    );
  }
}
