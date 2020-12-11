import 'package:postgres/postgres.dart';
import 'package:bankdatabase/centralBackend.dart';

List<String> suggest(String searchInput){
  const List<String> suggestions = [
    "Hieu",
    "I Love NKH",
  ];

  return suggestions
      .where((string) => string.toLowerCase().contains(searchInput.toLowerCase()))
      .toList();
}

Future<List<CustomerInfo>> search(String searchInput) async {
    List<CustomerInfo> finalResults = [];
    List<List<dynamic>> results = await connection.query(
        "SELECT fname, lname, code FROM Customer WHERE fname = @query or lname = @query",
        substitutionValues: {"query": searchInput});
    for (final row in results) {
      List<List<dynamic>> phoneNumber = await connection.query(
          "SELECT phone FROM Customer_phone WHERE cust_code = @phoneNum",substitutionValues: {"phoneNum": row[2]});
      finalResults.add(CustomerInfo(row[0], row[1], phoneNumber[0][0], row[2]));
    }
  return finalResults;
}

