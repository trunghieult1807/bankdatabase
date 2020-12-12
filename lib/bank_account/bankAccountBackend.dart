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

class AccountInfo{
  AccountInfo(saving, checking, loan){
    this.saving = saving;
        this.checking = checking;
        this.loan = loan;
  }
  List<SavingAccountInfo> saving = [];
  List<CheckingAccountInfo> checking = [];
  List<LoanAccountInfo> loan = [];
}

Future<AccountInfo> getAccountInfo(String cust_code) async {
  List<SavingAccountInfo> saving = [];
  List<CheckingAccountInfo> checking = [];
  List<LoanAccountInfo> loan = [];
  await Future.delayed(Duration(seconds: 1));

  List<List<dynamic>> results = await connection.query(
      "SELECT * FROM Account WHERE cust_code = @cust_code", substitutionValues: {"cust_code": cust_code});
  for (var row in results) {
    if (row[1] == 1) {
      List<dynamic> savingInfo = await connection.query(
          "SELECT * FROM Saving_account WHERE number = @number", substitutionValues: {"number": row[0]});
      saving.add(SavingAccountInfo(savingInfo[0][0].toString(), savingInfo[0][1], savingInfo[0][2], savingInfo[0][3].toString(), savingInfo[0][4].toString()));
    }
    else if (row[1] == 2) {
      List<dynamic> checkingInfo = await connection.query(
          "SELECT * FROM Checking_account WHERE number = @number", substitutionValues: {"number": row[0]});
      checking.add(CheckingAccountInfo(checkingInfo[0][0].toString(), checkingInfo[0][1], checkingInfo[0][2], checkingInfo[0][3].toString()));
    }
    else if (row[1] == 3) {
      List<dynamic> loanInfo = await connection.query(
          "SELECT * FROM Loan WHERE number = @number", substitutionValues: {"number": row[0]});
      loan.add(LoanAccountInfo(
          loanInfo[0][0].toString(), loanInfo[0][1], loanInfo[0][2], loanInfo[0][3].toString(), loanInfo[0][3].toString()));
    }
  }
  
  return AccountInfo(saving, checking, loan);
}
