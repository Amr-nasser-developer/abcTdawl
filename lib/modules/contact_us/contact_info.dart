import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:abc_trade/modules/cubit/cubit.dart';
import 'package:abc_trade/modules/cubit/state.dart';
import 'package:abc_trade/shared/components.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactInfoScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
    return BlocConsumer<TradeCubit, TradeStates>(
        listener: (context, state){},
      builder: (context, state){
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
                            itemBuilder: (context, index)=> defaultContactInfo(
                              width,
                              contactInfo.contactInfo[index]
                            ),
                            separatorBuilder: (context, index)=> Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Divider(color: Colors.grey[400],),
                            ),
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
  Widget defaultContactInfo(width, contactInfo)=>Container(
    padding: EdgeInsetsDirectional.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black38, spreadRadius: 0, blurRadius: 0,)
      ],
    ),
    width: width * 0.9 ,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('رقم الموبيل : '),Spacer(),
            TextButton(
              onPressed: (){
                launch("tel:${contactInfo['phone']}");
              },
                child: Text('${contactInfo['phone']}')),
          ],
        ),
        SizedBox(height: 30.0,),
        Row(
          children: [
            Text('العنوان : '), Spacer(),
            Text('${contactInfo['address']} '),
          ],
        ),
        SizedBox(height: 40.0,),
        Row(
          children: [
            Text('مواعيد العمل : '),Spacer(),
            Text('${contactInfo['work_time']}'),
          ],
        ),
        SizedBox(height: 40.0,),
        Row(
          children: [
            Text('البريد الالكترونى : '),Spacer(),
            TextButton(child: SelectableText('${contactInfo['email']}'),
            onPressed: (){
              _launchEmail('${contactInfo['email']}');
            },
            ),
          ],
        ),
        SizedBox(height: 20.0,),
        Row(
          children: [
            Text('الفيسبوك : '),Spacer(),
            TextButton(
                onPressed: (){
                  _launchURL('${contactInfo['facebook']}');
                },
                child:Text('${contactInfo['facebook']}')
            )
          ],
        ),
        SizedBox(height: 10.0,),
        Row(
          children: [
            Text('الانسنجرام : '),Spacer(),
            TextButton(
                onPressed: (){
                  _launchURL('${contactInfo['instagram']}');
                },
                child:Text('${contactInfo['instagram']}')
            )
          ],
        ),
        SizedBox(height: 10.0,),
        Row(
          children: [
            Text('تويتر : '),Spacer(),
            TextButton(
                onPressed: (){
                  _launchURL('${contactInfo['twiiter']}');
                },
                child:Text('${contactInfo['twiiter']}')
            )
          ],
        ),
        SizedBox(height: 10.0,),
        Row(
          children: [
            Text('يوتيوب : '),Spacer(),
            TextButton(
              onPressed: (){
                _launchURL('${contactInfo['youtube']}');
            },
              child:  Text('${contactInfo['youtube']}'),)
          ],
        ),
      ],
    ),
  );
  void _launchEmail(url)async {
    final uri = 'mailto:$url?subject=Greetings&body=Hello%20World';
    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }
  void _launchURL(url) async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';

}
