import 'package:postgres/postgres.dart';

const server_port = 5432;
var connection;

void login(String username, String password) async {
  print("connecting to database with credentials:");
  print(username);
  print(password);
  connection = PostgreSQLConnection("localhost", server_port, "postgres",
      username: username, password: password);
  await connection.open();
  //connectionDB = connection;
  print("connect to database successfully");
}

void loginSuccess() {}

bool checkChar(int n, String s) {
  if (s.length != n) {
    return false;
  } else
    return true;
}

bool checkVarChar(int n, String s) {
  if (s.length > n) {
    return false;
  } else {
    return true;
  }
}

bool checkValid(String fname, String lname, String email, String home_addr,
    String off_addr, String emp_code) {
  int flag = 1;
  if (fname == "") {
    print("fname cannot null");
    flag = 0;
  }
  if (!checkVarChar(15, fname)) {
    print("fname exceeds 15 chars");
    flag = 0;
  }
  if (lname == "") {
    print("lname cannot null");
    flag = 0;
  }
  if (!checkVarChar(15, lname)) {
    print("lname exceeds 15 chars");
    flag = 0;
  }
  if (email == "") {
    print("email cannot null");
    flag = 0;
  }
  if (!checkVarChar(30, email)) {
    print("email exceeds 30 chars");
    flag = 0;
  } else {
    List<dynamic> customer = connection.query(
        "SELECT * FROM Customer WHERE email = @email",
        substitutionValues: {"email": email});
    if (customer != []) {
      print("email must be unique");
      flag = 0;
    }
  }
  if (!checkVarChar(50, home_addr)) {
    print("home_addr exceeds 50 chars");
    flag = 0;
  }
  if (!checkVarChar(50, off_addr)) {
    print("off_addr exceeds 50 chars");
    flag = 0;
  }
  if (!checkChar(7, emp_code)) {
    print("emp_code not fix 7 chars");
    flag = 0;
  }
  return flag == 1 ? true : false;
}

void createCustomer(String fname, String lname, String email, String home_addr,
    String off_addr, String emp_code, DateTime serve_date) async {
  if (checkValid(fname, lname, email, home_addr, off_addr, emp_code)) {
    await connection.query("""
    INSERT INTO Customer 
    VALUES ('cus0001', @fname, @lname, @email, @home_addr, @off_addr, @emp_code, @serve_date)""",
        substitutionValues: {
          "fname": fname,
          "lname": lname,
          "email": email,
          "home_addr": home_addr,
          "off_addr": off_addr,
          "emp_code": emp_code,
          "serve_date": serve_date
        });
  }
}

void updateCustomer(
    String code,
    String fname,
    String lname,
    String email,
    String home_addr,
    String off_addr,
    String emp_code,
    DateTime serve_date) async {
  if (checkValid(fname, lname, email, home_addr, off_addr, emp_code)) {
    List<dynamic> customer = await connection.query(
        "SELECT * FROM Customer WHERE code = @code",
        substitutionValues: {"code": code});
    for (var col in customer) {
      if (col[1] != fname) {
        await connection.query(
            "UPDATE Customer SET fname = @fname WHERE code = @code",
            substitutionValues: {"fname": fname, "code": code});
      }

      if (col[2] != lname) {
        await connection.query(
            "UPDATE Customer SET lname = @lname WHERE code = @code",
            substitutionValues: {"lname": lname, "code": code});
      }

      if (col[3] != email) {
        await connection.query(
            "UPDATE Customer SET email = @email WHERE code = @code",
            substitutionValues: {"email": email, "code": code});
      }

      if (col[4] != home_addr) {
        await connection.query(
            "UPDATE Customer SET home_addr = @home_addr WHERE code = @code",
            substitutionValues: {"home_addr": home_addr, "code": code});
      }

      if (col[5] != off_addr) {
        await connection.query(
            "UPDATE Customer SET off_addr = @off_addr WHERE code = @code",
            substitutionValues: {"off_addr": off_addr, "code": code});
      }

      if (col[6] != emp_code) {
        await connection.query(
            "UPDATE Customer SET emp_code = @emp_code WHERE code = @code",
            substitutionValues: {"emp_code": emp_code, "code": code});
      }
    }
  }
}

void deleteCustomer(String code) async {
  await connection.query("DELETE FROM Customer WHERE code = @code",
      subtitutionValues: {"code": code});
}



class CustomerInfo{
  CustomerInfo(String fname, String lname, String pnumber, String code){
    this.firstName = fname;
    this.lastName = lname;
    this.phoneNumber = pnumber;
    this.code = code;
  }
  String firstName;
  String lastName;
  String phoneNumber;
  String code;
}