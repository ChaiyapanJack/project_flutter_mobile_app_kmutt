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
            child: Center(
                child:
                    Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Text("Hello   ${LoginUser}", style: TextStyle(fontSize: 26)),
          buildButtonTwitterTrand(context),
          buildButtonTwitterTrandCarlendar(context),
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

Widget buildButtonTwitterTrand(BuildContext context) {
  return Container(
      constraints: BoxConstraints.expand(height: 50),
      // ignore: sort_child_properties_last

      child: Center(
        child: Container(
          child: Material(
            type: MaterialType.transparency,
            child: InkWell(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              onTap: () {
                print('Tapped! Twitter Trand');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TodosScreen(
                            todos: List.generate(
                              20,
                              (i) => Todo(
                                'Todo $i',
                                'A description of what needs to be done for Todo $i',
                              ),
                            ),
                          )),
                );
              },
              child: Text(
                "Twitter Trand",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16), color: Colors.orange[200]),
      margin: EdgeInsets.only(top: 16),
      padding: EdgeInsets.all(12));
}

Widget buildButtonTwitterTrandCarlendar(BuildContext context) {
  return Container(
      constraints: BoxConstraints.expand(height: 50),
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
              child: Text(
                "Twitter Trand Calendar",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16), color: Colors.orange[200]),
      margin: EdgeInsets.only(top: 16),
      padding: EdgeInsets.all(12));
}
