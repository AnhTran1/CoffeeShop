import 'package:coffeshop/bottom_navigation.dart';
import 'package:coffeshop/common/Utils.dart';
import 'package:coffeshop/common/styles.dart';
import 'package:coffeshop/sign_up.dart';
import 'package:coffeshop/widget/login_widget/already_have_an_account_acheck.dart';
import 'package:coffeshop/widget/login_widget/rounded_button.dart';
import 'package:coffeshop/widget/login_widget/rounded_input_field.dart';
import 'package:coffeshop/widget/login_widget/rounded_password_field.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Stack(
        alignment: Alignment.center,
        children: [
          GestureDetector(
            onTap: (){
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: ClipRect(
              child: Image.asset('assets/image/background_login.jpg',width: Utils.width(context),height: Utils.height(context),fit: BoxFit.fill),
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
                    onChanged: (value) {},
                    icon: Icons.email,
                  ),
                  RoundedPasswordField(
                    onChanged: (value) {},
                    hint: "PassWord",
                  ),
                  RoundedButton(
                    text: "LOGIN",
                    press: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => BottomNavigation()),
                      );
                    },
                    color: ITEM_COLOR,
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
