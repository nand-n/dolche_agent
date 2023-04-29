import 'package:dolche_agent/Components/User/Wallet/Services/Credit%20Score/CreditScore.dart';
import 'package:dolche_agent/Components/User/Wallet/Services/Credit/Credit.dart';
import 'package:dolche_agent/Components/User/Wallet/Services/Equb/Equb.dart';
import 'package:dolche_agent/Components/User/Wallet/Services/RCSaaS/RCSaaS.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class FinancialServices extends StatefulWidget {
  const FinancialServices({super.key});

  @override
  State<FinancialServices> createState() => _FinancialServicesState();
}

class _FinancialServicesState extends State<FinancialServices> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#F7F7F7"),
      body: SingleChildScrollView(
          child: Column(
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
                  "Dolche Pay",
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
          Card(
            child: Container(
              width: 343,
              height: 78,
              alignment: Alignment.center,
              child: Text(
                "Fiancial Service",
                style: GoogleFonts.openSans(
                    fontSize: 30,
                    color: HexColor("#282B4F"),
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            height: 51,
          ),
          Container(
            alignment: Alignment.center,
            child: Image.asset('assets/images/family.png'),
          ),
          SizedBox(
            height: 62,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Equb()));
                },
                child: Card(
                  margin: EdgeInsets.only(bottom: 12),
                  child: Column(children: [
                    Image.asset(
                      'assets/images/equb.png',
                      width: 180,
                      height: 80,
                    ),
                    Text(
                      'Equb',
                      style: GoogleFonts.openSans(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: HexColor("#41414A"),
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    )
                  ]),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Credit(),
                    ),
                  );
                },
                child: Card(
                  margin: EdgeInsets.only(bottom: 12),
                  child: Column(children: [
                    Image.asset(
                      'assets/images/credit.png',
                      width: 180,
                      height: 80,
                    ),
                    Text(
                      'Credit',
                      style: GoogleFonts.openSans(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: HexColor("#41414A"),
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    )
                  ]),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RCSaaS(),
                    ),
                  );
                },
                child: Card(
                  margin: EdgeInsets.only(bottom: 12),
                  child: Column(children: [
                    Image.asset(
                      'assets/images/rcsaas.png',
                      width: 180,
                      height: 80,
                    ),
                    Text(
                      'RCSaaS',
                      style: GoogleFonts.openSans(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: HexColor("#41414A"),
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    )
                  ]),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CreditScore()));
                },
                child: Card(
                  margin: EdgeInsets.only(bottom: 12),
                  child: Column(children: [
                    Image.asset(
                      'assets/images/creditscore.png',
                      width: 180,
                      height: 80,
                    ),
                    Text(
                      'Credit Score',
                      style: GoogleFonts.openSans(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: HexColor("#41414A"),
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    )
                  ]),
                ),
              ),
            ],
          )
        ],
      )),
    );
  }
}
