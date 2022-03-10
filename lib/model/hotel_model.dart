import 'package:upwork_assignment/model/hotel_image_model.dart';

class HotelModel {
  HotelModel({
    required this.id,
    required this.title,
    required this.description,
    required this.address,
    required this.postcode,
    required this.phoneNumber,
    required this.latitude,
    required this.longitude,
    required this.image,
  });

  int id;
  String title;
  String description;
  String address;
  String postcode;
  String phoneNumber;
  double latitude;
  double longitude;
  HotelImageModel image;

  factory HotelModel.fromJson(Map<String, dynamic> json) => HotelModel(
    id: json["id"] ?? 'no_id',
    title: json["title"] ?? 'Unknown Hotel',
    description: json["description"] ?? 'No Description Written',
    address: json["address"] ?? 'Address Unknown',
    postcode: json["postcode"] ?? '00000',
    phoneNumber: json["phoneNumber"] ?? 'No Phone',
    latitude: double.parse(json["latitude"] ?? '0.0'),
    longitude: double.parse(json["longitude"] ?? '0.0'),
    image: HotelImageModel.fromJson(json["image"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "address": address,
    "postcode": postcode,
    "phoneNumber": phoneNumber,
    "latitude": latitude,
    "longitude": longitude,
    "image": image.toJson(),
  };
}