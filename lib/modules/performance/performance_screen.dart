import 'package:abc_trade/shared/local/shared.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:abc_trade/modules/cubit/cubit.dart';
import 'package:abc_trade/modules/cubit/state.dart';
import 'package:abc_trade/shared/components.dart';

class PerformanceRateScreen extends StatefulWidget {
  @override
  _PerformanceRateScreenState createState() => _PerformanceRateScreenState();
}

class _PerformanceRateScreenState extends State<PerformanceRateScreen> {
  String? _mySelectionYear;
  GlobalKey<dynamic> dropBottonKeyYear= GlobalKey();
  String? _mySelectionMonth;
  GlobalKey<dynamic> dropBottonKeyMonth= GlobalKey();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TradeCubit, TradeStates>(
        listener: (context, state){},
      builder: (context, state){
        List months = ['1','2','3','4','5','6','7','8','9','10','11','12'];
        var width = MediaQuery.of(context).size.width;
        var year = TradeCubit.get(context);
        var perfor = TradeCubit.get(context);
        var token = CashHelper.getData(key: 'loginToken');
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              key: _scaffoldKey,
              drawer: defaultDrawer(context: context),
              appBar: defaultHomeAppBar(
                token: token,
                context: context,
                scaffoldKey: _scaffoldKey,
                text: 'معدل الأداء',
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      defaultDropButton(
                          hint: 'العام',
                          key: dropBottonKeyYear,
                          listItem: year.evaluationLong.map((item) {
                            return new DropdownMenuItem(
                              child: new Text(item),
                              value: item,
                            );
                          }).toList(),
                          function: (newVal) {
                            setState(() {
                              _mySelectionYear = newVal;
                            });
                          },
                          value: _mySelectionYear
                      ),
                      SizedBox(height: 5,),
                      defaultDropButton(
                          hint: 'الشهر',
                          key: dropBottonKeyMonth,
                          listItem: months.map((item) {
                            return new DropdownMenuItem(
                              child: new Text(item),
                              value: item,
                            );
                          }).toList(),
                          function: (newVal) {
                            setState(() {
                              _mySelectionMonth = newVal as String;
                            });
                          },
                          value: _mySelectionMonth
                      ),
                      SizedBox(height: 5,),
                      ConditionalBuilder(
                        condition: state is! TradePerformanceShortError ,
                        builder: (context)=> ConditionalBuilder(
                            condition: (state is! TradePerformanceShortLoading),
                            builder: (context)=>defaultMaterialButton(
                                text: 'بحث',
                                function: (){
                                  print(_mySelectionMonth);
                                  TradeCubit.get(context).getEvaluationShort(
                                      year: _mySelectionYear,
                                      month: _mySelectionMonth,
                                      createEvaluationShortSuccess: true
                                  );
                                  print(_mySelectionMonth);
                                  print(_mySelectionYear);
                                }
                            ),
                          fallback: (context)=> Center(child: CircularProgressIndicator(),),
                        ),
                        fallback: (context)=>defaultMaterialButton(
                            text: 'بحث',
                            function: (){
                              print(_mySelectionMonth);
                              TradeCubit.get(context).getEvaluationShort(
                                  year: _mySelectionYear,
                                  month: _mySelectionMonth,
                                  createEvaluationShortSuccess: true
                              );
                              print(_mySelectionMonth);
                              print(_mySelectionYear);
                            }
                        ),
                      ),
                      SizedBox(height: 15.0,),
                      ConditionalBuilder(
                        condition: state is! TradePerformanceShortError,
                        builder: (context) => ConditionalBuilder(
                          condition: perfor.rate != null,
                          builder: (context) => ConditionalBuilder(
                              condition: state is! TradePerformanceShortLoading,
                              builder: (context) =>  defaultBuildDataDetails(context: context, width: width),
                          fallback: (context)=> Center(child: CircularProgressIndicator(),),
                          ),
                          fallback: (context) => Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        fallback: (context) =>
                            Center(child: Text('!!! Check Your Internet')),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      ConditionalBuilder(
                        condition: state is! TradePerformanceShortError,
                        builder: (context) => ConditionalBuilder(
                          condition: perfor.rate != null,
                          builder: (context) => ConditionalBuilder(
                              condition: state is! TradePerformanceShortLoading,
                              builder: (context)=> Column(
                                children: [
                                  ListView.separated(
                                      shrinkWrap: true,
                                      physics: BouncingScrollPhysics(),
                                      itemBuilder: (context, index)=> defaultBuildPerformanceShort(
                                          TradeCubit.get(context).evaluationShort[index]
                                      ),
                                      separatorBuilder: (context, index)=> SizedBox(height: 5.0,),
                                      itemCount: TradeCubit.get(context).evaluationShort.length
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Stack(
                                    alignment: Alignment.center,
                                    children:
                                    [
                                      Container(),
                                      if(state is! TradePerformanceShortMoreLoading && perfor.currentPageShort <= perfor.totalPageShort)
                                        defaultMaterialButtonBag(
                                          function: ()
                                          {
                                            if(perfor.currentPageShort <= perfor.totalPageShort)
                                              perfor.getEvaluationShortMore(
                                                  month: _mySelectionMonth,
                                                year: _mySelectionYear
                                              );
                                          },
                                        ),
                                      if(state is TradePerformanceShortMoreLoading)
                                        CircularProgressIndicator(),
                                    ],
                                  ),
                                ],
                              ),
                          fallback: (context)=> Center(child: CircularProgressIndicator(),),
                          ),
                          fallback: (context) => Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        fallback: (context) =>
                            Center(child: Text('!!! Check Your Internet')),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
      },
    );
  }
  Widget defaultBuildPerformanceShort(rate) => Container(
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
    child:  Column(
      children: [
        Row(children: [
          Text('كود السهم', style: TextStyle(color: Colors.black, fontSize: 12.0),),Spacer(),
          Text('${rate['code_name']}', style: TextStyle(color: HexColor('#00AEAC'), fontSize: 12.0),),
        ],), SizedBox(height: 3.0,),
        Row(children: [
          Text('القطاع', style: TextStyle(color: Colors.black, fontSize: 12.0),),Spacer(),
          Text('${rate['sector']}', style: TextStyle(color: HexColor('#00AEAC'), fontSize: 12.0),),
        ],), SizedBox(height: 3.0,),
        Row(children: [
          Text('السهم', style: TextStyle(color: Colors.black, fontSize: 12.0),),Spacer(),
          Text('${rate['recommendation_name']}', style: TextStyle(color: HexColor('#00AEAC'), fontSize: 12.0),),
        ],), SizedBox(height: 3.0,),
        Row(children: [
          Text('قائمة الشرعية', style: TextStyle(color: Colors.black, fontSize: 12.0),),Spacer(),
          Text('الفوزان', style: TextStyle(color: HexColor('#00AEAC'), fontSize: 12.0),),
        ],), SizedBox(height: 3.0,),
        Row(children: [
          Text('تاريخ الانشاء', style: TextStyle(color: Colors.black, fontSize: 12.0),),Spacer(),
          Text('${rate['created_at']}', style: TextStyle(color: HexColor('#00AEAC'), fontSize: 12.0),),
        ],), SizedBox(height: 3.0,),
        Row(children: [
          Text('سعر الشراء', style: TextStyle(color: Colors.black, fontSize: 12.0),),Spacer(),
          Text(' ريال ${rate['buyPrice']}', style: TextStyle(color: HexColor('#00AEAC'), fontSize: 12.0),),
        ],), SizedBox(height: 3.0,),
        Row(children: [
          Text('سعر البيع', style: TextStyle(color: Colors.black, fontSize: 12.0),),Spacer(),
          Text(' ريال ${rate['sellPrice']}', style: TextStyle(color: HexColor('#00AEAC'), fontSize: 12.0),),
        ],), SizedBox(height: 3.0,),
        Row(children: [
          Text('سعر وقوف الخساره', style: TextStyle(color: Colors.black, fontSize: 12.0),),Spacer(),
          Text('${rate['stopLoss']}', style: TextStyle(color: HexColor('#00AEAC'), fontSize: 12.0),),
        ],), SizedBox(height: 3.0,),
        Row(children: [
          Text('عدد الجلسات', style: TextStyle(color: Colors.black, fontSize: 12.0),),Spacer(),
          Text('${rate['display']}', style: TextStyle(color: HexColor('#00AEAC'), fontSize: 12.0),),
        ],), SizedBox(height: 3.0,),
        Row(children: [
          Text('الحالة', style: TextStyle(color: Colors.black, fontSize: 12.0),),Spacer(),
          Text('جديده', style: TextStyle(color: HexColor('#00AEAC'), fontSize: 12.0),),
        ],), SizedBox(height: 5.0,),
      ],
    ),
  );
}