import 'package:coffeshop/api/api_exception.dart';
import 'package:coffeshop/common/storage_manager.dart';
import 'package:coffeshop/model/m_results.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'dart:async';
enum REQUEST{POST,GET,PUT,DELETE}
class APIManager {
  REQUEST request;
  APIManager({this.request});
  static String hosts = "http://coffee.pacom-dev.com/";

  static headers() async {
    var header = {
      "Accept": "application/json",
      'Content-type': 'application/json',
      "Authorization": "${await StorageManager.readData("token") != null ? "${await StorageManager.readData("token")}" : ""}"
    };
    return header;
  }

  Future<MResults> callApi({String url, @required Map<String, dynamic> field,@required Map<String, dynamic> params}) async {
    var responseJson;
    var request;
    MResults mResult = MResults(loading: true,loaded: false,loadMore: false,loadFailed: false,message: "",data: null);
    switch(this.request){
      case REQUEST.POST:
        request = new http.MultipartRequest("POST", Uri.parse(hosts + url));
        break;
      case REQUEST.GET:
        request = new http.MultipartRequest("GET", Uri.parse(hosts + url).replace(queryParameters:params));
        break;
      case REQUEST.PUT:
        request = new http.MultipartRequest("PUT", Uri.parse(hosts + url));
        break;
      case REQUEST.DELETE:
        request = new http.MultipartRequest("DELETE", Uri.parse(hosts + url));
        break;
    }
    request.headers.addAll(await  headers());
    await Future.delayed(Duration.zero,(){
      if(field != null){
        field.addAll(field);
      }
    });
    try {
      http.Response response = await http.Response.fromStream(await request.send());
      responseJson = _response(response);
      mResult = MResults(loading: false,loaded: true,loadMore: false,loadFailed: false,message: json.decode(responseJson)["message"],data: json.decode(responseJson)["data"]);
    } on SocketException {
      mResult = MResults(loading: false,loaded: false,loadMore: false,loadFailed: true,message: "No internet connected",data: null);
    } catch(e) {
      mResult = MResults(loading: false,loaded: false,loadMore: false,loadFailed: true,message: e.toString(),data: null);
    }
    return mResult;
  }
  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return response.body;
      case 400:
        throw BadRequestException(response.body);
      case 401:
      case 403:
        throw UnauthorisedException(response.body);
      case 500:
      default:
        throw FetchDataException('Error occured while Communication with Server with StatusCode :${response.statusCode}');
    }
  }
}
