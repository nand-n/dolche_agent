import 'package:dio/dio.dart';
import 'package:dolche_agent/Components/Home.dart';
import 'package:dolche_agent/Components/Signin.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:validators/validators.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  // padding: const EdgeInsets.all(10),
                  padding: const EdgeInsets.only(
                      left: 92.92, right: 91.5, bottom: 56.37),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Register To Dolche Agent',
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            // fontStyle: FontStyle.normal,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: usernameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Agent Name',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: phoneController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Phone',
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
                SizedBox(
                  height: 30,
                ),
                Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(HexColor("282B4F"))),
                      child: const Text('Register'),
                      onPressed: () {
                        // print(nameController.text);
                        // print(passwordController.text);
                        loginRequest(
                            username: usernameController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                            password: passwordController.text,
                            context: context);
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => Homepage(),
                        //     ));
                      },
                    )),
                Row(
                  children: <Widget>[
                    const Text('Alredy have account?'),
                    TextButton(
                      child: const Text(
                        'Login',
                        style: TextStyle(fontSize: 16),
                      ),
                      onPressed: () {
                        //signup screen
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ],
            )));
  }

  // void loginRequest(
  //     String username, String email, String phone, String password) async {
  //   Dio dio = Dio();
  //   // String baseUrl = 'http://10.0.2.2:3001/register';
  //   // String baseUrl = 'https://dolche-api.onrender.com/register';
  //   String baseUrl = 'https://dolchebackend.onrender.com/register';

  //   // var Data = {"email": "nahi@mail.com", "password": "nahi002"};
  //   var Data = {
  //     "username": username,
  //     "email": email,
  //     "phone": phone,
  //     "password": password,
  //   };
  //   // SharedPreferences prefs = await SharedPreferences.getInstance();
  //   // var token = prefs.getString('token');
  //   try {
  //     var response = await dio
  //         .post(
  //       baseUrl,
  //       data: Data,
  //       options: Options(
  //         headers: {
  //           "Content-Type": "application/json",
  //           // 'Authorization': token,
  //         },
  //       ),
  //     )
  //         .then(
  //       (value) async {
  //         String accessToken = value.data['tokens']['accessToken'];
  //         // print('Access Token : ${accessToken}');
  //         // print('Refresh Token : ${refreshToken}');

  //         SharedPreferences prefs = await SharedPreferences.getInstance();
  //         prefs.setString("token", accessToken);

  //         return Navigator.push(
  //             context, MaterialPageRoute(builder: (context) => Home()));
  //       },
  //     );
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }
  void loginRequest({
    required String username,
    required String email,
    required String phone,
    required String password,
    required BuildContext context,
  }) async {
    final storage = FlutterSecureStorage();
    final dio = Dio();
    // final baseUrl = 'https://dolchebackend.onrender.com/register';
    // final baseUrl = 'https://dolchebackend.onrender.com/register';
    String baseUrl = 'http://10.0.2.2:3001/register-agent';

    if (!isEmail(email)) {
      // Show an error message if the email is not a valid format
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a valid email address')),
      );
      return;
    }

    // if (!isMobilePhone(phone, 'en-US')) {
    //   // Show an error message if the phone number is not a valid format
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text('Please enter a valid phone number')),
    //   );
    //   return;
    // }

    final data = {
      'username': username,
      'email': email,
      'phone': phone,
      'password': password,
    };

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      final response = await dio.post(
        baseUrl,
        data: data,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      final accessToken = response.data['tokens']['accessToken'];
      // await storage.write(key: 'accessToken', value: accessToken);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("token", accessToken);

      Navigator.pop(context); // Remove the progress bar dialog

      // Navigate to the Home screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    } on DioError catch (e) {
      String errorMessage = 'An error occurred';

      if (e.response?.statusCode == 401) {
        errorMessage = 'Invalid email or password';
      } else if (e.response?.statusCode == 409) {
        errorMessage = 'This email is already registered';
      } else if (e.response?.statusCode == 422) {
        errorMessage = 'Please fill in all the fields';
      }

      Navigator.pop(context); // Remove the progress bar dialog

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    } catch (e) {
      Navigator.pop(context); // Remove the progress bar dialog

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred')),
      );
    }
  }
}
