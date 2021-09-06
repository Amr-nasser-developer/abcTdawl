import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:abc_trade/modules/cubit/cubit.dart';
import 'package:abc_trade/modules/cubit/state.dart';
import 'package:abc_trade/modules/recommand/recommendations.dart';
import 'package:abc_trade/shared/components.dart';
import 'package:abc_trade/shared/local/shared.dart';

class RecommandScreen extends StatelessWidget {
  var id = CashHelper.getData(key: 'userId');
  var token = CashHelper.getData(key: 'loginToken');
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TradeCubit, TradeStates>(
      listener: (context, state){},
      builder: (context, state){
        print('userId => $id');
       var recommand = TradeCubit.get(context);
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            appBar: defaultHomeAppBar(
              token: token,
                context: context,
                scaffoldKey: _scaffoldKey,
                text: 'التوصيات'
            ),
            key:_scaffoldKey ,
            drawer: defaultDrawer(context: context),
            body: ConditionalBuilder(
                condition: state is! TradeRecommandError,
                builder: (context)=> ConditionalBuilder(
                    condition: state is! TradeRecommandTypeLoading,
                    builder: (context)=> SingleChildScrollView(
                      child: Padding(
                          padding: EdgeInsets.all(10),
                        child: ListView.separated(
                          shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index)=>defaultBuildRecommand(
                              context: context,
                              recommand: recommand.recommendationsType[index],
                              sourceImage: 'assets/images/reco.png'
                            ),
                            separatorBuilder: (context, index)=> Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Divider(color: HexColor('#00AEAC'),),
                            ),
                            itemCount: recommand.recommendationsType.length
                        ),
                      ),
                    ),
                  fallback: (context)=> Center(child: CircularProgressIndicator(),),
                ),
              fallback: (context)=> Center(child: Text('!!! Check Your Internet'),),
            ),
          ),
        );
      },
    );
  }
  Widget defaultBuildRecommand({sourceImage, context, recommand}) => Container(
    alignment: Alignment.center,
    padding: EdgeInsets.symmetric(horizontal: 10.0),
    height: 150.0,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0), color: Colors.black87),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image.asset(
          sourceImage,
          width: 100,
          height: 100,
        ),
        SizedBox(
          width: 30.0,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '${recommand['title']}',
                maxLines: 4,
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(
                height: 40,
              ),
              defaultMaterialButton(
                  text: 'استعراض',
                  function: () {
                    TradeCubit.get(context).getRecommendation(
                      createRecommendationSuccess: true,
                      type: '${recommand['id']}',
                    );
                    defaultNavigateTo(
                        context: context, widget: RecommendationsScreen(typeId: '${recommand['id']}',typeName: '${recommand['title']}',));
                  })
            ],
          ),
        ),
      ],
    ),
  );
}
