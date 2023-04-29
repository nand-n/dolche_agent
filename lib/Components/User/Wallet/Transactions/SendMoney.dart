import 'package:dio/dio.dart';
import 'package:dolche_agent/Components/User/Wallet/Transactions/Partials/QRScanner.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SendMoney extends StatefulWidget {
  const SendMoney({super.key});

  @override
  State<SendMoney> createState() => _SendMoneyState();
}

class _SendMoneyState extends State<SendMoney> {
  TextEditingController recipentController = TextEditingController();
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
                    "Send Money",
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
                    "Send Money",
                    style: GoogleFonts.abel(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: HexColor("282B4F"),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              color: HexColor("FFFFFF"),
              padding:
                  EdgeInsets.only(left: 28, right: 28, top: 28, bottom: 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "View Balance",
                      style: TextStyle(
                          color: HexColor("#41414A"),
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      alignment: Alignment.centerRight,
                      // margin: EdgeInsets.only(left: 139),
                      child: Image.asset("assets/images/🦆 icon _eye_.png"),
                    ),
                  )
                ],
              ),
            ),
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
                controller: recipentController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Recipent Phone No',
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
                  child: const Text('Send'),
                ),
                onPressed: () async {
                  try {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    String token = prefs.getString("token") ?? "";
                    String baseUrl =
                        'http://10.0.2.2:3001/api/wallet/p2ptransaction';
                    print(token + "Token");
                    double amount = double.parse(amountController.text);
                    String recipentPhone = recipentController.text;

                    final response = await Dio().post(
                      baseUrl,
                      data: {"amount": amount, "recipientPhone": recipentPhone},
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
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
