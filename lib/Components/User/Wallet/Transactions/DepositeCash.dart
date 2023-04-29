import 'package:dio/dio.dart';
import 'package:dolche_agent/Components/User/Wallet/Transactions/Partials/QRScanner.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DepositeCash extends StatefulWidget {
  const DepositeCash({super.key});

  @override
  State<DepositeCash> createState() => _DepositeCashState();
}

class _DepositeCashState extends State<DepositeCash> {
  TextEditingController agentPhoneController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  Color _cardColorAgent = HexColor("ECECF2");
  Color _cardColorBank = HexColor("ECECF2");

  Color _whiteColor = HexColor("FFFFFF");
  Color _grayColor = HexColor("ECECF2");

  void _changeColorAgnet() {
    final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
    QRViewController? controller;

    setState(() {
      if (_cardColorAgent == _grayColor) {
        _cardColorAgent = _whiteColor; // set the color to white
      } else {
        _cardColorAgent = _grayColor; // set the color to gray
      }
    });
  }

  void _changeColorbank() {
    setState(() {
      if (_cardColorBank == _grayColor) {
        _cardColorBank = _whiteColor; // set the color to white
      } else {
        _cardColorBank = _grayColor; // set the color to gray
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 52),
              padding: EdgeInsets.only(left: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset("assets/images/back.png"),
                  SizedBox(
                    width: 119,
                  ),
                  Text(
                    "Deposite for User",
                    style: GoogleFonts.abel(
                        fontSize: 28,
                        color: HexColor("#686C8E"),
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 19,
            ),
            Container(
              alignment: Alignment.center,
              child: Card(
                child: Container(
                  width: 343,
                  height: 78,
                  alignment: Alignment.center,
                  child: Text(
                    "Deposite Cash for User",
                    style: GoogleFonts.abel(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: HexColor("282B4F"),
                    ),
                  ),
                ),
              ),
            ),
            // Container(
            //   padding: EdgeInsets.only(right: 10, left: 10),
            //   alignment: Alignment.center,
            //   decoration: BoxDecoration(color: HexColor("ECECF2")),
            // child: Container(
            //   // padding: EdgeInsets.all(10/),
            //   width: 300,
            //   height: 66,
            //   child:
            //     Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            //   InkWell(
            //     onTap: _changeColorAgnet,
            //     child: Card(
            //       color: _cardColorAgent,
            //       child: Container(
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.start,
            //           children: [
            //             Image.asset(
            //               'assets/images/agent.png',
            //               width: 80,
            //               // height: 36,
            //             ),
            //             Text("Agent")
            //           ],
            //         ),
            //       ),
            //     ),
            //   ),
            //   SizedBox(
            //     width: 5,
            //   ),
            //   InkWell(
            //     onTap: _changeColorbank,
            //     child: Card(
            //       color: _cardColorAgent,
            //       child: Container(
            //         // decoration:
            //         //     BoxDecoration(color: HexColor("9C9DAC")),
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.start,
            //           crossAxisAlignment: CrossAxisAlignment.center,
            //           children: [
            //             Image.asset(
            //               'assets/images/bank.png',
            //               width: 80,
            //               // height: 36,
            //             ),
            //             Text("Bank")
            //           ],
            //         ),
            //       ),
            //     ),
            //   )
            // ]),
            // ),
            // ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: amountController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Amount',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: agentPhoneController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'User Phone',
                ),
              ),
            ),
            // Container(
            //   alignment: Alignment.center,
            //   child: SizedBox(
            //     height: 300.0,
            //     width: 300.0,
            //     child: QRScannerView(),
            //   ),
            // ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 20),
              // padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(HexColor("282B4F"))),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 125, right: 125, top: 20, bottom: 20),
                    child: const Text('Deposite'),
                  ),
                  onPressed: () async {
                    try {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      String token = prefs.getString("token") ?? "";
                      String baseUrl =
                          'http://10.0.2.2:3001/api/wallet/userDepositeByAgent';
                      print(token + "Token");
                      double amount = double.parse(amountController.text);
                      String agentPhone = agentPhoneController.text;

                      final response = await Dio().post(
                        baseUrl,
                        data: {"amount": amount, "agentPhone": agentPhone},
                        options: Options(
                          headers: {
                            "Content-Type": "application/json",
                            'Authorization': token,
                          },
                        ),
                      );
                      if (response.statusCode == 200) {
                        // setState(() {
                        //   _transactions = response.data['transacts'];
                        // });
                      } else {
                        // CircularProgressIndicator();
                        print(response.statusMessage);
                      }
                    } catch (e) {
                      print(e);
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
