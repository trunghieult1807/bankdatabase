import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bankdatabase/login/loginScreen.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

void main() {
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(
      Phoenix(
          child: MaterialApp(
              debugShowCheckedModeBanner: false,
              home: LoginScreen()
          )
      )
  );
}
