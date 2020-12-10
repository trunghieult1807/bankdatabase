import 'package:flutter/material.dart';
import 'searchBackend.dart';


class SearchScreen extends StatefulWidget {

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: Container(
          padding: EdgeInsets.only(top: 30.0),
          child: Container(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 16),
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
                    IconButton(
                      onPressed: () {
                        showSearch(context: context, delegate: Search());
                      },
                      icon: Icon(Icons.search, color: Colors.white),
                    )]
              )
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
      body: Center(child: Text(
        'Search for name or phone number',
        style: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 20.0,
          color: Colors.black,
        ),
      ))
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

  String selectedResult = "";

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: Center(
        child: Text(selectedResult),
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
          onTap: (){
            selectedResult = suggestionList[index];
            showResults(context);
          },
        );
      },
    );
  }
}