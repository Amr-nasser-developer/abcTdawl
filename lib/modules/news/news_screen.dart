import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:abc_trade/modules/cubit/cubit.dart';
import 'package:abc_trade/modules/cubit/state.dart';
import 'package:abc_trade/modules/news/news_detailes.dart';
import 'package:abc_trade/shared/components.dart';

class NewsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return BlocConsumer<TradeCubit, TradeStates>(
        listener: (context, state){},
      builder: (context, state){
         var news = TradeCubit.get(context);
          return Scaffold(
              backgroundColor: Colors.white,
              body: ConditionalBuilder(
                condition: state is! TradeNewsError,
                builder: (context)=> ConditionalBuilder(
                    condition: state is! TradeNewsLoading,
                    builder: (context)=> SingleChildScrollView(
                      child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              ListView.separated(
                                  shrinkWrap: true,
                                  physics: BouncingScrollPhysics(),
                                  itemBuilder: (context, index)=> defaultNewsContainer(
                                    height,
                                    width,
                                    context,
                                    news.news[index]
                                  ),
                                  separatorBuilder:(context, index)=> Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                    child: Divider(color: HexColor('#00AEAC'),),
                                  ),
                                  itemCount: news.news.length
                              ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Stack(
                            alignment: Alignment.center,
                            children:
                            [
                              Container(),
                               if(state is! TradeNewsMoreLoading && news.currentPageNews <= news.totalPageNews)
                                 defaultMaterialButtonBag(
                                   function: ()
                                   {
                                     if(news.currentPageNews <= news.totalPageNews)
                                       news.getNewsMore();
                                   },
                                 ),
                              if(state is TradeNewsMoreLoading)
                                CircularProgressIndicator(),
                            ],
                          ),
                            ],
                          )
                      ),
                    ),
                  fallback: (context)=> Center(child: CircularProgressIndicator(),),
                ),
                fallback: (context)=> Center(child: Text('!!! Check Your Internet'),),
              )
          );
      },
    );
  }
  Widget defaultNewsContainer(height, width, context, news) => InkWell(
    onTap: (){
      TradeCubit.get(context).getNewsDetails(id:news['id']);
      print(news['id']);
        defaultNavigateTo(context: context, widget: NewsDetailes());
    },
    child: Container(
      width: width * 0.95,
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
          color: Colors.black38, spreadRadius: 0, blurRadius: 0,)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 4,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12, spreadRadius: 0, blurRadius: 0),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child:  Container(
                 height: 120,
                  width: width * 0.9,
                  child:
                  (news['image'] == 0 )?
                  Container() :
                  Image.network('http://abctdawl.com/storage/app/public/reports-imgs/${news['image']}', fit: BoxFit.fill,)
              ),
            ),
          ),

          SizedBox(
            height: 5.0,
          ),
          Text(
            '${news['description']}...',
            style: TextStyle(fontSize: 10.0, color: HexColor('#040404')),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.right,
          ),
          SizedBox(
            height: 10.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${news['created_at']}',
                style: TextStyle(fontSize: 10.0, color: HexColor('#00AEAC')),
                textDirection: TextDirection.rtl,
              ),
            ],
          ),
          SizedBox(
            height: 4,
          ),

        ],
      ),
    ),
  );

}