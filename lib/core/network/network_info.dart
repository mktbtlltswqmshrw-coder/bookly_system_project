import 'package:connectivity_plus/connectivity_plus.dart';

/// واجهة فحص الاتصال بالإنترنت
abstract class NetworkInfo {
  Future<bool> get isConnected;
  Stream<bool> get onConnectivityChanged;
}

/// تطبيق واجهة فحص الاتصال بالإنترنت
class NetworkInfoImpl implements NetworkInfo {
  final Connectivity connectivity;

  NetworkInfoImpl(this.connectivity);

  @override
  Future<bool> get isConnected async {
    final result = await connectivity.checkConnectivity();
    return _isConnectedResult(result);
  }

  @override
  Stream<bool> get onConnectivityChanged {
    return connectivity.onConnectivityChanged.map(_isConnectedResult);
  }

  /// تحويل نتيجة الاتصال إلى bool
  bool _isConnectedResult(List<ConnectivityResult> results) {
    // التحقق من أن القائمة تحتوي على نوع اتصال صالح
    return results.any((result) =>
        result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi ||
        result == ConnectivityResult.ethernet);
  }
}
