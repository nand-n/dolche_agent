import 'package:dio/dio.dart';
import 'package:dolche_agent/Components/User/Wallet/Services/FinancialSurvices.dart';
import 'package:dolche_agent/Components/User/Wallet/Transactions/DepositeCash.dart';
import 'package:dolche_agent/Components/User/Wallet/Transactions/RecievePayment.dart';
import 'package:dolche_agent/Components/User/Wallet/Transactions/SendMoney.dart';
import 'package:dolche_agent/Components/User/Wallet/Transactions/WithdrawMoney.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainProducts extends StatefulWidget {
  const MainProducts({super.key});

  @override
  State<MainProducts> createState() => _MainProductsState();
}

class _MainProductsState extends State<MainProducts> {
  String _balance = "";

  bool _balanceVisible = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.only(top: 40),
      child: SingleChildScrollView(
        child: Column(children: [
          Card(
            elevation: 8.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                color: HexColor("#282B4F"),
              ),
              width: double.infinity,
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 38.0,
                        height: 38.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(
                              'https://via.placeholder.com/48x48.png?text=Logo',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 16.0),
                      Text(
                        'Dolche',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24.0,
                          color: Colors.white,
                        ),
                      ),
                      Expanded(child: Container()),
                      Row(
                        children: [
                          Text(
                            'Balance:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 8.0),
                          // Text(
                          //   '\$200',
                          //   style: TextStyle(
                          //     fontWeight: FontWeight.bold,
                          //     fontSize: 20.0,
                          //     color: Colors.white,
                          //   ),
                          // ),
                          Text(
                            // _balanceVisible ? '\$200' : '***',

                            _balanceVisible ? _balance.toString() : '***',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),

                          SizedBox(width: 8.0),
                          // Icon(Icons.remove_red_eye, color: Colors.white),
                          IconButton(
                            icon: _balanceVisible
                                ? Icon(Icons.visibility_off,
                                    color: Colors.white)
                                : Icon(Icons.visibility, color: Colors.white),
                            onPressed: () async {
                              setState(() {
                                _balanceVisible = !_balanceVisible;
                              });
                              try {
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                String token = prefs.getString("token") ?? "";
                                String baseUrl =
                                    'http://10.0.2.2:3001/api/wallet/balance';
                                print(token + "Token");

                                final response = await Dio().post(
                                  baseUrl,
                                  options: Options(
                                    headers: {
                                      "Content-Type": "application/json",
                                      'Authorization': token,
                                    },
                                  ),
                                );
                                if (response.statusCode == 200) {
                                  setState(() {
                                    _balance = response.data.toString();
                                  });
                                } else {
                                  // CircularProgressIndicator();
                                  print(response.statusMessage);
                                }
                              } catch (e) {
                                print(e);
                              }
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Cardholder Name',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'John Doe',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 24.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Expiry Date',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            '12/24',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'CVV',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Row(
                            children: [
                              Text(
                                '***',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: 8.0),
                              Icon(Icons.credit_card, color: Colors.white),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 35,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircleAvatar(
                // backgroundImage: NetworkImage(
                //     'https://images.pexels.com/photos/3992186/pexels-photo-3992186.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=80'),
                radius: 33,
              ),
              CircleAvatar(
                // backgroundImage: NetworkImage(
                //     'https://images.pexels.com/photos/1005956/pexels-photo-1005956.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=80'),
                radius: 33,
              ),
              CircleAvatar(
                // backgroundImage: NetworkImage(
                //     'https://images.pexels.com/photos/8197930/pexels-photo-8197930.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=80'),
                radius: 33,
              ),
              CircleAvatar(
                // backgroundImage: NetworkImage(
                //     'https://images.pexels.com/photos/1056700/pexels-photo-1056700.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=80'),
                radius: 33,
              ),
              CircleAvatar(
                // backgroundImage: NetworkImage(
                //     'https://images.pexels.com/photos/1056710/pexels-photo-1056710.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=80'),
                radius: 33,
              ),
            ],
          ),
          SizedBox(
            height: 35,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  //Withdraw screen
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => DepositeCash()));
                },
                child: Container(
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/deposite.png',
                            width: 144,
                            height: 86,
                          ),
                          Text(
                            "Deposite Cash",
                            style: GoogleFonts.openSans(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: HexColor("#41414A")),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  print(prefs.remove("token"));
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Withdraw()));
                },
                child: Container(
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/withdraw.png',
                            width: 144,
                            height: 86,
                          ),
                          Text(
                            "Withdraw Cash",
                            style: GoogleFonts.openSans(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: HexColor("#41414A")),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SendMoney()));
                },
                child: Container(
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/sendmoney.png',
                            width: 144,
                            height: 86,
                          ),
                          Text(
                            "Send Money",
                            style: GoogleFonts.openSans(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: HexColor("#41414A")),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  //Withdraw screen
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FinancialServices()));
                },
                child: Container(
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/fiancialservice.png',
                            width: 144,
                            height: 86,
                          ),
                          Text(
                            "Fiancial Service",
                            style: GoogleFonts.openSans(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: HexColor("#41414A")),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 15,
          ),
          SizedBox(
            height: 15,
          ),
        ]),
      ),
    ));
  }
}
