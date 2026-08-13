import 'package:book_nook/core/network/network_info.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class NetworkInfoImpl implements NetworkInfo {
  final InternetConnectionChecker checker;
  
  NetworkInfoImpl(this.checker);

  @override
  Future<bool> get isConnected =>
    checker.hasConnection;
}
