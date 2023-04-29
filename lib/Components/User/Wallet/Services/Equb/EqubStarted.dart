import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EqubStarted extends StatefulWidget {
  const EqubStarted({super.key});

  @override
  State<EqubStarted> createState() => _EqubStartedState();
}

class _EqubStartedState extends State<EqubStarted> {
  String Income = "";
  String legalAgreement = "";
  String equbPurpose = "";
  String userId = "";
  String equbID = "";
  String debt = "";
  String emplymnetStatus = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getEqubDetail();
  }

  void getEqubDetail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var activatedEqubId = prefs.getString('activatedEqubId');

    Dio dio = Dio();
    String baseUrl = 'http://10.0.2.2:3001/api/equb/activated-equb-detail';
    var Data = {
      "activatedEqubId": activatedEqubId,
    };
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
            (value) => {
              Income = value.data['activatedEqub']['income'],
              legalAgreement = value.data['activatedEqub']['']
            },
          );
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Text('The Equb Detail goes here '),
              padding: EdgeInsets.only(top: 50),
            ),
            Container(child: Text(Income)),
          ],
        ),
      ),
    );
  }
}
