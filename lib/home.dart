import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_flutter_mobile_app_kmutt/login_signup_page.dart';

class MyHomePage extends StatefulWidget {
  //final Firebase user;

  MyHomePage();

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final data = ModalRoute.of(context)!.settings;
    print(data);
    late String LoginUser;

    LoginUser = data.arguments as String;

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("My Firebase App", style: TextStyle(color: Colors.white)),
          backgroundColor: Color.fromARGB(255, 183, 236, 123),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.logout_sharp),
                color: Colors.white,
                onPressed: () {
                  signOut(context);
                })
          ],
        ),
        body: Container(
            child: Center(
                child:
                    Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Text("Hello   ${LoginUser}", style: TextStyle(fontSize: 26)),
          //Text(widget.user.email, style: TextStyle(fontSize: 16)),
        ]))));
  }
}

void signOut(BuildContext context) {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  _auth.signOut();
  Navigator.of(context).pop();
  // Navigator.pop(
  //   context,
  //   MaterialPageRoute(builder: (context) => MyLoginPage()),
  // );
  // ModalRoute.withName('/'));
}
