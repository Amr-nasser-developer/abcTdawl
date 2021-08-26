import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:abc_trade/modules/cubit/cubit.dart';
import 'package:abc_trade/modules/cubit/state.dart';
import 'package:abc_trade/shared/components.dart';

class ServiceScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TradeCubit, TradeStates>(
      listener: (context, state){},
      builder: (context, state){
        var width = MediaQuery.of(context).size.width;
       var service = TradeCubit.get(context);
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            drawer: defaultDrawer(context: context),
            key: _scaffoldKey,
            appBar: defaultHomeAppBar(
                text: 'خدامتنا',
                context: context,
                scaffoldKey: _scaffoldKey
            ),
            body: ConditionalBuilder(
                condition: state is! TradeServiceError,
                builder: (context)=> ConditionalBuilder(
                    condition: state is! TradeServiceLoading,
                    builder: (context)=> SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: ListView.separated(
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index)=> defaultBuildService(
                                'assets/images/service.png',
                                service.service[index],
                              width
                            ),
                            separatorBuilder:(context, index)=> Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Divider(color: Colors.grey[400],),
                            ),
                            itemCount: service.service.length
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
  Widget defaultBuildService(sourceImage,service,width) => Container(
    width: width * 0.5,
    decoration: BoxDecoration(boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 5,
        blurRadius: 7,
        offset: Offset(0, 3), // changes position of shadow
      ),
    ], color: Colors.white, borderRadius: BorderRadius.circular(15.0)),
    alignment: Alignment.center,
    padding: EdgeInsets.all(5.0),
    child: Column(
      children: [
        Image.asset(
          sourceImage,
          height: 100.0,
          width: 100.0,
        ),
        SizedBox(
          height: 5.0,
        ),
        Text(
          '${service['service']}',
          style: TextStyle(fontSize: 12, color: HexColor('#515151')),
        ),
        SizedBox(
          height: 5.0,
        ),
        Text(
          '${service['description']}',
          style: TextStyle(fontSize: 10, color: HexColor('#C6C6C6'),),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 5.0,)
      ],
    ),
  );

}
