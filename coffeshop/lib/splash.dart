import 'package:coffeshop/bottom_navigation.dart';
import 'package:coffeshop/common/storage_manager.dart';
import 'package:coffeshop/login.dart';
import 'package:flutter/material.dart';
class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    navigatorPage();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(),
    );
  }
  void navigatorPage() async {
    String token = await StorageManager.readData("token");
    if (token != null) {
      Navigator.of(context).pushReplacement(PageRouteBuilder(pageBuilder: (_, __, ___) => Login()));
    } else {
      Navigator.of(context).pushReplacement( PageRouteBuilder(pageBuilder: (_, __, ___) => BottomNavigation()));
    }
  }
}
