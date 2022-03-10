import 'package:connectivity_plus/connectivity_plus.dart';

class AppUtils {
  static String formatGetRequestParams(Map<String, String> _params){
    String output = '';

    _params.forEach((key, value) {
      if(output.isEmpty){
        output = '$key=$value';
      }else{
        output = '$output&$key=$value';
      }
    });
    return output;
  }
  static Future<bool> isNetworkAvailable() async {
    var result = await Connectivity().checkConnectivity();
    return result == ConnectivityResult.mobile || result == ConnectivityResult.wifi;
  }
}