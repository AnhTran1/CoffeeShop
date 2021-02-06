import 'package:coffeshop/common/Utils.dart';
import 'package:coffeshop/common/styles.dart';
import 'package:coffeshop/login.dart';
import 'package:coffeshop/notifier/user_notifier.dart';
import 'package:coffeshop/screen/address_list.dart';
import 'package:coffeshop/widget/clippath/ClippingUserTab.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final useVM = Provider.of<UserModel>(context);
    return  Container(
      color: Color(0xffffffff),
      height: Utils.height(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 2.0),
                child:ClipPath(
                  clipper: ClippingUserTab(),
                  child: Container(
                    width: Utils.width(context),
                    height: Utils.height(context) / 3 ,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/images/background_profile.jpg')
                        )
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: - 10,
                child: Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(7.0)),
                        gradient: LinearGradient(
                            colors: [
                              BASE_APP_COLOR.withOpacity(1),
                              BASE_APP_COLOR.withOpacity(0.7),
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter
                        ),
                      ),
                      margin: EdgeInsets.all(10.0),
                      height: 85.0,
                      width: Utils.width(context) - 20.0,
                      padding: EdgeInsets.only(left: (Utils.width(context) + 20) / 3,top: 10.0,right: 10.0,bottom: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("${useVM.mUser != null ? useVM.mUser.name.toUpperCase()  : "---"}",style: nameProfile,maxLines: 1),
                                SizedBox(height: 5),
                                Text("${useVM.mUser != null ? useVM.mUser.email : "---"}",style: profileMail,maxLines: 1) ,
                              ],
                            ),
                          ),
                          MaterialButton(
                            onPressed: () {
                              useVM.signOut().then((value) {
                                Navigator.of(context).pushReplacement( PageRouteBuilder(pageBuilder: (_, __, ___) => Login()));
                              });
                            },
                            child: Icon(
                              Icons.logout,
                              size: 20,
                              color: Colors.white,
                            ),
                            padding: EdgeInsets.only(left: 10, bottom: 0, top: 0),
                            height: 20.0,
                            minWidth: 20.0,
                            materialTapTargetSize:
                            MaterialTapTargetSize.shrinkWrap,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 130.0,
                      width: (Utils.width(context) - 50) / 3,
                      margin: EdgeInsets.only(left: 20.0,bottom: 20.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(16.0)),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(16.0)),
                        child: Image.asset('assets/images/background_profile.jpg',fit: BoxFit.cover),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          Expanded(
            child: AddressList(showAppbar: false)
          )
        ],
      ),
    );
  }
}
