import 'package:coffeshop/common/styles.dart';
import 'package:flutter/material.dart';

class Utils {
  static width(context) {
    return MediaQuery.of(context).size.width;
  }

  static height(context) {
    return MediaQuery.of(context).size.height;
  }
  static paddingBottom(context) {
    return MediaQuery.of(context).padding.bottom;
  }

  static paddingTop(context) {
    return MediaQuery.of(context).padding.top;
  }
  static hiddenKeyBoard(context) async{
    await Future.delayed(Duration(milliseconds: 50),(){
      FocusScope.of(context).requestFocus(new FocusNode());
    });
  }
  static bool validateEmail(String email) {
    if (email.length > 0) {
      Pattern pattern =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regex = new RegExp(pattern);
      if (regex.hasMatch(email)) {
        return true;
      }
    }
    return false;
  }
  static Future<void>  showAlertMessage(context,String message) async{
    showDialog<int>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Thông báo"),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'OK',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () => Navigator.pop(context, 0),
            ),
          ],
        );
      },
    );
  }
  static void showLoading(context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return  WillPopScope(
          onWillPop: () async => false,
          child: Center(
            child: CircularProgressIndicator(
              backgroundColor: BASE_APP_COLOR,
            ),
          ),
        );
      },
    );
  }
  static void showSnackBarWithKey(GlobalKey<ScaffoldState> key, String message, color) {
    key.currentState.removeCurrentSnackBar();
    key.currentState.showSnackBar(SnackBar(
        content: Container(
          height: 30,
          child: Text(
            message,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.start,
          ),
        ),
        duration: Duration(milliseconds: 1000),
        backgroundColor: color));
  }
}
