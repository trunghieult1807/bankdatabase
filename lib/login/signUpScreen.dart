// import 'package:flutter/material.dart';
// import 'package:bankdatabase/login/loginScreen.dart';
// import 'package:bankdatabase/home/mainScreenController.dart';
//
// class SignUpScreen extends StatefulWidget {
//   @override
//   _SignUpScreenState createState() => new _SignUpScreenState();
// }
//
// class _SignUpScreenState extends State<SignUpScreen> {
//   bool _isLoading = false;
//   final formKey = new GlobalKey<FormState>();
//   String _userName, _password;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         child: Container(
//           padding: EdgeInsets.only(top: 30.0),
//           child: Container(
//             child: Row(
//               children: <Widget>[
//                 FlatButton(
//                   onPressed: () => Navigator.of(context).pop(true),
//                   child: Icon(
//                     Icons.arrow_back_ios,
//                     color: Colors.white,
//                     size: 20,
//                   ),
//                   height: 20.0,
//                   minWidth: 10.0,
//                 ),
//                 Center(
//                   child: Text(
//                     'Sign Up',
//                     style: TextStyle(
//                       fontFamily: 'GoogleSans',
//                       fontWeight: FontWeight.normal,
//                       fontSize: 20.0,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//               colors: [
//                 const Color.fromRGBO(36, 11, 90, 0.9),
//                 const Color.fromRGBO(142, 7, 149, 0.9),
//               ],
//               tileMode: TileMode.repeated,
//             ),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.3),
//                 spreadRadius: 5,
//                 blurRadius: 7,
//                 offset: Offset(0, 3), // changes position of shadow
//               ),
//             ],
//           ),
//         ),
//         preferredSize: Size(MediaQuery.of(context).size.width, 60.0),
//       ),
//       body: Center(
//         child: Container(
//           child: Material(
//             color: Colors.transparent,
//             child: Center(
//               child: Container(
//                 alignment: Alignment(0, 0),
//                 margin: const EdgeInsets.fromLTRB(30, 30, 30, 30),
//                 child: ListView(
//                   shrinkWrap: true,
//                   children: <Widget>[
//                     Center(
//                       child: Text(
//                         'Bank Database',
//                         style: TextStyle(
//                             fontFamily: 'Lato',
//                             fontWeight: FontWeight.normal,
//                             fontSize: 27.0,
//                             color: Colors.white),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 30.0,
//                     ),
//                     new Form(
//                       key: formKey,
//                       child: new Column(
//                         children: <Widget>[
//                           SingleChildScrollView(
//                             child: Container(
//                               padding: EdgeInsets.all(10),
//                               child: TextFormField(
//                                 style: TextStyle(color: Colors.white),
//                                 //obscureText: true,
//                                 onSaved: (val) => _userName = val,
//                                 decoration: InputDecoration(
//                                   enabledBorder: const OutlineInputBorder(
//                                     borderSide: const BorderSide(
//                                         color: Colors.white, width: 1.0),
//                                   ),
//                                   border: OutlineInputBorder(
//                                     borderRadius: const BorderRadius.all(
//                                       const Radius.circular(10.0),
//                                     ),
//                                   ),
//                                   labelText: 'UserName',
//                                   labelStyle: TextStyle(
//                                     color: Colors.white70,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           SingleChildScrollView(
//                             child: Container(
//                               padding: EdgeInsets.all(10),
//                               child: TextFormField(
//                                 style: TextStyle(color: Colors.white),
//                                 onSaved: (val) => _password = val,
//                                 decoration: InputDecoration(
//                                   enabledBorder: const OutlineInputBorder(
//                                     borderSide: const BorderSide(
//                                         color: Colors.white, width: 1.0),
//                                   ),
//                                   border: OutlineInputBorder(
//                                     borderRadius: const BorderRadius.all(
//                                       const Radius.circular(10.0),
//                                     ),
//                                   ),
//                                   labelText: 'Password',
//                                   labelStyle: TextStyle(
//                                     color: Colors.white70,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Container(
//                       height: 50,
//                       padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
//                       child: RaisedButton(
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(18.0),
//                           side: BorderSide(color: Colors.white),
//                         ),
//                         textColor: Colors.white,
//                         color: Colors.transparent,
//                         child: Text(
//                           'Sign Up',
//                           style: TextStyle(
//                               fontFamily: 'Lato',
//                               fontWeight: FontWeight.normal,
//                               fontSize: 18.0,
//                               color: Colors.white),
//                         ),
//                         onPressed: () {
//                           _submit();
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//               // 10% of the width, so there are ten blinds.
//               colors: [
//                 const Color.fromRGBO(36, 11, 90, 1),
//                 const Color.fromRGBO(142, 7, 149, 1),
//               ],
//               // red to yellow
//               tileMode:
//                   TileMode.repeated, // repeats the gradient over the canvas
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _submit() {
//     final form = formKey.currentState;
//
//     if (form.validate()) {
//       setState(() {
//         ////_isLoading = true;
//         form.save();
//         var employee = new Employee(_userName, _password, null, null, null,
//             null, null, null, null, null, null, null);
//         var db = new DatabaseHelper();
//         db.saveEmployee(employee);
//         var a = db.saveEmployee(employee);
//         print("Hi there $a");
//         if (db.saveEmployee(employee) != null) {
//           //_isLoading = false;
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => LoginScreen()),
//           );
//         } else {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => MainScreen()),
//           );
//         }
//       });
//     }
//   }
// }
