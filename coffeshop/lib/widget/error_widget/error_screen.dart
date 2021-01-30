import 'package:coffeshop/common/styles.dart';
import 'package:flutter/material.dart';
typedef VoidCallback = void Function();
// ignore: must_be_immutable
class ErrorScreen extends StatelessWidget {
  VoidCallback callbackRetry;
  ErrorScreen({this.callbackRetry});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/images/error_img.jpg",
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.15,
            left: MediaQuery.of(context).size.width * 0.3,
            right: MediaQuery.of(context).size.width * 0.3,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Error !",style: messageStyle),
                SizedBox(height: 16),
                Container(
                  width: 110,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 13),
                        blurRadius: 25,
                        color: Color(0xFF5666C2).withOpacity(0.17),
                      ),
                    ],
                  ),
                  child: FlatButton(
                    color: BASE_APP_COLOR,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                    onPressed: () {
                      callbackRetry();
                    },
                    child: Text(
                      "Retry",
                      style: button,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
