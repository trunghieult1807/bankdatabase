import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: Container(
          padding: EdgeInsets.only(top: 30.0),
          child: Container(
            child: Center(
              child: Text(
                'Account',
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
        preferredSize: Size(MediaQuery.of(context).size.width, 60.0),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Log out'),
          onPressed: () => Phoenix.rebirth(context),
        ),
      ),
    );
  }
}
