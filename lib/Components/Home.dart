import 'package:dolche_agent/Components/MainProducts.dart';
import 'package:dolche_agent/Components/Profile.dart';
import 'package:dolche_agent/Components/Settings.dart';
import 'package:dolche_agent/Components/User/Wallet/Services/FinancialSurvices.dart';
import 'package:dolche_agent/Components/User/Wallet/Transactions/DepositeCash.dart';
import 'package:dolche_agent/Components/User/Wallet/Transactions/RecievePayment.dart';
import 'package:dolche_agent/Components/User/Wallet/Transactions/SendMoney.dart';
import 'package:dolche_agent/Components/User/Wallet/Transactions/TransactionHistory.dart';
import 'package:dolche_agent/Components/User/Wallet/Transactions/WithdrawMoney.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Transaction {
  final String title;
  final double amount;
  final DateTime date;

  Transaction({
    required this.title,
    required this.amount,
    required this.date,
  });
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Transaction> transactions = [
    Transaction(title: 'Groceries', amount: 55.0, date: DateTime.now()),
    Transaction(title: 'Gas', amount: 30.0, date: DateTime.now()),
    Transaction(title: 'Dinner', amount: 75.0, date: DateTime.now()),
  ];
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    // Text('Home Page'),
    // Text('Search Page'),
    // Text('Profile Page'),
    MainProducts(),
    TransactionHistoryWidget(),
    Settings(),
    Profile(),
  ];

  void _onItemTapped(int index) async {
    setState(() {
      _selectedIndex = index;
    });
    //  Navigator.push(context, MaterialPageRoute(builder: (context)=> ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: Bot,
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: HexColor("#686C8E"),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  // color: Color(0xAA282B4F),
                ),
                label: "Home",
                // activeIcon: Icon(Icons.abc),
                backgroundColor: Color(0xAA9C9DAC)),
            BottomNavigationBarItem(
                icon: Icon(Icons.payment_sharp), label: "Transactions"),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: "Settings"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Account")
          ],
          currentIndex: _selectedIndex,
          // selectedItemColor: Colors.blue,
          selectedItemColor: HexColor('282B4F'),

          onTap: _onItemTapped,
        ),
        backgroundColor: HexColor("F7F7F7"),
        //
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ));
  }
}
