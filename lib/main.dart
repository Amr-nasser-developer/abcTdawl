import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:abc_trade/modules/cubit/cubit.dart';
import 'package:abc_trade/shared/local/shared.dart';
import 'package:abc_trade/shared/obServerCubit.dart';
import 'package:abc_trade/shared/remote/dio_helper.dart';
import 'package:abc_trade/view/splash_screen.dart';
var dateTime = DateTime.now();
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async
{
  await Firebase.initializeApp();
  print('on background message');
  print(message.notification!.body.toString());
  TradeCubit()..postNotificationData(body: message.notification!.body.toString(), formate: dateTime );
}
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CashHelper.init();
  Bloc.observer = MyBlocObserver();
  var dateTime = DateTime.now();
  await Firebase.initializeApp();
  String? tokenLogin = CashHelper.getData(key: 'loginToken');
  print(tokenLogin);
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    await messaging.requestPermission(
      alert: (tokenLogin != null) ? true : false,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: (tokenLogin != null) ? true : false,
    );
    FirebaseMessaging.onMessage.listen((event) {
      Fluttertoast.showToast(
          msg: 'New Notification From abcTdawl',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      TradeCubit()..postNotificationData(body: event.notification!.body.toString(), formate: dateTime);
      print(dateTime);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((event)
    {
      Fluttertoast.showToast(
          msg: 'New Notification From abcTdawl',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      print('data => ${event.data.toString()}');
      TradeCubit()..postNotificationData(body: event.notification!.body.toString(), formate: dateTime);
      print(dateTime);
    });
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) => TradeCubit()
                ..getSlider()
                ..getNotification()
                ..getPackage()
                ..getService()
                ..getNews()
                ..getRecommendationType()
                ..getContactInfo()
                ..getEvaluationLong()
                ..getEvaluationMonth()
                ..getEvaluationShort(createEvaluationShortSuccess: true)
        )
      ],
      child: MaterialApp(
        title: 'Trade',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Directionality(
            textDirection: TextDirection.rtl,
            child: SplashScreen()),
      ),
    );
  }
}

