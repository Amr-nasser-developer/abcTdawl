import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:abc_trade/model/create_user.dart';
import 'package:abc_trade/model/login.dart';
import 'package:abc_trade/model/rate.dart';
import 'package:abc_trade/modules/cubit/state.dart';
import 'package:abc_trade/shared/local/shared.dart';
import 'package:abc_trade/shared/remote/dio_helper.dart';

class TradeCubit extends Cubit<TradeStates>{
  TradeCubit() : super(TradeInitial());
  static TradeCubit get(context) => BlocProvider.of(context);

  List<dynamic> packages = [];
  getPackage(){
    emit(TradePackageLoading());
    DioHelper.getData(
        url: 'package',
    ).then((value){
      emit(TradePackageSuccess());
      packages = value.data['PACKAGES'];
    }).catchError((e){
      print(e.toString());
      emit(TradePackageError(e.toString()));
    });
  }
  List<dynamic> service = [];
  getService(){
    emit(TradeServiceLoading());
    DioHelper.getData(
      url: 'services',
    ).then((value){
      emit(TradeServiceSuccess());
      service = value.data['SERVICES'];
    }).catchError((e){
      print(e.toString());
      emit(TradeServiceError(e.toString()));
    });
  }
  List<dynamic> news = [];
  int totalPageNews = 0;
  int currentPageNews = 1;
  getNews(){
    emit(TradeNewsLoading());
    DioHelper.getData(
      query: {
        'page': currentPageNews,
        'per_page' : 20
      },
      url: 'reports',
    ).then((value){
      emit(TradeNewsSuccess());
      news = value.data['REPORTS']['data'];
      currentPageNews++;
      totalPageNews = value.data['REPORTS']['last_page'];
    }).catchError((e){
      print(e.toString());
      emit(TradeNewsError(e.toString()));
    });
  }
  getNewsMore(){
    emit(TradeNewsMoreLoading());
    DioHelper.getData(
      query: {
        'page' : currentPageNews
      },
      url: 'reports',
    ).then((value){
      emit(TradeNewsMoreSuccess());
      news.addAll(value.data['REPORTS']['data']);
      currentPageNews++;
    }).catchError((e){
      print(e.toString());
      emit(TradeNewsMoreError(e.toString()));
    });
  }
  List<dynamic> newsDetails = [];
  getNewsDetails({id}){
    emit(TradeNewsDetailsLoading());
    DioHelper.getData(
      url: 'viewReport?id=$id',
    ).then((value){
      emit(TradeNewsDetailsSuccess());
      newsDetails = value.data['REPORT'];
      print(value.data);
    }).catchError((e){
      print(e.toString());
      emit(TradeNewsDetailsError(e.toString()));
    });
  }
  int totalPageRecommendation= 0;
  int currentPageRecommendation= 1;
  List<dynamic> recommendations = [];
  getRecommendation({id, type}){
    emit(TradeRecommandLoading());
    DioHelper.getData(
      url: 'recommendations',
      query: {
        'id' : id,
        'type' : type,
        'per_page' : 10,
        'current_page' : currentPageRecommendation
      }
    ).then((value){
      emit(TradeRecommandSuccess());
      recommendations = value.data['RECOMMENDATIONS']['data'];
      currentPageRecommendation++;
      totalPageRecommendation = value.data['RECOMMENDATIONS']['last_page'];
      print(value.data);
    }).catchError((e){
      print(e.toString());
      emit(TradeRecommandError(e.toString()));
    });
  }
  getRecommendationMore({id, type}){
    emit(TradeRecommandMoreLoading());
    DioHelper.getData(
        url: 'recommendations',
        query: {
          'current_page' : currentPageRecommendation
        }
    ).then((value){
      emit(TradeRecommandMoreSuccess());
      recommendations.addAll(value.data['RECOMMENDATIONS']['data']);
      currentPageRecommendation++;
      print(value.data);
    }).catchError((e){
      print(e.toString());
      emit(TradeRecommandMoreError(e.toString()));
    });
  }

