import 'package:coffeshop/api/api_end_point.dart';
import 'package:coffeshop/api/api_manager.dart';
import 'package:coffeshop/model/m_results.dart';
import 'package:flutter/material.dart';

class ApiResponse {
  static Future<MResults> getCategory({@required List<Map<String, dynamic>> field}) async {
    return await APIManager(request: REQUEST.GET).callApi(ApiEndPoint.apiGetCategory, field);
  }
  static Future<MResults> login(List<Map<String,dynamic>> field) async {
    return await APIManager(request: REQUEST.POST).callApi(ApiEndPoint.apiLogin, field);
  }
  static Future<MResults> register(List<Map<String,dynamic>> field) async {
    return await APIManager(request: REQUEST.POST).callApi(ApiEndPoint.apiRegister, field);
  }
  static Future<MResults> getProductByCate(List<Map<String,dynamic>> field) async {
    return await APIManager(request: REQUEST.GET).callApi(ApiEndPoint.apiGetProductByCate, field);
  }
  static Future<MResults> getListCart({@required List<Map<String, dynamic>> field}) async {
    return await APIManager(request: REQUEST.GET).callApi(ApiEndPoint.apiGetListCart, field);
  }
}