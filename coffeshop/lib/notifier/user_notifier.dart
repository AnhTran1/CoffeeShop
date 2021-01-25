import 'dart:convert';

import 'package:coffeshop/api/api_end_point.dart';
import 'package:coffeshop/api/api_manager.dart';
import 'package:coffeshop/common/Utils.dart';
import 'package:coffeshop/common/const.dart';
import 'package:coffeshop/common/storage_manager.dart';
import 'package:coffeshop/model/m_results.dart';
import 'package:coffeshop/model/m_user.dart';
import 'package:flutter/material.dart';

class UserModel extends ChangeNotifier {
  var formLogin = ["",""];
  bool onTapLogin = false;

  MUser mUser;
  void setOnTapLogin(value) async{
    onTapLogin = value;
    await Future.delayed(Duration(milliseconds: 50),(){
      onTapLogin = false;
    });
    notifyListeners();
  }
  void getUser() async{
    mUser = MUser.fromJson(json.decode(await StorageManager.readData("user")));
    StorageManager.saveData("token", mUser.apiToken);
    notifyListeners();
  }
  void onChangeForm(int type, value){
    switch (type) {
      case 0:
        formLogin[0] = value;
        break;
      case 1:
        formLogin[1] = value;
        break;
    }
    notifyListeners();
  }
  loginValidate({String email, String pw}) async{
    if(email.isEmpty || pw.isEmpty){
      setOnTapLogin(true);
      return Const.nullFormat;
    } else {
      if(!Utils.validateEmail(email)){
        setOnTapLogin(true);
        return Const.emailFormat;
      } else {
        return null;
      }
    }
  }
  Future<MResults> actionLogin(BuildContext context) async{
    MResults mResults = MResults(loading: true,loaded: false,loadMore: false,loadFailed: false,message: "",data: null);
    String onMessage = await loginValidate(email:formLogin[0].trim(),pw:formLogin[1].trim());
    if(onMessage != null){
      Utils.showAlertMessage(context, onMessage);
    }
    else {
      mResults = await APIManager(request: REQUEST.POST).callApi(ApiEndPoint.apiLogin, [{"email":"${formLogin[0]}"},{"password":"${formLogin[1]}"}]);
    }
    return mResults;
  }
}
