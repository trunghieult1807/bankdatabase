import 'package:postgres/postgres.dart';

class CustomerInfo{
  CustomerInfo(String fname, String lname, String pnumber){
    this.firstName = fname;
    this.lastName = lname;
    this.phoneNumber = pnumber;
  }
  String firstName;
  String lastName;
  String phoneNumber;
}

List<String> suggest(String searchInput){
  const List<String> suggestions = [
    "john",
    "mary",
    "katie",
    "anna",
    "elsa",
    "karen",
    "jim"
  ];

  return suggestions
      .where((string) => string.toLowerCase().contains(searchInput.toLowerCase()))
      .toList();
}

List<CustomerInfo> search(String searchInpu){
  return [CustomerInfo("Mary", "Jine", "03254852"),
          CustomerInfo("John", "Jine", "05514852"),
  ];
}

