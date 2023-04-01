import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_flutter_mobile_app_kmutt/login_signup_page.dart';
import 'twitter_trand_page.dart';
import 'twiter_trand_calendar_page.dart';

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
        backgroundColor: Colors.green[50],
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
            child: Container(
          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Text("Hello   ${LoginUser}",
                  style: TextStyle(
                      fontSize: 33,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 2
                        ..color = Colors.green[400]!)),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 0),
              child: buildButtonMenuTrandTwitter(context),
            ),
            //Text(widget.user.email, style: TextStyle(fontSize: 16)),
          ]),
        )));
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

Widget buildButtonTwitterTrandCarlendar(BuildContext context) {
  return Container(
      constraints: BoxConstraints.expand(height: 60),
      // ignore: sort_child_properties_last

      child: Center(
        child: Container(
          child: Material(
            type: MaterialType.transparency,
            child: InkWell(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              onTap: () {
                print('Tapped! Twitter Trand canlendr');
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TwitterSearchPage()),
                );
              },
              child: Row(children: const <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Icon(
                    Icons.favorite_sharp,
                    color: Colors.lightBlue,
                    size: 40.0,
                    semanticLabel: 'Text to announce in accessibility modes',
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30),
                  child: Text(
                    "Twitter Trand",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16), color: Colors.orange[200]),
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(12));
}

Widget buildButtonMenuTrandTwitter(BuildContext context) {
  return Container(
      color: Colors.green[50],
      child: Center(
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(colors: [
                  Color.fromARGB(255, 246, 238, 163),
                  Colors.green
                ])),
            margin: EdgeInsets.all(32),
            padding: EdgeInsets.all(17),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                buildButtonTwitterTrandCarlendar(context),
              ],
            )),
      ));
}
