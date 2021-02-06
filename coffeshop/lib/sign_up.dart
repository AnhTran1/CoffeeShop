import 'dart:convert';

import 'package:coffeshop/common/storage_manager.dart';
import 'package:coffeshop/common/styles.dart';
import 'package:coffeshop/login.dart';
import 'package:coffeshop/model/m_user.dart';
import 'package:coffeshop/widget/login_widget/already_have_an_account_acheck.dart';
import 'package:coffeshop/widget/login_widget/rounded_button.dart';
import 'package:coffeshop/widget/login_widget/rounded_input_field.dart';
import 'package:coffeshop/widget/login_widget/rounded_password_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import 'bottom_navigation.dart';
import 'common/Utils.dart';
import 'notifier/user_notifier.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final RoundedLoadingButtonController _btnController = new RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    final userVM = Provider.of<UserModel>(context);
    if(userVM.onTapLogin){
      _btnController.reset();
    }
    return  Scaffold(
        body:Stack(
          alignment: Alignment.center,
          children: [
            GestureDetector(
              onTap: (){
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              child: ClipRect(
                child: Image.asset('assets/images/background_login.jpg',width: Utils.width(context),height: Utils.height(context),fit: BoxFit.fill),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(left: 10,right: 10,top: 16,bottom: 20),
                margin: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(7.0)),
                  color: BASE_APP_COLOR,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RoundedInputField(
                      hintText: "User name",
                      onChanged: (value) {
                        userVM.onChangeFormRegister(0,value);
                      },
                      icon: Icons.person,
                    ),
                    RoundedInputField(
                      hintText: "Email",
                      onChanged: (value) {
                        userVM.onChangeFormRegister(1,value);
                      },
                      icon: Icons.email,
                    ),
                    RoundedPasswordField(
                      onChanged: (value) {
                        userVM.onChangeFormRegister(2,value);
                      },
                      hint: "Password",
                    ),
                    RoundedPasswordField(
                      onChanged: (value) {
                        userVM.onChangeFormRegister(3,value);
                      },
                      hint: "Confirm password",
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      width: Utils.width(context) * 0.8,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(29),
                          child: RoundedLoadingButton(
                            child: Text(
                              "LOGIN",
                              style: TextStyle(color: WHITE_COLOR,fontSize: 16,fontWeight: FontWeight.bold),
                            ),
                            controller: _btnController,
                            color: ITEM_COLOR,
                            animateOnTap: true,
                            successColor: PRICE_COLOR,
                            onPressed: () async{
                              userVM.setOnTapLogin(false);
                              await Utils.hiddenKeyBoard(context);
                              userVM.actionRegister(context).then((value) => {
                                if(value.loaded){
                                  _btnController.success(),
                                  StorageManager.saveData("user", json.encode(value.data)),
                                  Future.delayed(Duration(milliseconds: 350),(){
                                    userVM.getUser();
                                    Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (context) => BottomNavigation()));
                                  })
                                } else if(value.loadFailed){
                                  _btnController.reset(),
                                  Utils.showAlertMessage(context, value.message)
                                }
                              });
                            },
                          )
                      ),
                    ),
                    AlreadyHaveAnAccountCheck(
                      login: false,
                      press: () {
                        Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (context) => Login()));
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
    );
  }
}
