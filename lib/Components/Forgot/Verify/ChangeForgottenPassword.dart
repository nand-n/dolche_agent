import 'package:dio/dio.dart';
import 'package:dolche_agent/Components/Signin.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class ChangeForgotenPassword extends StatefulWidget {
  const ChangeForgotenPassword({super.key});

  @override
  State<ChangeForgotenPassword> createState() => _ChangeForgotenPasswordState();
}

class _ChangeForgotenPasswordState extends State<ChangeForgotenPassword> {
  TextEditingController tokenFromEmailController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

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
                        'Register To Dolche',
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
                    controller: tokenFromEmailController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Token We Send to Email',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: newPasswordController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'New Password',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: confirmPasswordController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Confirm New Password',
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
                      child: const Text('Change Password'),
                      onPressed: () {
                        // print(nameController.text);
                        // print(passwordController.text);
                        forgotPasswordRequest(tokenFromEmailController.text,
                            newPasswordController.text);
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => Homepage(),
                        //     ));
                      },
                    )),
              ],
            )));
  }

  void forgotPasswordRequest(
      String tokenFromEmailController, String token) async {
    Dio dio = Dio();
    String baseUrl = 'http://10.0.2.2:3001/password-changer';
    // String baseUrl = 'https://dolche-api.onrender.com/register';

    // var Data = {"email": "nahi@mail.com", "password": "nahi002"};
    var Data = {
      "tokenFromEmail": tokenFromEmailController,
      "password": newPasswordController,
    };
    // try {
    //   var response = await dio
    //       .post(
    //     baseUrl,
    //     data: Data,
    //     options: Options(
    //       headers: {"Content-Type": "application/json"},
    //     ),
    //   )
    //       .then(
    //     (value) {
    //       return Navigator.push(
    //           context, MaterialPageRoute(builder: (context) => LoginScreen()));
    //     },
    //   );
    // } catch (e) {
    //   print(e.toString());
    // }
    try {
      Response response = await dio.post(
        baseUrl,
        data: Data,
        options: Options(
          headers: {"Content-Type": "application/json"},
        ),
      );
      //handle The response
      if (response.statusCode == 200) {
        //Navigate to Login screen
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      } else {
        //display the response error message
        print('Response error: ${response.data}');
      }
    } catch (e) {
      // handle the error
      if (e is DioError) {
        // display the error message
        print('Dio error occurred: ${e.message}');

        // display the response message, if any
        if (e.response?.data != null) {
          print('Response data: ${e}');
        }
      } else {
        // handle other errors
        print('Error occurred: $e');
      }
    }
  }
}
