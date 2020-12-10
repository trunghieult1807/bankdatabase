import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bankdatabase/login/loginScreen.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:bankdatabase/centralbackend.dart';

void main() {
  SystemChrome.setEnabledSystemUIOverlays([]);
  String username = 'truhee';
  String password = '23062002';
  login(username, password);
  runApp(
      Phoenix(
          child: MaterialApp(
              debugShowCheckedModeBanner: false,
              home: LoginScreen()
          )
      )
  );
}
