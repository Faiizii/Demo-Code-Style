class ApiParams {
  //singleton design pattern
  static final ApiParams _instance = ApiParams._();
  ApiParams._();
  factory ApiParams() => _instance;

  final _baseUrl = 'https://dl.dropboxusercontent.com/s/6nt7fkdt7ck0lue';

  String get apiHotels => '$_baseUrl/hotels.json';
}