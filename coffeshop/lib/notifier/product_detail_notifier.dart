import 'package:flutter/cupertino.dart';

class ProductDetailModel extends ChangeNotifier {
  int total = 1;
  double totalPrice = 0;
  String category;
  void onIncrement(price){
    total += 1 ;
    totalPrice = price * total.toDouble();
    notifyListeners();
  }
  void onDecrease(price){
    if(total > 1) {
      total -= 1;
    }
    totalPrice = price * total.toDouble();
    notifyListeners();
  }
  void initData(price){
    totalPrice = price;
    total = 1;
    notifyListeners();
  }
  void setCategory(value){
    category = value;
    notifyListeners();
  }
}