import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bankdatabase/login/loginScreen.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:bankdatabase/backend.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([]);
  // String user = "Manager3";
  // String pass = "12345643";
  // login(user, pass);
  //raw();
  runApp(
      Phoenix(
          child: MaterialApp(
              debugShowCheckedModeBanner: false,
              home: LoginScreen()
          )
      )
  );
}
