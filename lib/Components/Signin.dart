import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dolche_agent/Components/Forgot/Verify/forgotYourPassword.dart';
import 'package:dolche_agent/Components/Home.dart';
import 'package:dolche_agent/Components/Signup.dart';
// import 'package:endebete/Screens/Auth/Signup.dart';
// import 'package:endebete/Screens/Home/FeedScreen.dart';
// import 'package:endebete/Screens/Home/FeedScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:login/login.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Loginpage(),
    );
  }
}

class Loginpage extends StatefulWidget {
  const Loginpage({Key? key}) : super(key: key);

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
              padding:
                  EdgeInsets.only(top: 85, left: 135, right: 133, bottom: 12.6),
              child: Center(
                child: Image.asset(
                  'assets/images/login.png',
                  width: 200,
                  height: 200,
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              // padding: const EdgeInsets.all(10),
              padding: const EdgeInsets.only(
                  left: 92.92, right: 91.5, bottom: 56.37),
              child: Column(
                children: [
                  Text(
                    'Welcome Back to',
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        fontStyle: FontStyle.normal,
                        color: Colors.black),
                  ),
                  Text(
                    'Dolche Agent',
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        fontStyle: FontStyle.normal,
                        color: Colors.black),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Agent Name',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                //forgot password screen
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ForgotYourPassword()));
              },
              child: const Text(
                'Forgot Password',
              ),
            ),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(HexColor("282B4F"))),
                  child: const Text('Login'),
                  onPressed: () {
                    // print(nameController.text);
                    // print(passwordController.text);
                    loginRequest(nameController.text, passwordController.text);
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => Homepage(),
                    //     ));
                  },
                )),
            Row(
              children: <Widget>[
                const Text('Does not have account?'),
                TextButton(
                  child: const Text(
                    'Register',
                    style: TextStyle(fontSize: 16),
                  ),
                  onPressed: () {
                    //signup screen
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Signup()));
                  },
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ],
        ));
  }

  void loginRequest(String email, String password) async {
    Dio dio = Dio();
    // String baseUrl = 'https://dolchebackend.onrender.com/signin';
    String baseUrl = 'http://10.0.2.2:3001/signin-agent';

    // String baseUrl = 'https://dolche-api.onrender.com/signin';

    var Data = {"agentName": email, "password": password};
    try {
      var response = await dio
          .post(
        baseUrl,
        data: Data,
        options: Options(
          headers: {"Content-Type": "application/json"},
        ),
      )
          .then(
        (value) async {
          // String refreshToken = value.data['tokens']['refreshToken'];
          String accessToken = value.data['tokens']['accessToken'];
          // print('Access Token : ${accessToken}');
          // print('Refresh Token : ${refreshToken}');

          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString("token", accessToken);

          return Navigator.push(
              context, MaterialPageRoute(builder: (context) => Home()));
        },
      );
    } catch (e) {
      print(e);
    }
  }
}
