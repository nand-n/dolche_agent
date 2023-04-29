import 'package:dio/dio.dart';
import 'package:dolche_agent/Components/User/Wallet/Services/Equb/EqubStarted.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EqubActivation extends StatefulWidget {
  const EqubActivation({super.key});

  @override
  State<EqubActivation> createState() => _EqubActivationState();
}

class _EqubActivationState extends State<EqubActivation> {
  TextEditingController incomeController = TextEditingController();
  TextEditingController employmentStatusController = TextEditingController();
  TextEditingController debtController = TextEditingController();
  TextEditingController purpouseOfTheEqubController = TextEditingController();
  TextEditingController legalAgreementController = TextEditingController();

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
                    "Equb",
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
                  width: 390,
                  height: 90,
                  alignment: Alignment.center,
                  child: Text(
                    "Equb Activation",
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
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: incomeController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Income',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: employmentStatusController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Employment Status',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: debtController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Debt | NA for non Debt',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: purpouseOfTheEqubController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Purpouse of The Equb',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: legalAgreementController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Legal Agreemnet',
                ),
              ),
            ),
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
                      left: 130, right: 130, top: 20, bottom: 20),
                  child: const Text('Activate Equb'),
                ),
                onPressed: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  var selecetedEqub = "${prefs.getString("SelectedEqubId")}";
                  equbActivationRequest(
                      selecetedEqub,
                      incomeController.text,
                      employmentStatusController.text,
                      debtController.text,
                      purpouseOfTheEqubController.text,
                      legalAgreementController.text);
                  // print(nameController.text);
                  // print(passwordController.text);
                  // loginRequest(nameController.text, passwordController.text);
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => EqubStarted(),
                  //     ));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void equbActivationRequest(
      String equbId,
      String incomeController,
      String employmentStatusController,
      String debtController,
      String purpouseOfTheEqubController,
      String legalAgreementController) async {
    Dio dio = Dio();
    // String baseUrl = 'http://10.0.2.2:3001/api/equb/equb-activate';
    String baseUrl =
        'https://dolchebackend.onrender.com/api/equb/equb-activate';

    var Data = {
      "equbId": equbId,
      "emplymnetStatus": employmentStatusController,
      "debt": debtController,
      "income": incomeController,
      "legalAgreement": legalAgreementController,
      "equbPurpose": purpouseOfTheEqubController
    };
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    try {
      var response = await dio
          .post(
        baseUrl,
        data: Data,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            'Authorization': token,
          },
        ),
      )
          .then(
        (value) async {
          String activatedToken = value.data['Message']['id'];
          // print('Access Token : ${accessToken}');
          // print('Refresh Token : ${refreshToken}');

          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString("activatedEqubId", activatedToken);
          // print(prefs.getString("activatedEqubId"));
          return Navigator.push(
              context, MaterialPageRoute(builder: (context) => EqubStarted()));
        },
      );
    } catch (e) {
      print(e.toString());
    }
  }
}
