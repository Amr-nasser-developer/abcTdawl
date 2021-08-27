import 'package:abc_trade/shared/local/shared.dart';
import 'package:flutter/material.dart';
import 'package:abc_trade/shared/components.dart';

class DiscriminationScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var token = CashHelper.getData(key: 'loginToken');
  @override
  Widget build(BuildContext context) {
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
          text: 'ما يميزنا',
          scaffoldKey: _scaffoldKey
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 30.0),
          child: Column(
            children: [
              Container(
                height: 200,
                width: 300,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  borderRadius: BorderRadius.circular(25.0),
                  color: Colors.black
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/graph.png')
                  ],
                ),
              ),
              SizedBox(height: 30.0,),
              RowMeza(),
              SizedBox(height: 5.0,),
              RowMeza(),
              SizedBox(height: 5.0,),
              RowMeza(),
              SizedBox(height: 5.0,),
              RowMeza(),
              SizedBox(height: 5.0,),
              RowMeza(),
              SizedBox(height: 5.0,),
            ],
          ),
        ),
      ),
    );
  }
  Widget RowMeza()=>Padding(
    padding: const EdgeInsets.only(left: 40),
    child: Row(
      children: [
        Text('ميزه 1', style: TextStyle(fontWeight: FontWeight.bold),),
        Spacer(),
        Text('ميزه 2', style: TextStyle(fontWeight: FontWeight.bold)),
        Spacer(),
        Text('ميزه 3', style: TextStyle(fontWeight: FontWeight.bold)),
        Spacer(),
        Text('ميزه 4', style: TextStyle(fontWeight: FontWeight.bold)),
        Spacer(),
      ],
    ),
  );
}
