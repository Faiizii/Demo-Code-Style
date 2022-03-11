import 'dart:convert';

import 'package:upwork_assignment/model/hotel_model.dart';

class HotelResponse {
  HotelResponse({
    required this.status,
    required this.hotelList,
  });

  int status;
  List<HotelModel> hotelList;

  factory HotelResponse.fromRawJson(String str) => HotelResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HotelResponse.fromJson(Map<String, dynamic> json) => HotelResponse(
    status: json["status"] ?? -1,
    hotelList: json["data"] == null ? <HotelModel>[] : List<HotelModel>.from(json["data"].map((x) => HotelModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "hotel_model": List<dynamic>.from(hotelList.map((x) => x.toJson())),
  };
}