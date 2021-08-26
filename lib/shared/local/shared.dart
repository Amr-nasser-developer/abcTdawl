import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CashHelper{
  static SharedPreferences? sharedPreferences ;

  static init()async{
    sharedPreferences = await SharedPreferences.getInstance();
  }
 static dynamic getData({@required key}){
    return  sharedPreferences!.get(key);
  }

  static Future<bool> deleteData({@required key})async{
    return await sharedPreferences!.remove(key);
  }

  static Future<bool> setData({@required key, @required value})async{
    if(value is String) return await sharedPreferences!.setString(key, value);
    if(value is double) return await sharedPreferences!.setDouble(key, value);
    if(value is int) return await sharedPreferences!.setInt(key, value);
    return await sharedPreferences!.setBool(key, value);
  }
}