import 'dart:convert';

import 'package:coffeshop/bottom_navigation.dart';
import 'package:coffeshop/common/Utils.dart';
import 'package:coffeshop/common/storage_manager.dart';
import 'package:coffeshop/common/styles.dart';
import 'package:coffeshop/notifier/user_notifier.dart';
import 'package:coffeshop/sign_up.dart';
import 'package:coffeshop/widget/login_widget/already_have_an_account_acheck.dart';
import 'package:coffeshop/widget/login_widget/rounded_button.dart';
import 'package:coffeshop/widget/login_widget/rounded_input_field.dart';
import 'package:coffeshop/widget/login_widget/rounded_password_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}
class _LoginState extends State<Login> {
  final RoundedLoadingButtonController _btnController = new RoundedLoadingButtonController();
  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final userVM = Provider.of<UserModel>(context);
    if(userVM.onTapLogin){
      _btnController.reset();
    }
    return Scaffold(
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
                    hintText: "Email",
                    onChanged: (value) {
                      userVM.onChangeForm(0, value);
                    },
                    icon: Icons.email,
                  ),
                  RoundedPasswordField(
                    onChanged: (value) {
                      userVM.onChangeForm(1, value);
                    },
                    hint: "PassWord",
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
                          userVM.actionLogin(context).then((value) => {
                            if(value.loaded){
                              _btnController.success(),
                              StorageManager.saveData("user", json.encode(value.data)),
                              Future.delayed(Duration(milliseconds: 350),(){
                                userVM.getUser();
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => BottomNavigation()),
                                );
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
                    press: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => SignUp()),
                      );
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
