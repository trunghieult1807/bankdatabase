import 'package:flutter/material.dart';
import 'package:bankdatabase/centralBackend.dart';
import 'package:flutter/cupertino.dart';

class EditCustomer extends StatefulWidget {
  @override
  EditCustomer(CustomerInfo customer) {
    this.customer = customer;
  }

  CustomerInfo customer;

  _EditCustomerState createState() => new _EditCustomerState(customer);
}

class _EditCustomerState extends State<EditCustomer> {
  final formKey = new GlobalKey<FormState>();
  String fname, lname, code, email, home_addr, off_addr, emp_code, phone;
  DateTime serve_date;
  @override
  _EditCustomerState(CustomerInfo customer) {
    this.customer = customer;
  }

  CustomerInfo customer;

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
                            if(val == "") {
                              code = customer.code;
                            }
                            else code = val;
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
                            labelText: customer.code,
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
                            if(val == "") {
                              fname = customer.firstName;
                            }
                            else fname = val;
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
                            labelText: customer.firstName,
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
                            if(val == "") {
                              lname = customer.lastName;
                            }
                            else lname = val;
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
                            labelText: customer.lastName,
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
                    SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          style: TextStyle(color: Colors.black),
                          onSaved: (val) {
                            if(val == "") {
                              phone = customer.phoneNumber;
                            }
                            else phone = val;
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
                            labelText: customer.phoneNumber,
                            icon: Icon(Icons.phone),
                            labelStyle: TextStyle(
                              color: Colors.black,
                            ),
                          ),
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
                            if(val == "") {
                              email = customer.email;
                            }
                            else email = val;
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
                            labelText: customer.email,
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
                            if(val == "") {
                              home_addr = customer.home_addr;
                            }
                            else home_addr = val;
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
                            labelText: customer.home_addr,
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
                            if(val == "") {
                              off_addr = customer.off_addr;
                            }
                            else off_addr = val;
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
                            labelText: customer.off_addr,
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
                            if(val == "") {
                              emp_code = customer.emp_code;
                            }
                            else emp_code = val;
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
                            labelText: customer.emp_code,
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
                    Container(
                      height: 200,
                      child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.date,
                        initialDateTime: customer.serve_date,
                        onDateTimeChanged: (DateTime newDateTime) {
                          // Do something
                        },
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