  List<dynamic> recommendationsType = [];
  getRecommendationType(){
    emit(TradeRecommandTypeLoading());
    DioHelper.getData(
      url: 'recommendations/types',
    ).then((value){
      emit(TradeRecommandTypeSuccess());
      recommendationsType = value.data['TYPES'];
      print(value.data);
    }).catchError((e){
      print(e.toString());
      emit(TradeRecommandTypeError(e.toString()));
    });
  }
  List<dynamic> contactUs = [];
  postContactUs({name , phone, email}){
    emit(TradeContactUSLoading());
    DioHelper.postData(
      url: 'contactUs',
      query: {
        'name': name,
        'email':email,
        'phone' : phone,
      }
    ).then((value){
      emit(TradeContactUSSuccess());
      contactUs = value.data['contactUs'];
      print(value.data);
    }).catchError((e){
      print(e.toString());
      emit(TradeContactUSError(e.toString()));
    });
  }
  List<dynamic> contactInfo = [];
  getContactInfo(){
    emit(TradeContactInfoLoading());
    DioHelper.getData(
      url: 'contactInfo',
    ).then((value){
      emit(TradeContactInfoSuccess());
      contactInfo = value.data['CONTACTINFO'];
      print(value.data);
    }).catchError((e){
      print(e.toString());
      emit(TradeContactInfoError(e.toString()));
    });
  }
  List<dynamic> evaluationLong = [];
  getEvaluationLong(){
    emit(TradePerformanceYearLoading());
    DioHelper.getData(
      url: 'evaluation/long',
    ).then((value){
      emit(TradePerformanceYearSuccess());
      evaluationLong = value.data['DATA'];
      print(value.data);
    }).catchError((e){
      print(e.toString());
      emit(TradePerformanceYearError(e.toString()));
    });
  }
  List<dynamic> evaluationMonth = [];
  getEvaluationMonth(){
    emit(TradePerformanceMonthLoading());
    DioHelper.getData(
      url: 'evaluation/long/month',
    ).then((value){
      emit(TradePerformanceMonthSuccess());
      evaluationMonth = value.data['MONTHS'];
      print(value.data);
    }).catchError((e){
      print(e.toString());
      emit(TradePerformanceMonthError(e.toString()));
    });
  }
  List<dynamic> evaluationShort =[];
  int currentPageShort = 1;
  int totalPageShort = 0;
  Rate? rate;
  getEvaluationShort(){
    emit(TradePerformanceShortLoading());
    DioHelper.getData(
      query: {
        'page' : currentPageShort,
        'per_page' : 20
      },
      url: 'evaluation/short',
    ).then((value){
      emit(TradePerformanceShortSuccess());
      evaluationShort = value.data['DATA']['recommendations'];
      rate = Rate.fromJson(value.data);
      currentPageShort++;
      totalPageShort = value.data['DATA']['recommendations_all'];
    }).catchError((e){
      print(e.toString());
      emit(TradePerformanceShortError(e.toString()));
    });
  }
  getEvaluationShortMore(){
    emit(TradePerformanceShortMoreLoading());
    DioHelper.getData(
      query: {
        'page' : currentPageShort,
      },
      url: 'evaluation/short',
    ).then((value){
      emit(TradePerformanceShortMoreSuccess());
      evaluationShort.addAll( value.data['DATA']['recommendations']);
      currentPageShort++;
    }).catchError((e){
      print(e.toString());
      emit(TradePerformanceShortMoreError(e.toString()));
    });
  }
  Login? login;
  loginUser({password, email}){
    emit(TradeLoginLoading());
    DioHelper.postData(
      url: 'auth/login',
      query: {
        'email': email,
        'password': password
      }
    ).then((value){
      login = Login.fromJson(value.data);
      loginFirebase(
        email: email,
        password: password
      );
      emit(TradeLoginSuccess());
      print(value.data);
    }).catchError((e){
      print(e.toString());
      emit(TradeLoginError(e.toString()));
    });
  }
  getToken()async{
    await FirebaseMessaging.instance.getToken();
  }
  loginFirebase({email , password}) async{
    emit(TradeLoginFirebaseLoading());
    FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value){
      emit(TradeLoginFirebaseSuccess());
      print('login firebase success');
    }).catchError((e){
      print(e.toString());
      emit(TradeLoginFirebaseError(e.toString()));
    });
  }
  saveDeviceToken({user_id, device_id}){
    emit(TradeSaveDeviceTokenLoading());
    DioHelper.postData(
        url: 'notification/set',
        query: {
          'user_id': user_id,
          'device_id' :device_id
        }
    ).then((value){
      emit(TradeSaveDeviceTokenSuccess());
      print(value.data);
    }).catchError((e){
      print(e.toString());
      emit(TradeSaveDeviceTokenError(e.toString()));
    });
  }
   var userIdApi;
   var userIdFirebase;
  Register? registers;
  register({password, email, name, package, stock_type, phone, country_id}){
    emit(TradeRegisterLoading());
    DioHelper.postData(
        url: 'auth/register',
        query: {
          'email': email,
          'password': password,
          'name': name,
          'package': package,
          'stock_type': '1',
          'phone': phone,
          'country_id': '2',
          'member_type' : 'r'
        }
    ).then((value){
      registers = Register.fromJson(value.data);
      FirebaseFirestore.instance.collection('user').add({
        'email': email,
      }).then((value){
        print('Firebase Save Success');
        var firebase = value.id;
        print(firebase);
         CashHelper.setData(key: 'userIdFirebase', value: firebase);
         saveDeviceToken(
           device_id: value.id,
           user_id:registers!.user!.id
         );
        registerFirebase(
          email: email,
          password: password
        );
        emit(TradeRegisterSuccess());
      }).catchError((e){
        emit(TradeRegisterError(e.toString()));
      });
    }).catchError((e) {
      print(e.toString());
    });
  }
  registerFirebase({ email , password}){
    emit(TradeRegisterFirebaseLoading());
    FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password)
        .then((value){
    }).catchError((e){
      emit(TradeRegisterFirebaseError(e));
      print(e.toString());
    });
  }

  freeRegister({email, name, phone}){
    emit(TradeFreeRegisterLoading());
    DioHelper.postData(
        url: 'auth/freeRegister',
        query: {
          'email': email,
          'name': name,
          'phone': phone,
        }
    ).then((value){
      emit(TradeFreeRegisterSuccess());
      print(value.data);
    }).catchError((e){
      print(e.toString());
      emit(TradeFreeRegisterError(e.toString()));
    });
  }
   var id ;

  postNotificationData({event, formate}){
    emit(TradePostNotificationLoading());
    FirebaseFirestore.instance.collection('notification').add({
      'body' :  event.notification!.body,
      'title' : event.notification!.title,
      'time' : formate
    }).then((value){
      id = value.id;
      emit(TradePostNotificationSuccess());
      print('save post notification');
    }).catchError((e){
      emit(TradePostNotificationError(e.toString()));
    });
  }
  List<dynamic>? notification = [];
  String? notificationId;
  String? currentNotificationId;
  String? singleNotificationId;
  getNotification() async {
    emit(TradeGetNotificationLoading());
    FirebaseFirestore.instance
        .collection('notification')
        .orderBy('time')
        .get()
        .then((QuerySnapshot querySnapshot){
      querySnapshot.docs.forEach((doc) {
        notification = querySnapshot.docs;
         notificationId = querySnapshot.docs.first.id;
         print('notificationId $notificationId');
        emit(TradeGetNotificationSuccess());
      });
    }).catchError((e) {
      emit(TradeGetNotificationError(e.toString()));
      print(e.toString());
    });
  }

}