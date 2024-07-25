import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';

abstract class NetworkChecker {
  Future<bool> getConnectionStatus();
}

class ConnectivityNetworkCkecker extends NetworkChecker {
  final Connectivity _connectivity;

  ConnectivityNetworkCkecker({required Connectivity connectivity})
      : _connectivity = connectivity;

  @override
  Future<bool> getConnectionStatus() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException {
      return false;
    }
    return result != ConnectivityResult.none;
  }
}
