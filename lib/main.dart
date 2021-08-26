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

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async
{
  print('on background message');
  Fluttertoast.showToast(
      msg: 'New Notification',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0);

}
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CashHelper.init();
  Bloc.observer = MyBlocObserver();
  var dateTime = DateTime.now();
  var formate = "${dateTime.day}-${dateTime.month}-${dateTime.year}-${dateTime.hour}-${dateTime.minute}-${dateTime.second} ";
  await Firebase.initializeApp();
  FirebaseMessaging messaging = FirebaseMessaging.instance;

await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  FirebaseMessaging.instance.subscribeToTopic('topic');
  String? token = await FirebaseMessaging.instance.getToken();
  FirebaseMessaging.onMessage.listen((event) {
    Fluttertoast.showToast(
        msg: '${event.notification!.body}',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
        TradeCubit()..postNotificationData(event: event, formate: formate);
        print(formate);
  });
  FirebaseMessaging.onMessageOpenedApp.listen((event)
  {
    Fluttertoast.showToast(
        msg: '${event.notification!.body}',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
    print(event.data.toString());
    TradeCubit()..postNotificationData(event: event, formate: formate);
    print(formate);
  });
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  print('token $token');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) => TradeCubit()
                ..getPackage()
                ..getService()
                ..getNews()
                ..getRecommendationType()
                ..getContactInfo()
                ..getEvaluationLong()
                ..getEvaluationMonth()
                ..getEvaluationShort()
                ..getNotification()
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

