import 'package:dolche_agent/Components/Home.dart';
import 'package:dolche_agent/Components/Signin.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  // autoLogin() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   bool? loggedIn = prefs.getBool('loggedin');
  //   //   if (loggedIn == true) {
  //   //     return ();
  //   //   } else {
  //   //     return LoginScreen();
  //   //   }
  //   // }
  // }

  late final AnimationController _controller;
  bool _isLoggedIn = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: (5),
      ),
    );
    _checkLoginStatus();
  }

  void _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token") ?? "";

    setState(() {
      _isLoggedIn = token.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#133040'),
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            height: 114,
          ),
          Text(
            'Dolche',
            style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: HexColor('#FFFFFF')),
          ),
          SizedBox(
            height: 300,
          ),
          Container(
            width: 1000,
            // height: 600,
            // child: Image.asset("assets/Images/splash.png"),
            child: Lottie.network(
                // "https://assets8.lottiefiles.com/packages/lf20_o8btuiyj.json",
                "https://assets9.lottiefiles.com/packages/lf20_gxtah1wp.json",
                fit: BoxFit.fitWidth,
                controller: _controller,
                height: MediaQuery.of(context).size.height * 1,
                animate: true, onLoaded: (composition) {
              _controller
                ..duration = composition.duration
                // ..forward().whenComplete(() => Navigator.pushReplacement(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => FirstScrollScreen())));
                ..forward().whenComplete(() => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            _isLoggedIn ? Home() : LoginScreen())));
            }),
          ),
        ]),
      ),
    );
  }
}
