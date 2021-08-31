import 'package:abc_trade/shared/local/shared.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:abc_trade/modules/cubit/cubit.dart';
import 'package:abc_trade/modules/cubit/state.dart';
import 'package:abc_trade/shared/components.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactInfoScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
    return BlocConsumer<TradeCubit, TradeStates>(
        listener: (context, state){},
      builder: (context, state){
        var token = CashHelper.getData(key: 'loginToken');
        var width = MediaQuery.of(context).size.width;
          var contactInfo = TradeCubit.get(context);
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              key: _scaffoldKey,
              drawer: defaultDrawer(
                context: context
              ),
              appBar: defaultHomeAppBar(
                token: token,
                context: context,
                text: 'من نحن',
                scaffoldKey: _scaffoldKey
              ),
              body: ConditionalBuilder(
                condition: state is! TradeContactInfoError,
                builder: (context)=> ConditionalBuilder(
                  condition: state is! TradeContactInfoLoading,
                  builder: (context)=>SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Center(
                        child: ListView.separated(
                          shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index)=> defsultBuildContactInfo(
                              width,
                              contactInfo.contactInfo[index]
                            ),
                            separatorBuilder: (context, index)=> Spacer(),
                            itemCount: contactInfo.contactInfo.length
                        ),
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

  Widget defsultBuildContactInfo(width,contactInfo)=> Column(
    children: [
      defaultContainerContactInfo(
        icon: Icons.phone,
        width: width,
        function: (){
          launch("tel:${contactInfo['phone']}");
        },
        text: '${contactInfo['phone']}'
      ),
      SizedBox(height: 40,),
      defaultContainerContactInfo(
          icon: Icons.location_on,
          width: width,
          text: '${contactInfo['address']}'
      ),
      SizedBox(height: 40,),
      defaultContainerContactInfo(
          icon: Icons.watch_later_outlined,
          width: width,
          text: '${contactInfo['work_time']}'
      ),
      SizedBox(height: 40,),
      defaultContainerContactInfo(
          icon: Icons.mail,
          width: width,
          function: (){
            _launchEmail('${contactInfo['email']}');
          },
          text: '${contactInfo['email']}'
      ),
    ],
  );
  Widget defaultContainerContactInfo({width, function, icon, text }) => GestureDetector(
    onTap: function,
    child: Container(
      height: 100,
      width: width * 0.8,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 7,
          offset: Offset(0, 3), // changes position of shadow
        ),
      ], color: HexColor('#00AEAC'), borderRadius: BorderRadius.circular(0.0)),
      padding: EdgeInsets.only(top: 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon,color: Colors.white,size: 32,),
          SizedBox(
            height: 5.0,
          ),
          Text(text, style: TextStyle(color: Colors.white),),
        ],
      ),
    ),
  );
  void _launchEmail(url)async {
    final uri = 'mailto:$url';
    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }
  void _launchURL(url) async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';

}
