import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:bankdatabase/account/accountScreen.dart';
import 'package:bankdatabase/home/homeScreen.dart';
import 'package:bankdatabase/search/searchScreen.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 1;

  Widget _accountScreen = AccountScreen();
  Widget _homeScreen = HomeScreen();
  Widget _searchScreen = SearchScreen();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: this.getBody(),
        bottomNavigationBar: BottomNavyBar(
          selectedIndex: _currentIndex,
          showElevation: true,
          itemCornerRadius: 24,
          curve: Curves.easeIn,
          onItemSelected: (index) => setState(() => this.onTapHandler(index)),
          items: <BottomNavyBarItem>[
            BottomNavyBarItem(
              icon: Icon(Icons.search),
              title: Text('Search'),
              activeColor: Colors.lightBlueAccent,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
              activeColor: Colors.red,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.account_circle),
              title: Text('Account'),
              activeColor: Colors.purpleAccent,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget getBody() {
    if (this._currentIndex == 0) {
      return this._searchScreen;
    } else if (this._currentIndex == 1) {
      return this._homeScreen;
    } else {
      return this._accountScreen;
    }
  }

  void onTapHandler(int index) {
    this.setState(() {
      this._currentIndex = index;
    });
  }
}
