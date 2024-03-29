import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_flutter_mobile_app_kmutt/home.dart';
import 'package:project_flutter_mobile_app_kmutt/signup_page.dart';
import 'package:firebase_core/firebase_core.dart';

class MyLoginPage extends StatefulWidget {
  MyLoginPage({key}) : super(key: key);

  @override
  _MyLoginPageState createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  signIn() {
    _auth
        .signInWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim())
        .then((user) {
      print("signed in By ${emailController.text.trim()}");
      print((emailController.text.trim()).indexOf('@'));
      var user_name = ((emailController.text.trim())
          .substring(0, (emailController.text.trim()).indexOf('@')));
      Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => MyHomePage(),
            settings: RouteSettings(
              arguments: user_name,
            )),
      );
    }).catchError((error) {
      print(error.message);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(error.message, style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.red));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
          appBar: AppBar(
            title:
                Text("My Firebase App", style: TextStyle(color: Colors.white)),
            backgroundColor: Color.fromARGB(255, 183, 236, 123),
          ),
          body: Container(
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
                    padding: EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        buildTextFieldEmail(),
                        buildTextFieldPassword(),
                        buildButtonSignIn(context),
                        buildOtherLine(),
                        buildButtonRegister(context),
                      ],
                    )),
              ))),
    );
  }

  Widget buildButtonSignIn(BuildContext context) {
    return Container(
        constraints: BoxConstraints.expand(height: 50),
        child: Center(
          child: Container(
            child: Material(
              type: MaterialType.transparency,
              child: InkWell(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                onTap: () {
                  print('Tapped! Sigin');
                  signIn();
                },
                child: Text(
                  "Sign in",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ),
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16), color: Colors.green[200]),
        margin: EdgeInsets.only(top: 16),
        padding: EdgeInsets.all(12));
  }

  Container buildTextFieldEmail() {
    return Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.yellow[50], borderRadius: BorderRadius.circular(16)),
        child: TextField(
            controller: emailController,
            decoration: InputDecoration.collapsed(hintText: "Email"),
            style: TextStyle(fontSize: 18)));
  }

  Container buildTextFieldPassword() {
    return Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(top: 12),
        decoration: BoxDecoration(
            color: Colors.yellow[50], borderRadius: BorderRadius.circular(16)),
        child: TextField(
            controller: passwordController,
            obscureText: true,
            decoration: InputDecoration.collapsed(hintText: "Password"),
            style: TextStyle(fontSize: 18)));
  }
}

Widget buildOtherLine() {
  return Container(
      margin: EdgeInsets.only(top: 16),
      child: Row(children: <Widget>[
        Expanded(child: Divider(color: Colors.green[800])),
        Padding(
            padding: EdgeInsets.all(6),
            child: Text("Don’t have an account?",
                style: TextStyle(color: Colors.black87))),
        Expanded(child: Divider(color: Colors.green[800])),
      ]));
}

Widget buildButtonRegister(BuildContext context) {
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
                print('Tapped! Register');
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MySignUpPage()),
                );
              },
              child: Text(
                "Register",
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
