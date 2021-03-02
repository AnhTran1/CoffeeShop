import 'dart:collection';
import 'dart:convert';

import 'package:coffeshop/api/api_response.dart';
import 'package:coffeshop/model/m_category.dart';
import 'package:coffeshop/model/m_product.dart';
import 'package:coffeshop/model/m_results.dart';
import 'package:flutter/cupertino.dart';

class ProductModel extends ChangeNotifier {
  MCategory mCategory;
  MResults mProductResult = MResults(loading: true,loaded: false,loadFailed: false,loadMore: false,message: "",data: null);
  HashMap<String, List<MProduct>> mProductList;
  HashMap productList = new HashMap<String, List<MProduct>>();

  Future getCategory() async{
    MResults mResults;
    mResults = await ApiResponse.getCategory();
    if(mResults.loaded){
      mCategory = MCategory.fromJson(mResults.data);
    }
    notifyListeners();
    return mResults;
  }
  void reCall(){
    mProductResult = MResults(loading: true,loaded: false,loadFailed: false,loadMore: false,message: "",data: null);
    notifyListeners();
  }
  void getProduct({String cateId, int page}) async{
    await Future.delayed(Duration(milliseconds: 1000),() async{
      mProductResult = await ApiResponse.getProductByCate(params: {"category_id": cateId});
      if(mProductResult.loaded && mProductResult.data != null){
        var jsonList = jsonDecode(jsonEncode(mProductResult.data))["data"] as List;
        productList[cateId] = jsonList.map((i) => MProduct.fromJson(i)).toList();
        mProductList = productList;
      }
    });
    notifyListeners();
  }
}