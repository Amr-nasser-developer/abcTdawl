import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:abc_trade/modules/cubit/cubit.dart';
import 'package:abc_trade/modules/cubit/state.dart';
import 'package:url_launcher/url_launcher.dart';

class PackageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return BlocConsumer<TradeCubit, TradeStates>(
        listener: (context, state){},
      builder: (context, state){
        var pack = TradeCubit.get(context);
          return Scaffold(
            backgroundColor: HexColor('#EFEFEF'),
            body : ConditionalBuilder(
              condition: state is! TradePackageError,
              builder: (context)=> ConditionalBuilder(
                  condition: state is! TradePackageLoading,
                  builder: (context)=> SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context , index)=> defaultPackageContainer(
                            pack.packages[index],
                            width
                        ),
                        separatorBuilder: (context, index)=> Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Divider(color: Colors.grey[400],),
                        ),
                        itemCount: pack.packages.length,

                      ),
                    ),
                  ),
                fallback: (context)=> Center(child: CircularProgressIndicator(),),
              ),
              fallback: (context)=> Center(
                child: Text('!!! Check Your Internet'),
              )
            ),
          );
      },
    );
  }
  Widget defaultPackageContainer(package,width) => Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        alignment: Alignment.center,
        width: width * 0.95,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          textDirection: TextDirection.rtl,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 3,
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
                    height: 100,
                    width: 100,
                    child:
                    (package['image'] == 0 )?
                    Container() :
                    Image.network('http://abctdawl.com/storage/app/public/reports-imgs/${package['image']}', fit: BoxFit.fill,)
                ),
              ),
            ),
            SizedBox(
              width: 15.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${package['name']}',
                    style: TextStyle(
                        fontSize: 16.0,
                        color: HexColor('#00AEAC'),
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.right,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    '${package['description']}',
                    style: TextStyle(
                        fontSize: 12.0,
                        color: HexColor('#060606'),
                        fontWeight: FontWeight.bold),
                    textDirection: TextDirection.rtl,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    textDirection: TextDirection.ltr,
                    children: [
                      MaterialButton(
                        onPressed: () {
                          _launchURL();
                        },
                        color: HexColor('#00AEAC'),
                        height: 26.0,
                        minWidth: 87.0,
                        child: Text(
                          'اشتراك',
                          style: TextStyle(
                            color: HexColor('#FFFFFF'),
                            fontSize: 13.0,
                          ),
                        ),
                      ),
                      Spacer(),
                      Text(
                        'ريال سعودي',
                        style:
                        TextStyle(fontSize: 10.0, color: HexColor('#89878A')),
                        textAlign: TextAlign.left,
                      ),
                      Spacer(),
                      Text(
                        '${package['price']}'.toString(),
                        style:
                        TextStyle(fontSize: 10.0, color: HexColor('#89878A')),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(
                        height: 3,
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      );
  var _url = 'https://abctdawl.com/create-account';
  void _launchURL() async =>
      await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
}