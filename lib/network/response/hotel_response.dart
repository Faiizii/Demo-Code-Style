import 'dart:convert';

import 'package:upwork_assignment/model/hotel_model.dart';

class HotelResponse {
  HotelResponse({
    required this.status,
    required this.hotelModel,
  });

  int status;
  List<HotelModel> hotelModel;

  factory HotelResponse.fromRawJson(String str) => HotelResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HotelResponse.fromJson(Map<String, dynamic> json) => HotelResponse(
    status: json["status"] ?? -1,
    hotelModel: json["data"] == null ? <HotelModel>[] : List<HotelModel>.from(json["data"].map((x) => HotelModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "hotel_model": List<dynamic>.from(hotelModel.map((x) => x.toJson())),
  };
}