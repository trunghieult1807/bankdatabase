import 'package:postgres/postgres.dart';


const server_port = 5432;


void login(String username, String password) async {
  print("connecting to database with credentials:");
  print(username);
  print(password);
  var connection = PostgreSQLConnection("localhost", server_port, "dart_test", username: username, password: password);
  await connection.open();
  print("connection successful");
}