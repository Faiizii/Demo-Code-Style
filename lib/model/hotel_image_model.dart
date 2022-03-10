class HotelImageModel {
  HotelImageModel({
    required this.small,
    required this.medium,
    required this.large,
  });

  String small;
  String medium;
  String large;

  factory HotelImageModel.fromJson(Map<String, dynamic> json) => HotelImageModel(
    small: json["small"] ?? 'no_image_link',
    medium: json["medium"] ?? 'no_image_link',
    large: json["large"] ?? 'no_image_link',
  );

  Map<String, dynamic> toJson() => {
    "small": small,
    "medium": medium,
    "large": large,
  };
}
