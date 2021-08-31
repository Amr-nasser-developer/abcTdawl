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
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/graph.png')
                    ],
                  ),
                ),
                SizedBox(height: 30.0,),
                meza(
                  name: 'الخبره',
                  text: 'نمتلك فريق عمل متميز ذو خبره كبيره فى المجال بشهادة المحللين و العملاء و بنتائجهم المتميزه'
                ),
                  SizedBox(height: 5,),
                meza(
                  name: 'المصداقيه',
                  text: 'تم تأسيس الشركه لهدف أساسى من المصداقيه التامه مع العملاء بما يحقق النجاح المشترك'
                ),
                SizedBox(height: 5,),
                meza(
                  name: 'القياده',
                  text: 'مؤسسى الشركه و فريق االعمل حاصلون على أعلى الشهادات بالإضافه الى الخبره و سابقة الاعمال'
                ),
                SizedBox(height: 5,),
                meza(
                  name: 'المساءلة',
                  text: 'نتحمــل المسؤولية عــن أدائنا أمام الجميــع، ونحــن علــى اســتعداد لمواجهــة المســاءلة عــن كافة تصرفاتنا.'
                ),
                SizedBox(height: 5,),
                meza(
                  name: 'التواصل والإيجابية مع العميل',
                  text: 'نركـــز دومـا علـى تحقيـــق الأهـداف، ونسـعى لإحــداث فـرق لــدى العمــلاء، ونجتهـد لتحقيـق اعلى النتائج مــن خــلال عملنـــا لتحقيـــق تأثير مســـتدام علــى مســـتوى الجهـــات ذات العلاقـــة، فيمـــا نمـــارس التزامنــا الجـــاد بمبـــادرات الاســتدامة المؤسسية والمسؤولية المجتمعيــــة.'
                ),
                SizedBox(height: 10,),
              ],
            ),
          ),
        )
      ),
    );
  }
  Widget meza({name, text})=>Container(
    width: 400,
    child: Padding(
      padding: EdgeInsets.all(10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
            Column(
              children: [
                Text(name, style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),),
                Container(
                  width: 200,
                    child: Text( text,textAlign: TextAlign.center,)),

              ],
            )
        ],
      ),
    ),
  );
}
