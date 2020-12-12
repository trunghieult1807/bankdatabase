import 'package:flutter/material.dart';
import 'package:bankdatabase/home/createCustomer.dart';
import 'package:bankdatabase/centralBackend.dart';
import 'package:bankdatabase/search/searchScreen.dart';
import 'package:bankdatabase/search/editCustomer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: PreferredSize(
          child: AppBar(
            centerTitle: true,
            flexibleSpace: Container(
              padding: EdgeInsets.only(top: 30.0),
              child: Container(
                child: Center(
                  child: Text(
                    'Home',
                    style: TextStyle(
                      fontFamily: 'GoogleSans',
                      fontWeight: FontWeight.normal,
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color.fromRGBO(36, 11, 90, 0.9),
                    const Color.fromRGBO(142, 7, 149, 0.9),
                  ],
                  tileMode: TileMode.repeated,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                padding: EdgeInsets.only(bottom: 10.0),
                textColor: Colors.white,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CreateCustomer()));
                },
                child: Icon(Icons.add),
                shape:
                    CircleBorder(side: BorderSide(color: Colors.transparent)),
              ),
            ],
          ),
          preferredSize: Size(MediaQuery.of(context).size.width, 60.0),
        ),
        body: FutureBuilder(
            future: generateHomeUser(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Container(
                    child: Center(
                  child: ListView(
                    children: [
                      for (var customer in snapshot.data)
                        FlatButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          EditCustomer(customer)));
                            },
                            child: CustomerInfoView(customer))
                    ],
                  ),
                ));
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    ));
  }

}

Future<List<CustomerInfo>> generateHomeUser() async {
  await Future.delayed(Duration(seconds: 1));
  List<CustomerInfo> finalResults = [];
  List<String> codes = [];
  for (var i = 0; i < 10; i++) {
    codes.add("cus000" + i.toString());
  }
  for (final code in codes) {
    List<List<dynamic>> results = await connection.query(
        "SELECT fname, lname, code, email, home_addr, off_addr, emp_code, serve_date FROM Customer WHERE code = @query",
        substitutionValues: {"query": code});
    for (final row in results) {
      List<List<dynamic>> phoneNumbers = await connection.query(
          "SELECT phone FROM Customer_phone WHERE cust_code = @code",
          substitutionValues: {"code": row[2]});
      List<String> fuckDart = [];
      for (final value in phoneNumbers) {
        fuckDart.add(value[0]);
      }
      finalResults.add(CustomerInfo(row[0], row[1], fuckDart, row[2], row[3],
          row[4], row[5], row[6], row[7]));
    }
  }
  return finalResults;
}
