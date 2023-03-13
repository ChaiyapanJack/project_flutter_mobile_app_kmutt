import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:validators/validators.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class MySignUpPage extends StatefulWidget {
  MySignUpPage({key}) : super(key: key);

  @override
  _MySignUpPageState createState() => _MySignUpPageState();
}

class _MySignUpPageState extends State<MySignUpPage> {
  final formKey = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passconController = TextEditingController();
  late bool _sucess;
  late String _userEmail;

  void register() async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passconController.text,
      );
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      } else {
        Navigator.of(context).pop();
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Sign up", style: TextStyle(color: Colors.white)),
          backgroundColor: Color.fromARGB(255, 183, 236, 123),
        ),
        body: Container(
            color: Colors.green[50],
            child: Center(
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: LinearGradient(colors: [
                        Color.fromARGB(255, 255, 249, 196),
                        Colors.lightGreen
                      ])),
                  margin: EdgeInsets.all(32),
                  padding: EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      bildTextFieldEmailPassPasscon(),
                      buildButtonSignUp(context),
                    ],
                  )),
            )));
  }

  Widget buildButtonSignUp(BuildContext context) {
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
                  print('Tapped! Sign up');
                  if (formKey.currentState!.validate()) {
                    register();
                  }
                },
                child: Text(
                  "Sign up",
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

  Container bildTextFieldEmailPassPasscon() {
    var confirmPass;
    return Container(
      child: Form(
        key: formKey,
        child: Column(children: [
          Container(
            padding: EdgeInsets.all(12),
            margin: EdgeInsets.only(top: 12),
            decoration: BoxDecoration(
                color: Colors.yellow[50],
                borderRadius: BorderRadius.circular(16)),
            child: TextFormField(
              controller: emailController,
              decoration: InputDecoration.collapsed(hintText: "Email"),
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(fontSize: 18),
              validator: (value) {
                if (value == null ||
                    !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                        .hasMatch(value)) {
                  return "Enter Correct Email Address";
                } else {
                  return null;
                }
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(12),
            margin: EdgeInsets.only(top: 12),
            decoration: BoxDecoration(
                color: Colors.yellow[50],
                borderRadius: BorderRadius.circular(16)),
            child: TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration.collapsed(hintText: "Password"),
                style: TextStyle(fontSize: 18),
                validator: (value) {
                  confirmPass = value;
                  if (value == null || value.isEmpty) {
                    return "Please Enter New Password";
                  } else if (value.length < 8) {
                    return "Password must be atleast 8 characters long";
                  } else {
                    return null;
                  }
                }),
          ),
          Container(
            padding: EdgeInsets.all(12),
            margin: EdgeInsets.only(top: 12),
            decoration: BoxDecoration(
                color: Colors.yellow[50],
                borderRadius: BorderRadius.circular(16)),
            child: TextFormField(
              controller: passconController,
              obscureText: true,
              decoration: InputDecoration.collapsed(hintText: "Re-password"),
              style: TextStyle(fontSize: 18),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please Re-Enter New Password";
                } else if (value.length < 8) {
                  return "Password must be atleast 8 characters long";
                } else if (value != confirmPass) {
                  return "Password must be same as above";
                } else {
                  return null;
                }
              },
            ),
          ),
        ]),
      ),
    );
  }
}
