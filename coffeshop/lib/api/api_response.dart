import 'package:coffeshop/api/api_end_point.dart';
import 'package:coffeshop/api/api_manager.dart';
import 'package:coffeshop/model/m_results.dart';

class ApiResponse {
  static Future<MResults> login(List<Map<String,dynamic>> field) async {
    return await APIManager(request: REQUEST.POST).callApi(ApiEndPoint.apiLogin, field);
  }
  static Future<MResults> register(List<Map<String,dynamic>> field) async {
    return await APIManager(request: REQUEST.POST).callApi(ApiEndPoint.apiRegister, field);
  }
}