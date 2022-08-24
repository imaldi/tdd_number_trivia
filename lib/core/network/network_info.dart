import 'package:data_connection_checker_tv/data_connection_checker.dart';

abstract class NetworkInfo {
  // TODO change to non nullable after implementing
  Future<bool>? get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final DataConnectionChecker connectionChecker;

  NetworkInfoImpl(this.connectionChecker);

  @override
  Future<bool>? get isConnected => connectionChecker.hasConnection;
}