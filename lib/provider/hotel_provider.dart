import 'package:upwork_assignment/repository/hotel_repository.dart';

class HotelProvider {
  final repo = HotelRepository();

  Future<dynamic> getHotels() async {
    return await repo.getHotelsList();
  }
}