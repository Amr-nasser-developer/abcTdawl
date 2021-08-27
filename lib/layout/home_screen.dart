import 'package:abc_trade/shared/local/shared.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:abc_trade/layout/cubit/cubit.dart';
import 'package:abc_trade/layout/cubit/states.dart';
import 'package:abc_trade/shared/components.dart';

class HomeScreen extends StatelessWidget {
  var widget;
  HomeScreen({this.widget});
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context)=> TradeHomeCubit(),
      child: BlocConsumer<TradeHomeCubit, TradeHomeState>(
        listener: (context, state){},
        builder: (context, state){
          var token = CashHelper.getData(key: 'loginToken');
          var trade = TradeHomeCubit.get(context);
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              key: _scaffoldKey,
              appBar: defaultHomeAppBar(
                token: token,
                  context: context,
                  text: trade.title[trade.currentIndex],
                  scaffoldKey: _scaffoldKey
              ),
              drawer: Directionality(
                textDirection: TextDirection.ltr ,
                child: defaultDrawer(context: context),
              ),
              body:(widget != null ) ? widget : trade.widget[trade.currentIndex],
              bottomNavigationBar:Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20), topLeft: Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 5 ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                  child: BottomNavigationBar(
                    showSelectedLabels: true,
                    fixedColor: Colors.black,
                    unselectedItemColor: Colors.black,
                    showUnselectedLabels: true,
                    type: BottomNavigationBarType.fixed,
                    items:<BottomNavigationBarItem> [
                      BottomNavigationBarItem(
                          icon: Image.asset('assets/images/main.png'),
                          label: 'الرئيسية'
                      ),//4
                      BottomNavigationBarItem(
                        icon: Image.asset('assets/images/qouta.png'),
                        label: 'الباقات',
                      ),//3
                      BottomNavigationBarItem(
                          icon: Image.asset('assets/images/news.png'),
                          label: 'الاخبار'
                      ),//2
                      BottomNavigationBarItem(
                        icon: Image.asset('assets/images/user.png'),
                        label: 'حسابى',
                      ), //1
                    ],
                    onTap: (index) {
                      widget = null;
                      trade.changeIndex(index);
                    },
                    currentIndex: trade.currentIndex,
                  ),
                ),
              ),
            ),
          );
        },
      )
    );
  }
}
