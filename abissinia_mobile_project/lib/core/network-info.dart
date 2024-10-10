import 'package:internet_connection_checker/internet_connection_checker.dart';

class NetworkInfo{

  final InternetConnectionChecker connectionChecker = InternetConnectionChecker();
  Future<bool> get isConnected async => connectionChecker.hasConnection;
}