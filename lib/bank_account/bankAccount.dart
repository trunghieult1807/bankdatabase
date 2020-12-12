import 'package:flutter/material.dart';
import 'package:bankdatabase/centralBackend.dart';
import 'package:flutter/cupertino.dart';

class BankAccount extends StatefulWidget {
  @override
  BankAccount(String code) {
    this.code = code;
  }
  String code;

  _BankAccountState createState() => new _BankAccountState(code);
}

class _BankAccountState extends State<BankAccount> {
  final formKey = new GlobalKey<FormState>();
  String fname, lname, code, email, home_addr, off_addr, emp_code, phone;
  DateTime serve_date;

  @override
  _BankAccountState(String code) {
    this.code = code;
  }

  Widget build(BuildContext context) {
    return Scaffold(
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
                  offset: Offset(0, 3),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              padding: EdgeInsets.only(bottom: 10.0),
              textColor: Colors.white,
              onPressed: () {
                final form = formKey.currentState;
                form.save();
                updateCustomer(code, fname, lname, email, home_addr, off_addr, emp_code, serve_date, phone);
                Navigator.of(context).pop(true);
              },
              child: Icon(Icons.save),
              shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
            ),
          ],
        ),
        preferredSize: Size(MediaQuery.of(context).size.width, 60.0),
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(30, 40, 30, 40),
        child: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Form(
                key: formKey,
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Text(
                        'Customer Code',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontFamily: 'GoogleSans',
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          style: TextStyle(color: Colors.black),
                          onSaved: (val) {

                          },
                          decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 1.0),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(10.0),
                              ),
                            ),
                            labelText: code,
                            icon: Icon(Icons.assignment_ind),
                            labelStyle: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        'First Name',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontFamily: 'GoogleSans',
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          style: TextStyle(color: Colors.black),
                          onSaved: (val){

                          },
                          decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 1.0),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(10.0),
                              ),
                            ),
                            labelText: code,
                            icon: Icon(Icons.article),
                            labelStyle: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        'Last Name',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontFamily: 'GoogleSans',
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          style: TextStyle(color: Colors.black),
                          onSaved: (val) {

                          },
                          decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 1.0),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(10.0),
                              ),
                            ),
                            labelText: code,
                            icon: Icon(Icons.article_outlined),
                            labelStyle: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        'Phone Number',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontFamily: 'GoogleSans',
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        'Email',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontFamily: 'GoogleSans',
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          style: TextStyle(color: Colors.black),
                          onSaved: (val) {

                          },
                          decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 1.0),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(10.0),
                              ),
                            ),
                            labelText: code,
                            icon: Icon(Icons.email),
                            labelStyle: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        'Home Address',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontFamily: 'GoogleSans',
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          style: TextStyle(color: Colors.black),
                          onSaved: (val) {

                          },
                          decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 1.0),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(10.0),
                              ),
                            ),
                            labelText: code,
                            icon: Icon(Icons.location_on),
                            labelStyle: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        'Office Address',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontFamily: 'GoogleSans',
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          style: TextStyle(color: Colors.black),
                          onSaved: (val) {

                          },
                          decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 1.0),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(10.0),
                              ),
                            ),
                            labelText: code,
                            icon: Icon(Icons.location_city),
                            labelStyle: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        'Employee Code',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontFamily: 'GoogleSans',
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          style: TextStyle(color: Colors.black),
                          onSaved: (val) {

                          },
                          decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 1.0),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(10.0),
                              ),
                            ),
                            labelText: code,
                            icon: Icon(Icons.code),
                            labelStyle: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        'Serve Date',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontFamily: 'GoogleSans',
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
