// import 'package:flutter/material.dart';

// class TransactionHistory extends StatefulWidget {
//   const TransactionHistory({super.key});

//   @override
//   State<TransactionHistory> createState() => _TransactionHistoryState();
// }

// class _TransactionHistoryState extends State<TransactionHistory> {
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:validators/validators.dart';

class TransactionHistoryWidget extends StatefulWidget {
  @override
  _TransactionHistoryWidgetState createState() =>
      _TransactionHistoryWidgetState();
}

class _TransactionHistoryWidgetState extends State<TransactionHistoryWidget> {
  List _transactions = [];
  bool _isLoading = false;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchTransactions();
  }

  Future<void> _fetchTransactions() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? "";
      String baseUrl = 'http://10.0.2.2:3001/api/wallet/transactionHistory';
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
          _isLoading = false;
          _transactions = response.data['transacts'];
        });
      } else {
        // CircularProgressIndicator();
        print(response.statusMessage);
      }
    } catch (e) {
      print(e);
      setState(() {
        _isLoading = false;
        // _errorMessage = 'Error fetching data'
        _errorMessage = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: _isLoading
            ? SpinKitChasingDots(
                color: Colors.blue,
                size: 50.0,
              )
            : _errorMessage.isNotEmpty
                ? Text(_errorMessage)
                : ListView.builder(
                    itemCount: _transactions.length,
                    itemBuilder: (context, index) {
                      var transaction = _transactions[index];
                      return ListTile(
                        leading: Icon(Icons.attach_money),
                        title: Text(transaction['type']),
                        // isThreeLine: true,
                        // subtitle: Text(transaction['createdAt']),
                        // subtitle: isDate(transaction['type']),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        subtitle: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(DateFormat.yMMMMd().add_jm().format(
                                DateTime.parse(transaction['createdAt']))),
                            // Text(DateFormat.yMMMMd().add_jm().format(DateTime.parse(transaction['createdAt']))),
                            Text(transaction['user']['username']),
                            // Text(transaction['agent']['name']),
                          ],
                        ),
                        // subtitle: Text(transaction['user']['username']),
                        trailing: Text('\$${transaction['amount']}'),
                      );
                    },
                  ),
      ),
    );
  }
}
