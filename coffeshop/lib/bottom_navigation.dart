import 'package:coffeshop/common/styles.dart';
import 'package:coffeshop/screen/cart.dart';
import 'package:coffeshop/screen/home.dart';
import 'package:coffeshop/screen/order_list.dart';
import 'package:coffeshop/screen/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  CupertinoTabController cupertinoTabController = CupertinoTabController();
  int currentIndex = 0;
  var selectedColor = 0xFF448dec;
  var unselectedColor = 0xFF6e6e6e;
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        body: IndexedStack(
          children: [
            Home(),
            OrderList(),
            Cart(),
            Profile()
          ],
          index: currentIndex,
        ),
        bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(
                canvasColor: BASE_APP_COLOR,
                splashColor: Colors.grey.withOpacity(0.1),
                highlightColor: Colors.transparent,
                textTheme: Theme.of(context).textTheme.copyWith(caption: TextStyle(color: Colors.black26.withOpacity(0.15)))),
            child: Container(
              height: MediaQuery.of(context).padding.bottom + 60.0,
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                mouseCursor: MouseCursor.defer,
                currentIndex: currentIndex,
                selectedItemColor: WHITE_COLOR,
                unselectedItemColor: TAB_COLOR,
                onTap: (value) {
                  setState(() {
                    currentIndex = value;
                  });
                },
                items: [
                  BottomNavigationBarItem(icon: Icon(Icons.home),title: Text("")),
                  BottomNavigationBarItem(icon: Icon(Icons.motorcycle_outlined),title: Text("")),
                  BottomNavigationBarItem(icon: Icon(Icons.shopping_cart),title: Text("")),
                  BottomNavigationBarItem(icon: Icon(Icons.account_circle),title: Text("")),
                ],
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  )),
            )),
      ),

    );
  }
}
