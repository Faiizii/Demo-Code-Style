import 'package:upwork_assignment/network/error_model.dart';
import 'package:upwork_assignment/network/response/hotel_response.dart';
import 'package:upwork_assignment/repository/hotel_repository.dart';

class HotelProvider {
  final repo = HotelRepository();

  Future<dynamic> getHotels() async {
    var response = await repo.getHotelsList();
    if(response is String){
      //in case response is successful prepare the response for UI
      HotelResponse hotelResponse = HotelResponse.fromRawJson(response);

      if(hotelResponse.status == 200){
        return hotelResponse.hotelList;
      }else{
        //in case if api send other status code for empty list or anything else
        //these response codes are not stated clear so leaving a general message
        return ErrorModel(message: 'Unable to get hotel list from the server');
      }
    }
    return response; //in case response is returned as ErrorModel
  }
}