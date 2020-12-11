import 'package:flutter/material.dart';
import 'package:bankdatabase/centralBackend.dart';

class CreateCustomer extends StatefulWidget {
  @override
  _CreateCustomerState createState() => new _CreateCustomerState();
}

class _CreateCustomerState extends State<CreateCustomer> {
  final formKey = new GlobalKey<FormState>();

  @override
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
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              padding: EdgeInsets.only(bottom: 10.0),
              textColor: Colors.white,
              onPressed: () {},
              child: Icon(Icons.add),
              shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
            ),
          ],
        ),

        preferredSize: Size(MediaQuery.of(context).size.width, 60.0),
      ),
      body: Center(
        child: Container(

            child: Center(
              child: Container(
                alignment: Alignment(0, 0),
                margin: const EdgeInsets.fromLTRB(30, 30, 30, 30),
                child: ListView(
                  children: <Widget>[
                    Center(
                      child: Text(
                        'Bank Database',
                        style: TextStyle(
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.normal,
                            fontSize: 27.0,
                            color: Colors.black),
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    new Form(
                      key: formKey,
                      child: new Column(
                        children: <Widget>[
                          SingleChildScrollView(
                            child: Container(
                              padding: EdgeInsets.all(10),
                              child: TextFormField(
                                style: TextStyle(color: Colors.black),
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
                                  labelText: 'UserName',
                                  labelStyle: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SingleChildScrollView(
                            child: Container(
                              padding: EdgeInsets.all(10),
                              child: TextFormField(
                                style: TextStyle(color: Colors.black),
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
                                  labelText: 'Password',
                                  labelStyle: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 50,
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.black),
                        ),
                        textColor: Colors.black,
                        color: Colors.transparent,
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.normal,
                              fontSize: 18.0,
                              color: Colors.black),
                        ),
                        onPressed: () {
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

        ),
      ),
    );
  }

}

