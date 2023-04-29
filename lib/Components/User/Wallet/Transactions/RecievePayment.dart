import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class RecieveMoney extends StatefulWidget {
  const RecieveMoney({super.key});

  @override
  State<RecieveMoney> createState() => _RecieveMoneyState();
}

class _RecieveMoneyState extends State<RecieveMoney> {
  TextEditingController agentIdController = TextEditingController();
  TextEditingController amountController = TextEditingController();
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
                    "Recieve Payment",
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
                    "Recieve Payment",
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
                controller: agentIdController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'From Phone No',
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
                  child: const Text('Recieve Payment'),
                ),
                onPressed: () {
                  // print(nameController.text);
                  // print(passwordController.text);
                  // loginRequest(nameController.text, passwordController.text);
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => Homepage(),
                  //     ));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
