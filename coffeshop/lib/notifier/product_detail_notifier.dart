import 'package:coffeshop/api/api_response.dart';
import 'package:coffeshop/model/m_results.dart';
import 'package:flutter/cupertino.dart';

class ProductDetailModel extends ChangeNotifier {
  int totalQuantity = 1;
  int totalPrice = 0;
  String category;
  int duration = 0;
  int badge = 0;
  void onIncrement(price){
    totalQuantity += 1 ;
    totalPrice = price * totalQuantity;
    setDuration();
    notifyListeners();
  }
  void onDecrease(price){
    if(totalQuantity > 1) {
      totalQuantity -= 1;
    }
    totalPrice = price * totalQuantity;
    setDuration();
    notifyListeners();
  }
  void initData(int price){
    totalPrice = price;
    totalQuantity = 1;
    notifyListeners();
  }
  void setCategory(value){
    category = value;
    notifyListeners();
  }
  void setDuration(){
    duration = 700;
    Future.delayed(Duration(milliseconds: 700),(){
      duration = 0;
    });
    notifyListeners();
  }
  void setBadge(int value){
    badge = value;
    notifyListeners();
  }
  Future<MResults> addCart(itemId,quantity) async{
    MResults mAddCartResult = MResults(loading: true,loaded: false,loadFailed: false,loadMore: false,message: "",data: null);
    mAddCartResult =  await ApiResponse.addCart(field: [{"item_id":itemId},{"quantity":quantity}]);
    return mAddCartResult;
  }
}