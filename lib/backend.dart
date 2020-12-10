import 'package:postgres/postgres.dart';


const server_port = 5432;
var connectionDB;

void login(String username, String password) async {
  print("connecting to database with credentials:");
  print(username);
  print(password);
  var connection = PostgreSQLConnection("localhost", server_port, "postgres", username: username, password: password);
  await connection.open();
  connectionDB = connection;
  print("connect to database successfully");
}
