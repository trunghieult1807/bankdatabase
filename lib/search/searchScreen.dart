import 'package:flutter/material.dart';
import 'searchBackend.dart';
import 'package:bankdatabase/search/editCustomer.dart';
import 'package:bankdatabase/centralBackend.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: PreferredSize(
            child: AppBar(
              centerTitle: true,
              flexibleSpace: Container(
                padding: EdgeInsets.only(top: 30.0),
                child: Container(
                  child: Center(
                    child: Text(
                      'Search',
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
                  onPressed: () {
                    showSearch(context: context, delegate: Search());
                  },
                  child: Icon(Icons.search),
                  shape:
                      CircleBorder(side: BorderSide(color: Colors.transparent)),
                ),
              ],
            ),
            preferredSize: Size(MediaQuery.of(context).size.width, 60.0),
          ),
          body: Center(child: Text('search')),
        ),
      ),
      onWillPop: () async => false,
    );
  }
}

class Search extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      ),
      IconButton(
        icon: Icon(Icons.search),
        onPressed: () async {
          searchResult = await search(query);
          showResults(context);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  List<CustomerInfo> searchResult = [];

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [
            for (var customer in searchResult)
              FlatButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditCustomer(customer)));
                  },
                  child: CustomerInfoView(customer))
          ],
        ),
      ),
    );
  }

  Search();

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestionList = suggest(query);

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            suggestionList[index],
          ),
          leading: SizedBox(),
          onTap: () async {
            query = suggestionList[index];
            searchResult = await search(query);
            showResults(context);
          },
        );
      },
    );
  }
}

class CustomerInfoView extends StatelessWidget {
  @override
  CustomerInfoView(CustomerInfo customer) {
    this.customer = customer;
  }

  CustomerInfo customer;

  Widget build(BuildContext context) {
    // Material is a conceptual piece of paper on which the UI appears.
    return Container(
      padding: EdgeInsets.only(top: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14.0),
        // Column is a vertical, linear layout.
        child: Container(
          color: Color(0xFFEEEEEE),
          padding: EdgeInsets.all(28),
          child: Column(
            children: <Widget>[
              Text("First name: " + customer.firstName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Colors.black,
                  )),
              SizedBox(height: 8),
              Text("Last name: " + customer.lastName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Colors.black,
                  )),
              SizedBox(height: 10),
              Text(
                "Phone number: " + customer.phoneNumber,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 20.0,
                  color: Colors.black,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
