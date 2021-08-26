import 'package:abc_trade/shared/local/shared.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:abc_trade/modules/cubit/cubit.dart';
import 'package:abc_trade/modules/cubit/state.dart';
import 'package:abc_trade/shared/components.dart';

class NotificationScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var token = CashHelper.getData(key: 'loginToken');
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=> TradeCubit()..getNotification(),
      child: BlocConsumer<TradeCubit, TradeStates>(
          listener: (context, state){
            if(state is TradePostNotificationSuccess){
            }
          },
      builder: (context, state){
            return Scaffold(
                key: _scaffoldKey,
                drawer: defaultDrawer(context: context),
                appBar: AppBar(
                  leading: IconButton(
                      onPressed: (){},
                      icon: Image.asset('assets/images/noti.png')
                  ),
                  title:Text('الاشعارات') ,
                  actions: [
                    IconButton(
                        onPressed: (){
                          _scaffoldKey.currentState!.openDrawer();
                        },
                        icon: Image.asset('assets/images/menu.png')
                    )
                  ],
                  centerTitle: true,
                  backgroundColor: HexColor('#00AEAC'),
                  toolbarHeight: 50,
                ),
                body: ConditionalBuilder(
                    condition: state is! TradeGetNotificationError,
                    builder: (context)=> ConditionalBuilder(
                        condition: state is! TradeGetNotificationLoading,
                        builder: (context)=> ConditionalBuilder(
                            condition: TradeCubit.get(context).notification != null,
                            builder: (context)=> SingleChildScrollView(
                              child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: ListView.separated(
                                    shrinkWrap: true,
                                    physics: BouncingScrollPhysics(),
                                    itemBuilder: (context, index)=> defaultbuildNotification(
                                        sourceImage: 'assets/images/noti.png',
                                        noti: TradeCubit.get(context).notification![index],
                                      id: TradeCubit.get(context).notificationId,
                                        context :context
                                    ) ,
                                    separatorBuilder: (context, index)=> SizedBox(height: 10,),
                                    itemCount: TradeCubit.get(context).notification!.length,
                                ),
                              ),
                            ),
                          fallback: (context)=> Center(child: Text('No Notification Found'),),
                        ),
                      fallback: (context)=>Center(child: Text('No Notification Found')),
                    ),
                  fallback: (context)=> Center(child: Text('!!! Check Your Internet'),),
                )
            );
      },
      ),
    );
  }
  Widget defaultbuildNotification({sourceImage, noti,id, context}) => Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0),
    height: 75.0,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(
          color: HexColor('#00AEAC'),
        )),
    child: Row(
      children: [Image.asset(sourceImage), Spacer(), Text('${noti['body']}'),Spacer(),
      IconButton(
          onPressed: (){
            FirebaseFirestore.instance.collection('notification').doc(id).delete();
          },
          icon: Icon(Icons.delete)
      )
      ],
    ),
  );

}
