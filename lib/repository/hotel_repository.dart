import 'dart:convert';

import 'package:http/http.dart';
import 'package:upwork_assignment/constant/network_request_enum.dart';
import 'package:upwork_assignment/network/api_config.dart';
import 'package:upwork_assignment/network/api_params.dart';
import 'package:upwork_assignment/network/error_model.dart';
import 'package:upwork_assignment/network/response/hotel_response.dart';

class HotelRepository {
  final _api = ApiConfig();
  Future<dynamic> getHotelsList() async {
    var result = await _api.processNetworkCall(type: RequestType.get, url: ApiParams().apiHotels);
    if(result is Response){
      String body = result.body;
      if(body.isEmpty){
        return ErrorModel(message: "Invalid response received"); //in case no body return from the server
      }
      return HotelResponse.fromJson(jsonDecode(body)).hotelModel;
    }else{
      return result;
    }
  }
}