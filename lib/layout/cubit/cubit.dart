import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:abc_trade/layout/cubit/states.dart';
import 'package:abc_trade/modules/main/main_screen.dart';
import 'package:abc_trade/modules/news/news_screen.dart';
import 'package:abc_trade/modules/package/package_screen.dart';
import 'package:abc_trade/modules/user/user_Screen.dart';
import 'package:abc_trade/shared/remote/dio_helper.dart';

class TradeHomeCubit extends Cubit<TradeHomeState> {
  TradeHomeCubit() : super(TradeHomeInitial());
  static TradeHomeCubit get(context) => BlocProvider.of(context);


  List<Widget> widget = [
    MainScreen(),
    PackageScreen(),
    NewsScreen(),
    UserScreen(),
  ];
  List<String> title = [
    'الرئيسية',
    'الباقات',
    'الاخبار',
   'حسابى',
  ];
  int currentIndex = 0;
  changeIndex(index) {
     currentIndex = index;
    emit(TradeHomeChangeIndex());
  }
  sendNotification() async
  {
    var token = await FirebaseMessaging.instance.getToken();
    var model = {
      "to": '$token',
      "notification": {
        "title": "you have received a message from amr nasser",
        "body": "testing body from post man",
        "sound": "default"
      },
      "android": {
        "priority": "HIGH",
        "notification": {
          "notification_priority": "PRIORITY_MAX",
          "sound": "default",
          "default_sound": true,
          "default_vibrate_timings": true,
          "default_light_settings": true
        }
      },
      "data": {
        "url": "hhhhh",
        "id": "yyyyyy",
      }
    };

    await DioHelper.postNotification(
      path: 'fcm/send',
      data: jsonEncode(model),
    ).then((value) {
      print('success');
      emit(TradeHomeSuccess());
    }).catchError((e) {
      print(e.toString());
      emit(TradeHomeError(e.toString()));
    });
  }
}
