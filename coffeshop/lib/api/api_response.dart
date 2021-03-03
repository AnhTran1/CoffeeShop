import 'package:coffeshop/api/api_end_point.dart';
import 'package:coffeshop/api/api_manager.dart';
import 'package:coffeshop/model/m_results.dart';

class ApiResponse {
  static Future<MResults> getCategory() async {
    return await APIManager(request: REQUEST.GET).callApi(url:ApiEndPoint.apiGetCategory);
  }
  static Future<MResults> login({List<Map<String,dynamic>> field}) async {
    return await APIManager(request: REQUEST.POST).callApi(url:ApiEndPoint.apiLogin, field: field);
  }
  static Future<MResults> register({List<Map<String,dynamic>> field}) async {
    return await APIManager(request: REQUEST.POST).callApi(url:ApiEndPoint.apiRegister,field: field);
  }
  static Future<MResults> getProductByCate({Map<String, dynamic> params}) async {
    return await APIManager(request: REQUEST.GET).callApi(url:ApiEndPoint.apiGetProductByCate,params: params);
  }
  static Future<MResults> getListCart({List<Map<String, dynamic>> field}) async {
    return await APIManager(request: REQUEST.GET).callApi(url:ApiEndPoint.apiGetListCart, field:field);
  }
  static Future<MResults> addCart({List<Map<String, dynamic>> field}) async {
    return await APIManager(request: REQUEST.POST).callApi(url:ApiEndPoint.apiAddCart, field:field);
  }
  static Future<MResults> removeCart({List<Map<String, dynamic>> field}) async {
    return await APIManager(request: REQUEST.POST).callApi(url:ApiEndPoint.apiRemoveCart, field:field);
  }
  static Future<MResults> addAddress({List<Map<String, dynamic>> field}) async {
    return await APIManager(request: REQUEST.POST).callApi(url:ApiEndPoint.apiAddAddress, field:field);
  }
  static Future<MResults> getAddressList({List<Map<String, dynamic>> field}) async {
    return await APIManager(request: REQUEST.GET).callApi(url:ApiEndPoint.apiGetAddress, field:field);
  }
  static Future<MResults> removeAddress({List<Map<String, dynamic>> field}) async {
    return await APIManager(request: REQUEST.POST).callApi(url:ApiEndPoint.apiRemoveAddress, field:field);
  }
  static Future<MResults> addCategory({List<Map<String, dynamic>> field}) async {
    return await APIManager(request: REQUEST.POST).callApi(url:ApiEndPoint.apiAddCategory, field:field);
  }
  static Future<MResults> paymentProcess({List<Map<String, dynamic>> field}) async {
    return await APIManager(request: REQUEST.POST).callApi(url:ApiEndPoint.apiPayment, field:field);
  }
  static Future<MResults> updateCategory({List<Map<String, dynamic>> field}) async {
    return await APIManager(request: REQUEST.POST).callApi(url:ApiEndPoint.apiUpdateCategory, field:field);
  }
  static Future<MResults> removeCategory({List<Map<String, dynamic>> field}) async {
    return await APIManager(request: REQUEST.POST).callApi(url:ApiEndPoint.apiRemoveCategory, field:field);
  }
  static Future<MResults> updateItem({List<Map<String, dynamic>> field}) async {
    return await APIManager(request: REQUEST.POST).callApi(url:ApiEndPoint.apiUpdateItem, field:field);
  }
  static Future<MResults> removeItem({List<Map<String, dynamic>> field}) async {
    return await APIManager(request: REQUEST.POST).callApi(url:ApiEndPoint.apiRemoveItem, field:field);
  }
}