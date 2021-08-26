import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:abc_trade/modules/cubit/cubit.dart';
import 'package:abc_trade/modules/cubit/state.dart';
import 'package:abc_trade/shared/components.dart';

class InstantRecommendations extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TradeCubit, TradeStates>(
        listener: (context, state){},
      builder: (context, state){
          var performance = TradeCubit.get(context);
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
                key: _scaffoldKey,
                drawer: defaultDrawer(context: context),
                appBar: defaultHomeAppBar(
                    context: context,
                    scaffoldKey: _scaffoldKey,
                    text: 'توصيات لحظية'
                ),
                body: ConditionalBuilder(
                  condition: state is! TradePerformanceShortError,
                  builder: (context)=> ConditionalBuilder(
                      condition: state is! TradePerformanceShortLoading,
                      builder: (context)=> SingleChildScrollView(
                        child: Padding(
                            padding: EdgeInsets.all(10.0),
                          child: ListView.separated(
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index)=> defaultBuildPerformanceShort(
                                performance.evaluationShort[index]
                              ),
                              separatorBuilder: (context , index)=> SizedBox(height: 5.0,),
                              itemCount: performance.evaluationShort.length),
                        ),
                      ),
                    fallback: (context)=> Center(child: CircularProgressIndicator(),),
                  ),
                  fallback: (context)=> Text('!!! Check Your Internet'),
                )
            ),
          );
      },
    );
  }
  Widget defaultBuildPerformanceShort(short) => Container(
    alignment: Alignment.topCenter,
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 7,
          offset: Offset(0, 3), // changes position of shadow
        ),
      ],
      color: Colors.white,
      borderRadius: BorderRadius.circular(15.0),
    ),
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.all(2.0),
          color: HexColor('#00AEAC'),
          child: Row(
            children: [
              Text('+ جديده', style: TextStyle(color: Colors.white, fontSize: 14),),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    Text('${short['rate']}%', style: TextStyle(color: HexColor('#FF6565')),),
                    Icon(Icons.arrow_downward_sharp, color: HexColor('#FF6565'),)
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 5.0,),
        Column(
          children: [
            Row(children: [
              Text('السهم', style: TextStyle(color: Colors.black, fontSize: 12.0),),Spacer(),
              Text(' بترو رابغ - ${short['code_name']}', style: TextStyle(color: HexColor('#00AEAC'), fontSize: 12.0),),
            ],), SizedBox(height: 3.0,),
            Row(children: [
              Text('النوع', style: TextStyle(color: Colors.black, fontSize: 12.0),),Spacer(),
              Text('${short['type']}', style: TextStyle(color: HexColor('#00AEAC'), fontSize: 12.0),),
            ],), SizedBox(height: 3.0,),
            Row(children: [
              Text('القطاع', style: TextStyle(color: Colors.black, fontSize: 12.0),),Spacer(),
              Text('${short['sector']}', style: TextStyle(color: HexColor('#00AEAC'), fontSize: 12.0),),
            ],), SizedBox(height: 3.0,),
            Row(children: [
              Text('نوع التوصية', style: TextStyle(color: Colors.black, fontSize: 12.0),),Spacer(),
              Text('${short['recommendation_name']}', style: TextStyle(color: HexColor('#00AEAC'), fontSize: 12.0),),
            ],), SizedBox(height: 3.0,),
            Row(children: [
              Text('سعر الشراء', style: TextStyle(color: Colors.black, fontSize: 12.0),),Spacer(),
              Text(' ريال ${short['buyPrice']}', style: TextStyle(color: HexColor('#00AEAC'), fontSize: 12.0),),
            ],), SizedBox(height: 3.0,),
            Row(children: [
              Text('سعر البيع', style: TextStyle(color: Colors.black, fontSize: 12.0),),Spacer(),
              Text(' ريال ${short['sellPrice']}', style: TextStyle(color: HexColor('#00AEAC'), fontSize: 12.0),),
            ],), SizedBox(height: 3.0,),
            Row(children: [
              Text('سعر وقف الخساره', style: TextStyle(color: Colors.black, fontSize: 12.0),),Spacer(),
              Text(' ريال ${short['stopLoss']}', style: TextStyle(color: HexColor('#00AEAC'), fontSize: 12.0),),
            ],), SizedBox(height: 3.0,),
            Row(children: [
              Text('تاريخ الانشاء', style: TextStyle(color: Colors.black, fontSize: 12.0),),Spacer(),
              Text('${short['created_at']}', style: TextStyle(color: HexColor('#00AEAC'), fontSize: 12.0),),
            ],), SizedBox(height: 3.0,),
            Row(children: [
              Text('تاريخ اخر تعديل', style: TextStyle(color: Colors.black, fontSize: 12.0),),Spacer(),
              Text('${short['updated_at']}', style: TextStyle(color: HexColor('#00AEAC'), fontSize: 12.0),),
            ],), SizedBox(height: 3.0,),
          ],
        ),
        SizedBox(height: 5.0,),
      ],
    ),
  );
}
