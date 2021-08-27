import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:abc_trade/layout/home_screen.dart';
import 'package:abc_trade/modules/user/user_Screen.dart';
import 'package:abc_trade/shared/components.dart';
import 'package:abc_trade/shared/local/shared.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('You Are Already Signed In'),
        SizedBox(height: 10.0,),
        defaultMaterialButton(
            login: true,
            text: 'LogOut',
            function: (){
            CashHelper.deleteData(key: 'loginToken').then((value){
              FirebaseMessaging.instance.unsubscribeFromTopic('abc');
              defaultFinishNavigate(context: context, widget: HomeScreen(widget: UserScreen(),));
            });
            }
            )
      ],
    ),

    );
  }
}
