import 'package:coffeshop/bottom_navigation.dart';
import 'package:coffeshop/bottom_navigation_admin.dart';
import 'package:coffeshop/common/storage_manager.dart';
import 'package:coffeshop/login.dart';
import 'package:coffeshop/notifier/product_notifier.dart';
import 'package:coffeshop/notifier/user_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    init();
    super.initState();
  }
  void init() async{
    var pVM = Provider.of<ProductModel>(context,listen: false);
    var useVM = Provider.of<UserModel>(context,listen: false);
    useVM.getUser();
    pVM.getCategory().then((value) {
      navigatorPage();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown,
    );
  }
  void navigatorPage() async {
    String token = await StorageManager.readData("token");
    int user_type = await StorageManager.readData("user_type");
    await Future.delayed(Duration(milliseconds: 350),(){
     if (token == null) {
        Navigator.of(context).pushReplacement(PageRouteBuilder(pageBuilder: (_, __, ___) => Login()));
     } else {
     if (user_type == 0){
         Navigator.of(context).pushReplacement( PageRouteBuilder(pageBuilder: (_, __, ___) => BottomNavigationAdmin()));
       }
     else {
       Navigator.of(context).pushReplacement( PageRouteBuilder(pageBuilder: (_, __, ___) => BottomNavigation()));
       }
     }
   });
  }
}
