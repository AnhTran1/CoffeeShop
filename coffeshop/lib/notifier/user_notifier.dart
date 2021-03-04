import 'dart:convert';

import 'package:coffeshop/api/api_end_point.dart';
import 'package:coffeshop/api/api_manager.dart';
import 'package:coffeshop/api/api_response.dart';
import 'package:coffeshop/common/Utils.dart';
import 'package:coffeshop/common/const.dart';
import 'package:coffeshop/common/storage_manager.dart';
import 'package:coffeshop/model/m_results.dart';
import 'package:coffeshop/model/m_user.dart';
import 'package:flutter/material.dart';

class UserModel extends ChangeNotifier {
  MUser mRegister = MUser(id:null,name: "",email: "",apiToken: "",emailVerifiedAt: null,passWord: "",conFirmPassword: "");
  var formLogin = ["",""];
  bool onTapLogin = false;

  MUser mUser;
  Future signOut() async{
    mUser = null;
    await StorageManager.deleteData("user");
    await StorageManager.deleteData("token");
    await StorageManager.deleteData("user_type");
    notifyListeners();
  }
  void setOnTapLogin(value) async{
    onTapLogin = value;
    await Future.delayed(Duration(milliseconds: 50),(){
      onTapLogin = false;
    });
    notifyListeners();
  }
  void getUser() async{
    if(await StorageManager.readData("user") != null) {
      mUser = MUser.fromJson(json.decode(await StorageManager.readData("user")));
      if(await StorageManager.readData("token") == null){
        StorageManager.saveData("token", mUser.apiToken);
        StorageManager.saveData("user_type", mUser.user_type);
      }
    }
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
  void onChangeFormRegister(int type,String value){
    switch (type) {
      case 0:
        mRegister.name = value.trim();
        break;
      case 1:
        mRegister.email = value.trim();
        break;
      case 2:
        mRegister.passWord = value.trim();
        break;
      case 3:
        mRegister.conFirmPassword = value.trim();
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
  registerValidate(){
    if(mRegister.name.isEmpty || mRegister.email.isEmpty || mRegister.passWord.isEmpty || mRegister.conFirmPassword.isEmpty) {
       setOnTapLogin(true);
      return Const.nullFormat;
    } else {
      if(mRegister.name.length < 3){
        setOnTapLogin(true);
        return Const.userNameFormat;
      }else if(!Utils.validateEmail(mRegister.email)){
        setOnTapLogin(true);
        return Const.emailFormat;
      } else if(mRegister.passWord.length < 6){
        setOnTapLogin(true);
        return Const.pwFormat;
      } else if(mRegister.passWord != mRegister.conFirmPassword){
        setOnTapLogin(true);
        return Const.pwDuplicate;
      } else {
        return null;
      }
    }
  }
  Future<MResults> actionRegister(BuildContext context) async {
    MResults mResults = MResults(loading: true,loaded: false,loadMore: false,loadFailed: false,message: "",data: null);
    String onMessage = await registerValidate();
    if(onMessage != null){
      Utils.showAlertMessage(context, onMessage);
    } else {
      mResults = await ApiResponse.register(field:[{"name":"${mRegister.name}"},{"email":"${mRegister.email}"},{"password":"${mRegister.passWord}"},{"c_password":"${mRegister.conFirmPassword}"}]);
    }
    return mResults;
  }
  Future<MResults> actionLogin(BuildContext context) async{
    MResults mResults = MResults(loading: true,loaded: false,loadMore: false,loadFailed: false,message: "",data: null);
    String onMessage = await loginValidate(email:formLogin[0].trim(),pw:formLogin[1].trim());
    if(onMessage != null){
      Utils.showAlertMessage(context, onMessage);
    }
    else {
      mResults = await ApiResponse.login(field:[{"email":"${formLogin[0]}"},{"password":"${formLogin[1]}"}]);
    }
    return mResults;
  }
}
