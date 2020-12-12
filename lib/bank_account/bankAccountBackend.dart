import 'package:bankdatabase/centralBackend.dart';

Future<List<List<dynamic>>> getAccount(String cust_code) async {
  List<List<dynamic>> accounts = await connection.query(
      "SELECT * FROM Account WHERE cust_code = @cust_code",
      substitutionValues: {"cust_code": cust_code});
  return accounts;
}

Future<String> getAccountType(String acc_type_code) async {
  String type = await connection.query(
      "SELECT type FROM Account_type WHERE code = @acc_type_code",
      substitutionValues: {"code": acc_type_code});
  return type;
}

Future<List<List<dynamic>>> getAccountInfo(String cust_code) async {
  List<SavingAccountInfo> saving = [];
  List<CheckingAccountInfo> checking = [];
  List<LoanAccountInfo> loan = [];

  List<List<dynamic>> results = await connection.query(
      "SELECT * FROM Account WHERE cust_code = @cust_code",
      substitutionValues: {"cust_code": cust_code});
  for (final row in results) {
    if (row[1] == 1) {
      List<dynamic> savingInfo = await connection.query(
          "SELECT * FROM Saving_account WHERE number = @number",substitutionValues: {"number": row[0]});
      saving.add(SavingAccountInfo(savingInfo[0], savingInfo[1], savingInfo[2], savingInfo[3], savingInfo[4]));
    }
    if (row[1] == 2) {
      List<dynamic> checkingInfo = await connection.query(
          "SELECT * FROM Checking_account WHERE number = @number",substitutionValues: {"number": row[0]});
      checking.add(CheckingAccountInfo(checkingInfo[0], checkingInfo[1], checkingInfo[2], checkingInfo[3]))
    }
    if (row[1] == 3) {
      List<dynamic> loanInfo = await connection.query(
          "SELECT * FROM loan WHERE number = @number",
          substitutionValues: {"number": row[0]});
      loan.add(LoanAccountInfo(
          loanInfo[0], loanInfo[1], loanInfo[2], loanInfo[3], loanInfo[4]))
    }
  }
  
  return [saving, checking, loan];
}
