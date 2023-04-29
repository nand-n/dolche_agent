import 'package:dio/dio.dart';
import 'package:dolche_agent/Components/User/Wallet/Services/Equb/EqubActivation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Equb extends StatefulWidget {
  const Equb({super.key});

  @override
  State<Equb> createState() => _EqubState();
}

class _EqubState extends State<Equb> {
  // List<String> _equbMonthlyPayments = [];
  var jsonList;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String token = prefs.getString("token") ?? "";

    // String baseUrl = 'http://10.0.2.2:3001/api/equb/equb-list';
    String baseUrl = 'https://dolchebackend.onrender.com/api/equb/equb-list';

    try {
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
          jsonList = response.data['equbLIst'] as List;
        });
      } else {
        CircularProgressIndicator();
        // print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }

    //   final equbList = response.data['equbLIst'];
    //   final equbMonthlyPayments = equbList
    //       .map((equb) => equb['equbMonthlyPayment'])
    //       .toList()
    //       .cast<String>();
    //   setState(() {
    //     _equbMonthlyPayments = equbMonthlyPayments;
    //   });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: jsonList == null ? 0 : jsonList.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              title: Text(jsonList[index]['equbName']),
              subtitle: Text(jsonList[index]['equbType']),
              trailing: Text(
                jsonList[index]['amount'],
                style: GoogleFonts.openSans(
                    fontSize: 22, fontWeight: FontWeight.bold),
              ),
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setString("SelectedEqubId", jsonList[index]['id']);
                // print(prefs.getString("SelectedEqubId"));
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EqubActivation()));
              },
            ),
          );
        },
      ),
      // body: SingleChildScrollView(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.start,
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       Container(
      //         margin: EdgeInsets.only(top: 52),
      //         padding: EdgeInsets.only(left: 24),
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.start,
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: [
      //             Image.asset("assets/images/back.png"),
      //             SizedBox(
      //               width: 119,
      //             ),
      //             Text(
      //               "Dolche Pay",
      //               style: GoogleFonts.abel(
      //                   fontSize: 28,
      //                   color: HexColor("#686C8E"),
      //                   fontWeight: FontWeight.bold),
      //             ),
      //           ],
      //         ),
      //       ),
      //       SizedBox(
      //         height: 19,
      //       ),
      //       Container(
      //         alignment: Alignment.center,
      //         child: Card(
      //           child: Container(
      //             width: 343,
      //             height: 78,
      //             alignment: Alignment.center,
      //             child: Text(
      //               "Equb",
      //               style: GoogleFonts.abel(
      //                 fontSize: 35,
      //                 fontWeight: FontWeight.bold,
      //                 color: HexColor("282B4F"),
      //               ),
      //             ),
      //           ),
      //         ),
      //       ),
      //       // ListViewWidget(
      //       //   jsonList: jsonList == null ? "" : jsonList,
      //       // )
      //       // Expanded(
      //       //   child: ListView.builder(
      //       //     itemCount: jsonList == null ? 0 : jsonList.length,
      //       //     itemBuilder: (BuildContext context, int index) {
      //       //       return Card(
      //       //         child: ListTile(
      //       //           title: Text(jsonList[index]['equbName']),
      //       //           subtitle: Text(jsonList[index]['amount']),
      //       //         ),
      //       //       );
      //       //     },
      //       //   ),
      //       // )
      //     ],
      //   ),
      // ),
    );
  }
}

class ListViewWidget extends StatelessWidget {
  const ListViewWidget({required this.jsonList, super.key});
  final String jsonList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarScreen(),
      body: jsonList == 0
          ? CircularProgressIndicator()
          : ListView.builder(
              itemCount: jsonList == null ? 0 : jsonList.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {},
                  child: Card(
                    child: ListTile(
                      title: Text(jsonList[index]),
                      subtitle: Text(jsonList[index]),
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class AppBarScreen extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;

  AppBarScreen({Key? key})
      : preferredSize = const Size.fromHeight(56.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'Equb List',
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () => Navigator.of(context).pop(),
      ),
      automaticallyImplyLeading: true,
    );
  }
}
