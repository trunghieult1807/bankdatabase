import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:bankdatabase/login/delayed_animation.dart';
import 'package:bankdatabase/home/mainScreen.dart';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  final int delayedAmount = 500;
  double _scale;
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 20,
      ),
    )..addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final color = Colors.white;
    _scale = 1 - _controller.value;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        //backgroundColor: ,
        body: Container(
          decoration: new BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color.fromRGBO(36, 11, 90, 0.9),
                const Color.fromRGBO(142, 7, 149, 0.9),
              ],
              tileMode:
              TileMode.repeated,
            ),
          ),
          child: Center(
            child: Container(
              margin: const EdgeInsets.all(10.0),
              //color: Colors.blue,
              width: 300.0,
              height: 670.0,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    AvatarGlow(
                      endRadius: 110,
                      duration: Duration(milliseconds: 2000),
                      glowColor: Colors.white24,
                      repeat: true,
                      repeatPauseDuration: Duration(seconds: 2),
                      startDelay: Duration(seconds: 1),
                      child: Material(
                          elevation: 8.0,
                          shape: CircleBorder(),
                          child: CircleAvatar(
                            backgroundColor: Colors.grey[100],
                            child: Image.asset(
                              'images/logo.png',
                            ),
                            radius: 50.0,
                          )),
                    ),
                    DelayedAnimation(
                      child: Text(
                        "Assignment 2",
                        style: TextStyle(
                            fontFamily: 'GoogleSans',
                            fontWeight: FontWeight.normal,
                            fontSize: 16.0,
                            color: color),
                      ),
                      delay: delayedAmount + 500,
                    ),
                    DelayedAnimation(
                      child: Text(
                        "Database Management Systems",
                        style: TextStyle(
                            fontFamily: 'GoogleSans',
                            fontWeight: FontWeight.normal,
                            fontSize: 16.0,
                            color: color),
                      ),
                      delay: delayedAmount + 500,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    DelayedAnimation(
                      child: Text(
                        "Bank Database".toUpperCase(),
                        style: TextStyle(
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.bold,
                            fontSize: 35.0,
                            color: color),
                      ),
                      delay: delayedAmount + 500,
                    ),
                    SizedBox(
                      height: 150.0,
                    ),
                    DelayedAnimation(
                      child: GestureDetector(
                        // onTapDown: _onTapDown,
                        // onTapUp: _onTapUp,
                        onTap: () {
                          showSignIn(context);
                        },
                        child: Transform.scale(
                          scale: _scale,
                          child: _signInButtonMain,
                        ),
                      ),
                      delay: delayedAmount + 700,
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget get _signInButtonMain => Container(
    height: 60,
    width: 250,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(100.0),
      color: Colors.white,
    ),
    child: Center(
      child: Icon(
        Icons.arrow_forward,
        color: Color.fromRGBO(36, 11, 90, 0.9),
        size: 35,
      ),
    ),
  );

  void showSignIn(BuildContext context) {
    TextEditingController userNameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Container(
          margin: const EdgeInsets.only(
              left: 40.0, right: 40.0, bottom: 120.0, top: 120.0),
          child: Material(
            color: Colors.transparent, //Color.fromRGBO(255, 255, 255, 0.5),
            child: Center(
              child: Container(
                alignment: Alignment(0, 0),
                margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    Center(
                      child: Text(
                        'Database Systems',
                        style: TextStyle(
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.normal,
                            fontSize: 27.0,
                            color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          style: TextStyle(color: Colors.white),
                          controller: userNameController,
                          decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 1.0),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(10.0),
                              ),
                            ),
                            labelText: 'User Name',
                            labelStyle: TextStyle(
                              color: Colors.white70,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          style: TextStyle(color: Colors.white),
                          obscureText: true,
                          controller: passwordController,
                          decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 1.0),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(10.0),
                              ),
                            ),
                            labelText: 'Password',
                            labelStyle: TextStyle(
                              color: Colors.white70,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    FlatButton(
                      onPressed: () {
                        //forgot password screen
                      },
                      textColor: Colors.white,
                      child: Text(
                        'Forgot Password',
                        style: TextStyle(
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.normal,
                            fontSize: 12.0,
                            color: Colors.white),
                      ),
                    ),
                    Container(
                      height: 50,
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.white),
                        ),
                        textColor: Colors.white,
                        color: Colors.transparent,
                        child: Text(
                          'Login',
                          style: TextStyle(
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.normal,
                              fontSize: 18.0,
                              color: Colors.white),
                        ),
                        onPressed: () {
                          print(userNameController.text);
                          print(passwordController.text);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MainScreen()),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              // 10% of the width, so there are ten blinds.
              colors: [
                const Color.fromRGBO(36, 11, 90, 0.8),
                const Color.fromRGBO(142, 7, 149, 0.8),
              ],
              // red to yellow
              tileMode:
              TileMode.repeated, // repeats the gradient over the canvas
            ),
            border:
            Border.all(width: 2.0, color: Color.fromRGBO(142, 7, 149, 1)),
          ),
        );
      },
    );
  }

  // void showSignUp(BuildContext context) {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => SignUpScreen(), fullscreenDialog: false),
  //     //MaterialPageRoute(builder: (_) => HomePage(), fullscreenDialog: true)
  //   );
  // }
}
