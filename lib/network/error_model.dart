import 'dart:async';
import 'dart:io';
import 'package:http/http.dart';

//general error model class for any error type while communicating with any type of server
class ErrorModel{
  late int statusCode;
  late String message;
  ErrorModel({this.statusCode = -1, this.message = 'Unknown error occurred'});

  ErrorModel.fromResponse(Response response) {
    statusCode = response.statusCode;
    //we can handle the status codes as many as we want to
    switch(statusCode){
      case 503:
        message = 'Server unavailable! Server is not reachable please try again letter.';
        break;
      case 403:
        message = 'Unauthorized! Please request access from the server admin.';
        break;
      default:
        message = 'Unable to get the response from the server please try again';
    }
  }

  ErrorModel.fromError(Object e) {
    statusCode = -1;
    if(e is SocketException){
      message = 'Unable to connect to the server. Please check your intent connection.';
    }else if(e is TimeoutException){
      message = 'Connection Timeout! Slow internet connection.';
    }else if(e is NoSuchMethodError){
      message = 'Invalid response from the server';
    }else if(e is FormatException){
      message = 'Invalid request found. Please contact support if continuously facing this error';
    }else{
      message = e.toString();
    }
  }
}