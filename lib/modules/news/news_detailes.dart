import 'package:abc_trade/shared/local/shared.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:abc_trade/modules/cubit/cubit.dart';
import 'package:abc_trade/modules/cubit/state.dart';
import 'package:abc_trade/shared/components.dart';

class NewsDetailes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TradeCubit, TradeStates>(
         listener: (context, state){},
         builder: (context, state){
        var width = MediaQuery.of(context).size.width;
        final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
        var newsDetail = TradeCubit.get(context);
        var token = CashHelper.getData(key: 'loginToken');
           return Directionality(
             textDirection: TextDirection.rtl,
             child: Scaffold(
                 key: _scaffoldKey,
                 drawer: defaultDrawer(),
                 appBar: defaultHomeAppBar(
                   token: token,
                     context: context,
                     text: 'تفاصيل الخبر',
                     scaffoldKey: _scaffoldKey
                 ),
                 body: ConditionalBuilder(
             condition: state is! TradeNewsDetailsError,
             builder: (context)=> ConditionalBuilder(
               condition: state is! TradeNewsDetailsLoading,
               builder: (context)=> Padding(
                   padding: const EdgeInsets.all(10.0),
                   child: ListView.separated(
                       shrinkWrap: true,
                       physics: BouncingScrollPhysics(),
                       itemBuilder: (context, index)=> defaultNewsDetails(
                           width,
                           newsDetail.newsDetails[index]
                       ),
                       separatorBuilder:(context, index)=> Padding(
                         padding: const EdgeInsets.symmetric(horizontal: 20.0),
                         child: Divider(color: Colors.grey[400],),
                       ),
                       itemCount: newsDetail.newsDetails.length
                   )
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
  Widget defaultNewsDetails(width, newsDetail)=> Container(
    alignment: Alignment.center,
    child: Column(
      children: [
        Text('أبومعطي للمكتبات تُجدد اتفاقية تسهيلات مصرفية بقيمة 45 مليون ريال مع سامبا',
          style: TextStyle(fontSize: 10.0, color: HexColor('#00AEAC'),fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10.0,),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 0),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Container(
                height: 120,
                width: width * 0.9,
                child: ('${newsDetail['image']}' == 0 )?
                Container() :
                Image(image: NetworkImage('http://abctdawl.com/storage/app/public/reports-imgs/${newsDetail['image']}'),fit: BoxFit.fill,
                )
            ),
          ),
        ),
        SizedBox(height: 3.0,),
        Text('${newsDetail['created_at']}', style: TextStyle(fontSize: 14.0 , color: HexColor('#AE0029')),textAlign: TextAlign.start,),
        SizedBox(height: 10.0,),
        Text('${newsDetail['description']}',
          style: TextStyle(fontSize: 11.0, color: HexColor('#080909'),fontWeight: FontWeight.bold,),textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}
