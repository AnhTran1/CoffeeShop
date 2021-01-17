import 'package:flutter/cupertino.dart';

class ProductDetailModel extends ChangeNotifier {
  int total = 1;
  double totalPrice = 0;
  String category;
  int duration = 0;
  void onIncrement(price){
    total += 1 ;
    totalPrice = price * total.toDouble();
    setDuration();
    notifyListeners();
  }
  void onDecrease(price){
    if(total > 1) {
      total -= 1;
    }
    totalPrice = price * total.toDouble();
    setDuration();
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
  void setDuration(){
    duration = 700;
    Future.delayed(Duration(milliseconds: 700),(){
      duration = 0;
    });
    notifyListeners();
  }
}