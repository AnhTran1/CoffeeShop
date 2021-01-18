import 'package:coffeshop/common/styles.dart';
import 'package:coffeshop/login.dart';
import 'package:coffeshop/widget/login_widget/already_have_an_account_acheck.dart';
import 'package:coffeshop/widget/login_widget/rounded_button.dart';
import 'package:coffeshop/widget/login_widget/rounded_input_field.dart';
import 'package:coffeshop/widget/login_widget/rounded_password_field.dart';
import 'package:flutter/material.dart';

import 'bottom_navigation.dart';
import 'common/Utils.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
                    RoundedInputField(
                      hintText: "User name",
                      onChanged: (value) {},
                      icon: Icons.person,
                    ),
                    RoundedPasswordField(
                      onChanged: (value) {},
                      hint: "Password",
                    ),
                    RoundedPasswordField(
                      onChanged: (value) {},
                      hint: "Confirm password",
                    ),
                    RoundedButton(
                      text: "SIGN UP",
                      press: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => BottomNavigation()),
                        );
                      },
                      color: ITEM_COLOR,
                    ),
                    AlreadyHaveAnAccountCheck(
                      login: false,
                      press: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
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
