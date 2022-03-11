import 'package:http/http.dart';
import 'package:upwork_assignment/constant/network_request_enum.dart';
import 'package:upwork_assignment/network/error_model.dart';
import 'package:upwork_assignment/utils/app_utils.dart';

//class for api/http client configuration
class ApiConfig {
  static final ApiConfig _instance = ApiConfig._();

  factory ApiConfig() => _instance;

  ApiConfig._();

  Future<dynamic> processNetworkCall({
    required RequestType type,
    required String url,
    Map<String,String> params = const {}
  }) async {
    //in case any header or content type add that too in the request configuration
    try {
      //I am considering that it will always initialized
      late Request request;
      //as the assignment only covers get type so I am ignoring handling of other request types
      switch (type) {
        case RequestType.get:
          //convert the params in the format of key=1&k=2 etc for a get type request
          String _strParams = AppUtils.formatGetRequestParams(params);
          if (_strParams.isNotEmpty) {
            url = '$url?$_strParams';
          }
          request = Request('GET', Uri.parse(url));
          break;
        case RequestType.post:
        // TODO: Handle this case.
          break;
        case RequestType.put:
        // TODO: Handle this case.
          break;
        case RequestType.delete:
        // TODO: Handle this case.
          break;
      }

      //customized config here any header or content type

      Response response = await Response.fromStream(await request.send());

      if (response.statusCode == 200) {
        return response;
      } else {
        return ErrorModel.fromResponse(response);
      }
    }catch (e){
      return ErrorModel.fromError(e);
    }
  }
}