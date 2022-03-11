
import 'package:http/http.dart';
import 'package:upwork_assignment/constant/network_request_enum.dart';
import 'package:upwork_assignment/network/api_config.dart';
import 'package:upwork_assignment/network/api_params.dart';
import 'package:upwork_assignment/network/error_model.dart';
import 'package:upwork_assignment/utils/app_utils.dart';

class HotelRepository {
  final _api = ApiConfig();
  Future<dynamic> getHotelsList() async {
    bool isNetwork = await AppUtils.isNetworkAvailable();
    if(!isNetwork){
      return ErrorModel(message: 'No Internet Connection');
    }
    var result = await _api.processNetworkCall(type: RequestType.get, url: ApiParams().apiHotels);
    if(result is Response){
      String body = result.body;
      if(body.isEmpty){
        return ErrorModel(message: "Invalid response received with no body"); //in case no body return from the server
      }
      return body;
    }else{
      // the returned response is not a successful/required response
      return result;
    }
  }
}