import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:abc_trade/modules/cubit/cubit.dart';
import 'package:abc_trade/modules/cubit/state.dart';
import 'package:abc_trade/shared/components.dart';

class RecommendationsScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String? name;
  RecommendationsScreen(this.name);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TradeCubit, TradeStates>(
      listener: (context, state){},
        builder: (context, state){
        var reco = TradeCubit.get(context);
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            key: _scaffoldKey,
            appBar: defaultHomeAppBar(
                context: context,
                text: ' توصيات $name',
                scaffoldKey: _scaffoldKey
            ),
            drawer: defaultDrawer(context: context),
            body: ConditionalBuilder(
                condition: state is! TradeRecommandError,
                builder: (context)=> ConditionalBuilder(
                    condition: state is! TradeRecommandLoading,
                    builder: (context)=> SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            ListView.separated(
                              shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (context, index)=> defaultBuildRecommendation(
                                  reco.recommendations[index]
                                ),
                                separatorBuilder: (context, index)=> SizedBox(height: 5.0,),
                                itemCount: reco.recommendations.length
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Stack(
                              alignment: Alignment.center,
                              children:
                              [
                                Container(),
                                if(state is! TradeRecommandMoreLoading && reco.currentPageRecommendation <= reco.totalPageRecommendation)
                                  defaultMaterialButtonBag(
                                    function: ()
                                    {
                                      if(reco.currentPageRecommendation <= reco.totalPageRecommendation)
                                        reco.getRecommendationMore();
                                    },
                                  ),
                                if(state is TradeNewsMoreLoading)
                                  CircularProgressIndicator(),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  fallback: (context)=> Center(child: CircularProgressIndicator(),),
                ),
              fallback: (context)=> Center(child: Text('!!! Check Your Internet'),),
            )
          ),
        );
        },
    );
  }
  Widget defaultBuildRecommendation(reco) => Container(
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
                    Text('${reco['rate']}%', style: TextStyle(color: HexColor('#FF6565')),),
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
              Text(' بترو رابغ - ${reco['code_name']}', style: TextStyle(color: HexColor('#00AEAC'), fontSize: 12.0),),
            ],), SizedBox(height: 3.0,),
            Row(children: [
              Text('النوع', style: TextStyle(color: Colors.black, fontSize: 12.0),),Spacer(),
              Text('${reco['type']}', style: TextStyle(color: HexColor('#00AEAC'), fontSize: 12.0),),
            ],), SizedBox(height: 3.0,),
            Row(children: [
              Text('القطاع', style: TextStyle(color: Colors.black, fontSize: 12.0),),Spacer(),
              Text('${reco['sector']}', style: TextStyle(color: HexColor('#00AEAC'), fontSize: 12.0),),
            ],), SizedBox(height: 3.0,),
            Row(children: [
              Text('نوع التوصية', style: TextStyle(color: Colors.black, fontSize: 12.0),),Spacer(),
              Text('${reco['recommendation_name']}', style: TextStyle(color: HexColor('#00AEAC'), fontSize: 12.0),),
            ],), SizedBox(height: 3.0,),
            Row(children: [
              Text('سعر الشراء', style: TextStyle(color: Colors.black, fontSize: 12.0),),Spacer(),
              Text(' ريال ${reco['buyPrice']}', style: TextStyle(color: HexColor('#00AEAC'), fontSize: 12.0),),
            ],), SizedBox(height: 3.0,),
            Row(children: [
              Text('سعر البيع', style: TextStyle(color: Colors.black, fontSize: 12.0),),Spacer(),
              Text(' ريال ${reco['sellPrice']}', style: TextStyle(color: HexColor('#00AEAC'), fontSize: 12.0),),
            ],), SizedBox(height: 3.0,),
            Row(children: [
              Text('سعر وقف الخساره', style: TextStyle(color: Colors.black, fontSize: 12.0),),Spacer(),
              Text(' ريال ${reco['stopLoss']}', style: TextStyle(color: HexColor('#00AEAC'), fontSize: 12.0),),
            ],), SizedBox(height: 3.0,),
            Row(children: [
              Text('تاريخ الانشاء', style: TextStyle(color: Colors.black, fontSize: 12.0),),Spacer(),
              Text('${reco['created_at']}', style: TextStyle(color: HexColor('#00AEAC'), fontSize: 12.0),),
            ],), SizedBox(height: 3.0,),
            Row(children: [
              Text('تاريخ اخر تعديل', style: TextStyle(color: Colors.black, fontSize: 12.0),),Spacer(),
              Text('${reco['updated_at']}', style: TextStyle(color: HexColor('#00AEAC'), fontSize: 12.0),),
            ],), SizedBox(height: 3.0,),
          ],
        ),
        SizedBox(height: 5.0,),
      ],
    ),
  );
}
