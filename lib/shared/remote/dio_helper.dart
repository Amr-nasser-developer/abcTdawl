import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioHelper{
  static Dio? dio;

  static init(){
    dio = Dio(
      BaseOptions(
        baseUrl: 'http://abctdawl.com/api/v1/',
        receiveDataWhenStatusError: true,
        headers: {
          'Accept':'application/json',
        }
      )
    );
  }
  static Future<Response> getData({@required String? url , Map<String , dynamic>? query , String? token})async {
    // String token = await CashHelper.getData(key: 'token');
    dio!.options.headers={
      'Accept':'application/json',
      'Authorization': 'Bearer $token'
    };
    return await dio!.get(url!, queryParameters: query);
  }


  static Future<Response> postData({@required String? url , Map<String , dynamic>? query,
    String? token
  })async
  {
    // String token = await CashHelper.getData(key: 'token');
    if(token != null){
      dio!.options.headers = {
        'Accept':'application/json',
        'Authorization': 'Bearer $token',
      };
    }

    return await dio!.post(url!, queryParameters: query);
  }
  static Future<Response> postNotification({path, data}) async {
    dio!.options.baseUrl = 'https://fcm.googleapis.com/';
    dio!.options.headers =
    {
      'Content-Type':'application/json',
      'Authorization' : 'key=AAAAfpiduQ0:APA91bFm4obUmA9yMzN_5eCt36XMW229rqcMTeHSIKOoyqAxbfZJ7jxKCHLoY1CjXBxQolmckActXB6eb_7S9zdxtZFGWz9DPJGG6drkN4nidogBdks2k70qlgbvxvEFHt-J80m_ynAC',
    };

    return await dio!.post(path, data: data??null,);
  }

}