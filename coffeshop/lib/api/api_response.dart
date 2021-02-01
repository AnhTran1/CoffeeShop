import 'package:coffeshop/api/api_end_point.dart';
import 'package:coffeshop/api/api_manager.dart';
import 'package:coffeshop/model/m_results.dart';
import 'package:flutter/material.dart';

class ApiResponse {
  static Future<MResults> getCategory() async {
    return await APIManager(request: REQUEST.GET).callApi(url:ApiEndPoint.apiGetCategory);
  }
  static Future<MResults> login(Map<String,dynamic> field) async {
    return await APIManager(request: REQUEST.POST).callApi(url:ApiEndPoint.apiLogin, field: field);
  }
  static Future<MResults> register(Map<String,dynamic> field) async {
    return await APIManager(request: REQUEST.POST).callApi(url:ApiEndPoint.apiRegister,field: field);
  }
  static Future<MResults> getProductByCate({Map<String, dynamic> field, Map<String, dynamic> params}) async {
    return await APIManager(request: REQUEST.GET).callApi(url:ApiEndPoint.apiGetProductByCate,field:field,params: params);
  }
  static Future<MResults> getListCart({Map<String, dynamic> field}) async {
    return await APIManager(request: REQUEST.GET).callApi(url:ApiEndPoint.apiGetListCart, field:field);
  }
}