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
        "SELECT fname, lname, code, email, home_addr, off_addr, emp_code, serve_date FROM Customer WHERE fname = @query or lname = @query",
        substitutionValues: {"query": searchInput});
    for (final row in results) {
      List<List<dynamic>> phoneNumbers = await connection.query(
          "SELECT phone FROM Customer_phone WHERE cust_code = @code",substitutionValues: {"code": row[2]});
      List<String> fuckDart = [];
      for (final value in phoneNumbers) {
        fuckDart.add(value[0]);
      }
      finalResults.add(CustomerInfo(row[0], row[1],fuckDart, row[2], row[3], row[4], row[5], row[6], row[7]));
    }
    List<List<dynamic>> phoneNumbers = await connection.query(
        "SELECT cust_code, phone FROM Customer_phone WHERE phone = @query",
        substitutionValues: {"query": searchInput});
    for (final row in phoneNumbers) {
      results = await connection.query(
          "SELECT fname, lname, email, home_addr, off_addr, emp_code, serve_date FROM Customer WHERE code = @code",substitutionValues: {"code": row[0]});
      finalResults.add(CustomerInfo(results[0][0], results[0][1], [row[1]], row[0], results[0][2], results[0][3],results[0][4], results[0][5], results[0][6]));
    }
  return finalResults;
}

