import 'package:bankdatabase/centralBackend.dart';

// Future<List<List<dynamic>>> getAccount(String cust_code) async {
//   List<List<dynamic>> accounts = await connection.query(
//       "SELECT * FROM Account WHERE cust_code = @cust_code",
//       substitutionValues: {"cust_code": cust_code});
//   return accounts;
// }
//
// Future<String> getAccountType(String acc_type_code) async {
//   String type = await connection.query(
//       "SELECT type FROM Account_type WHERE code = @acc_type_code",
//       substitutionValues: {"code": acc_type_code});
//   return type;
// }
//
//
// Future<List<List<dynamic>>> getAccountInfo(String cust_code) async {
//   List<List<dynamic>> type = await connection.query(
//       "SELECT acc_type_code FROM Account WHERE cust_code = @cust_code",
//       substitutionValues: {"cust_code": cust_code});
//
// }
