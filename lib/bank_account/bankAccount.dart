import 'package:bankdatabase/bank_account/bankAccountBackend.dart';
import 'package:flutter/material.dart';
import 'package:bankdatabase/centralBackend.dart';
import 'package:flutter/cupertino.dart';

class BankAccount extends StatefulWidget {
  @override
  BankAccount(String code) {
    this.code = code;
  }

  String code;

  _BankAccount createState() => _BankAccount(code);
}

class _BankAccount extends State<BankAccount> {
  @override
  _BankAccount(String code) {
    this.code = code;
  }

  String code;

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: FutureBuilder(
            future: getAccountInfo(code),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Container(child: BankAccountResult(snapshot.data));
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }
}

class BankAccountResult extends StatefulWidget {
  @override
  BankAccountResult(AccountInfo accountInfo) {
    this.accountInfo = accountInfo;
  }

  AccountInfo accountInfo;

  _BankAccountResultState createState() =>
      new _BankAccountResultState(accountInfo);
}

class _BankAccountResultState extends State<BankAccountResult> {
  final formKey = new GlobalKey<FormState>();
  DateTime serve_date;

  @override
  _BankAccountResultState(AccountInfo accountInfo) {
    savingAccounts = accountInfo.saving;
    checkingAccounts = accountInfo.checking;
    loanAccounts = accountInfo.loan;
  }

  List<SavingAccountInfo> savingAccounts;
  List<CheckingAccountInfo> checkingAccounts;
  List<LoanAccountInfo> loanAccounts;

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit an App'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: new Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: PreferredSize(
          child: AppBar(
            centerTitle: true,
            flexibleSpace: Container(
              padding: EdgeInsets.only(top: 30.0),
              child: Container(
                child: Center(
                  child: Text(
                    'Account Information',
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
                    offset: Offset(0, 3),
                  ),
                ],
              ),
            ),
          ),
          preferredSize: Size(MediaQuery.of(context).size.width, 60.0),
        ),
        body: Container(
          margin: EdgeInsets.fromLTRB(30, 40, 30, 40),
          padding: EdgeInsets.fromLTRB(30, 40, 30, 40),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 25.0,
                ),
                Container(
                  child: Text(
                    'Saving Account',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'GoogleSans',
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  height: 25.0,
                ),
                if (savingAccounts.length == 0)
                  new Container(
                    //width: 400,
                    //margin: const EdgeInsets.all(15.0),
                    padding: const EdgeInsets.fromLTRB(30.0, 20, 30, 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(
                            width: 2.0, color: Color.fromRGBO(142, 7, 149, 1))),
                    child: Text("None"),
                  ),
                SizedBox(
                  height: 25.0,
                ),
                for (var saving in savingAccounts)
                  new Container(
                    //width: 400,
                    //margin: const EdgeInsets.all(15.0),
                    padding: const EdgeInsets.fromLTRB(30.0, 20, 30, 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(
                            width: 2.0, color: Color.fromRGBO(142, 7, 149, 1))),
                    child: SingleChildScrollView(
                      child: Column(children: <Widget>[
                        Text(
                          'Number: ' + saving.number,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'GoogleSans',
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Code: ' + saving.code.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'GoogleSans',
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Date: ' + saving.date.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'GoogleSans',
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Balance: ' + saving.balance.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'GoogleSans',
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Increase rate: ' + saving.insrate.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'GoogleSans',
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                            color: Colors.black,
                          ),
                        ),
                      ]),
                    ),
                  ),
                SizedBox(
                  height: 25.0,
                ),
                Container(
                  child: Text(
                    'Checking Account',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: 'GoogleSans',
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  height: 25.0,
                ),
                if (checkingAccounts.length == 0)
                  new Container(
                    //width: 400,
                    //margin: const EdgeInsets.all(15.0),
                    padding: const EdgeInsets.fromLTRB(30.0, 20, 30, 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(
                            width: 2.0, color: Color.fromRGBO(142, 7, 149, 1))),
                    child: Text("None"),
                  ),
                SizedBox(
                  height: 25.0,
                ),
                for (var checking in checkingAccounts)
                  new Container(
                    //width: 400,
                    //margin: const EdgeInsets.all(15.0),
                    padding: const EdgeInsets.fromLTRB(30.0, 20, 30, 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(
                            width: 2.0, color: Color.fromRGBO(142, 7, 149, 1))),
                    child: SingleChildScrollView(
                      child: Column(children: <Widget>[
                        Text(
                          'Number: ' + checking.number,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontFamily: 'GoogleSans',
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Code: ' + checking.code.toString(),
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontFamily: 'GoogleSans',
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Date: ' + checking.date.toString(),
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontFamily: 'GoogleSans',
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Balance: ' + checking.balance.toString(),
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontFamily: 'GoogleSans',
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                            color: Colors.black,
                          ),
                        ),
                      ]),
                    ),
                  ),
                SizedBox(
                  height: 25.0,
                ),
                Container(
                  child: Text(
                    'Loan',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: 'GoogleSans',
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  height: 25.0,
                ),
                if (loanAccounts.length == 0)
                  new Container(
                    //width: 400,
                    //margin: const EdgeInsets.all(15.0),
                    padding: const EdgeInsets.fromLTRB(30.0, 20, 30, 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(
                            width: 2.0, color: Color.fromRGBO(142, 7, 149, 1))),
                    child: Text("None"),
                  ),
                SizedBox(
                  height: 25.0,
                ),
                for (var loan in loanAccounts)
                  new Container(
                    //width: 400,
                    //margin: const EdgeInsets.all(15.0),
                    padding: const EdgeInsets.fromLTRB(30.0, 20, 30, 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(
                            width: 2.0, color: Color.fromRGBO(142, 7, 149, 1))),
                    child: SingleChildScrollView(
                      child: Column(children: <Widget>[
                        Text(
                          'Number: ' + loan.number,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontFamily: 'GoogleSans',
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Code: ' + loan.code.toString(),
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontFamily: 'GoogleSans',
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Date: ' + loan.date.toString(),
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontFamily: 'GoogleSans',
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Balance: ' + loan.balance.toString(),
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontFamily: 'GoogleSans',
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Increase rate: ' + loan.insrate.toString(),
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontFamily: 'GoogleSans',
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                            color: Colors.black,
                          ),
                        ),
                      ]),
                    ),
                  ),
                SizedBox(
                  height: 50.0,
                ),
                Container(
                  //height: 50,
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(color: Colors.white),
                    ),
                    textColor: Colors.white,
                    color: Colors.transparent,
                    child: Text(
                      'Done',
                      style: TextStyle(
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.normal,
                          fontSize: 18.0,
                          color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
