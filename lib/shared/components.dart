import 'package:abc_trade/modules/user/user_Screen.dart';
import 'package:abc_trade/shared/local/shared.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:abc_trade/layout/home_screen.dart';
import 'package:abc_trade/modules/contact_us/contact_us.dart';
import 'package:abc_trade/modules/cubit/cubit.dart';
import 'package:abc_trade/modules/main/main_screen.dart';
import 'package:abc_trade/modules/news/news_screen.dart';
import 'package:abc_trade/modules/notification/notification_screen.dart';
import 'package:abc_trade/modules/package/package_screen.dart';
import 'package:abc_trade/modules/performance/performance_screen.dart';
import 'package:abc_trade/modules/service/service_screen.dart';
import 'package:url_launcher/url_launcher.dart';

var token = CashHelper.getData(key: 'loginToken');
void defaultNavigateTo({context, widget}) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

void defaultFinishNavigate({context, widget}) {
  Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => widget), (route) => false);
}

var _url = 'https://abctdawl.com/create-account';
void _launchURL() async =>
    await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';

Widget defaultMainContainer({String? text, function, image}) => GestureDetector(
      onTap: function,
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
            border: Border.all(color: HexColor('#03D6D1')),
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage(image),
              height: 40.0,
              width: 70.0,
            ),
            Text(
              text!,
              style: TextStyle(
                fontSize: 10.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );

Widget defaultFormText(
        {text,
        hint,
        controller,
        type,
        bool obscure = false,
        icon,
        align,
        context,
          validator,
          bool login = false,
          String className = '',
        functionIcon
        }) =>
    Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 0),
          ],
          borderRadius: (login == false)?BorderRadius.all(Radius.circular(25)):BorderRadius.all(Radius.circular(3.0)),
          color: Colors.white,
        ),
        padding: EdgeInsetsDirectional.only(
          end: 10,
          start: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              maxLines: (className == 'contactUS') ? 4 : 1,
              autofocus: true,
              controller: controller,
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.right,
              keyboardType: type,
              validator: validator,
              decoration: InputDecoration(
                  hintText: hint,
                  border: InputBorder.none,
                  prefixIcon: IconButton(
                    onPressed: functionIcon,
                    icon: Icon(icon),
                  )),
              obscureText: obscure,
            )
          ],
        ),
      ),
    );
Widget defaultMobileSaudiTextForm({bool login = false, controller , validate})=>    Container(
  alignment: Alignment.center,
  width: double.infinity,
  decoration: BoxDecoration(
    boxShadow: [
      BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 0),
    ],
    borderRadius: (login == false)? BorderRadius.all(Radius.circular(25.0)) : BorderRadius.all(Radius.circular(3.0)),
    color: Colors.white,
  ),
  padding: EdgeInsetsDirectional.only(
    end: 10,
    start: 10,
  ),
  child: Row(
    children: [
      Container(
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('icons/flags/png/sa.png', package: 'country_icons', ),
              radius: 20,
            ),
            SizedBox(width: 3.0,),
            Text('966/', style: TextStyle(color: Colors.black, fontSize: 18.0,fontWeight: FontWeight.bold),)
          ],
        ),
      ),
      SizedBox(width: 5.0,),
      Container(
        child: Expanded(
          child: TextFormField(
            validator: (v){
              if(v!.isEmpty){
                return 'الحقل رقم الهاتف مطلوب';
              }
            },
            autofocus: true,
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.right,
            keyboardType: TextInputType.phone,
            controller: controller,
            decoration: InputDecoration(
              hintText: 'رقم الموبيل السعودى',
              border: InputBorder.none,
            ),
          ),
        ),
      )
    ],
  ),
);
// Widget defaultMobileTextForm({control,bool login = false,code}) => Container(
//       width: double.infinity,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 0),
//         ],
//         borderRadius: (login == false)? BorderRadius.all(Radius.circular(25.0)) :BorderRadius.all(Radius.circular(0)) ,
//       ),
//       padding: EdgeInsetsDirectional.only(
//         top: 10,
//         end: 10,
//         start: 10,
//       ),
//       child: IntlPhoneField(
//         controller: control,
//
//         decoration: InputDecoration(
//           labelText: 'Phone Number',
//           border: OutlineInputBorder(
//             borderSide: BorderSide(),
//           ),
//         ),
//         initialCountryCode: 'EG',
//         onChanged: (phone) {
//           print(phone.countryCode);
//           code = phone.countryCode;
//         },
//       ),
//     );

Widget defaultMaterialButtonBag({function})=>   Container(
  height: 35.0,
  width: 140.0,
  decoration: BoxDecoration(borderRadius: BorderRadius.circular(50.0)),
  child: MaterialButton(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(25.0),
    ),
    color: HexColor('#00AEAC'),
    height: 26.0,
    minWidth: 87.0,
    textColor: HexColor('#FFFFFF'),
    onPressed: function,
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Load More',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        SizedBox(
          width: 10.0,
        ),
        Icon(
          Icons.arrow_downward,
          size: 16.0,
          color: Colors.black,
        ),
      ],
    ),
  ),
);

Widget defaultBuildDataDetails({width, context})=> Container(
  width: width * 0.9,
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'نتائج جميع التوصيات',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: HexColor('#00AEAC')),
            ),
          ]
      ),
      SizedBox(
        height: 10.0,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment:
            MainAxisAlignment.start,
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Text(
                'إجمالي عدد التوصيات',
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 3.0,
              ),
              Text(
                'عدد التوصيات المحققة',
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 3.0,
              ),
              Text(
                'عدد التوصيات ايقاف الخسارة',
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 3.0,
              ),
              Text(
                'متوسط ربح التوصية الواحدة',
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 3.0,
              ),
              Text(
                'عدد التوصيات المفتوحة',
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(
            width: width * 0.2,
          ),
          Column(
            mainAxisAlignment:
            MainAxisAlignment.start,
            crossAxisAlignment:
            CrossAxisAlignment.center,
            children: [
              Text(
                '${TradeCubit.get(context).rate!.data!.recommendations_all}',
                style: TextStyle(
                    fontSize: 10,
                    color: HexColor('#00AEAC'),
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 7.0,
              ),
              Text(
                '${TradeCubit.get(context).rate!.data!.recommendations_win}',
                style: TextStyle(
                    fontSize: 10,
                    color: HexColor('#00AEAC'),
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 7.0,
              ),
              Text(
                '${TradeCubit.get(context).rate!.data!.recommendations_lose}',
                style: TextStyle(
                    fontSize: 10,
                    color: HexColor('#00AEAC'),
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 7.0,
              ),
              Text(
                '${TradeCubit.get(context).rate!.data!.average_profit}%',
                style: TextStyle(
                    fontSize: 10,
                    color: HexColor('#00AEAC'),
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 7.0,
              ),
              Text(
                '${TradeCubit.get(context).rate!.data!.recommendations_open}',
                style: TextStyle(
                    fontSize: 10,
                    color: HexColor('#00AEAC'),
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(
            width: width * 0.15,
          ),
          Column(
            mainAxisAlignment:
            MainAxisAlignment.end,
            crossAxisAlignment:
            CrossAxisAlignment.end,
            children: [
              Container(
                width : 60,
                child: ListView.separated(
                  itemBuilder: (context, index)=> Text(
                    'توصية',
                    style: TextStyle(
                        fontSize: 10,
                        color: HexColor('#F5085C'),
                        fontWeight: FontWeight.bold),
                  ) ,
                  separatorBuilder: (context, index)=>  SizedBox(
                    height: 3.0,
                  ) ,
                  itemCount: 5,
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                ),
              ),
            ],
          ),
        ],
      )
    ],
  ),
);

Widget defaultMaterialButton({function, text, bool login = false }) => Container(
      height: 35.0,
      width: 140.0,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(50.0)),
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: (login)? BorderRadius.circular(25.0) : BorderRadius.circular(5.0),
        ),
        onPressed: function,
        color: HexColor('#00AEAC'),
        height: 26.0,
        minWidth: 87.0,
        textColor: HexColor('#FFFFFF'),
        child: Text(
          text,
          style: TextStyle(
            color: HexColor('#FFFFFF'),
            fontSize: 13.0,
          ),
        ),
      ),
    );
defaultHomeAppBar({text, scaffoldKey, context}) => AppBar(
      leading: IconButton(
          onPressed: () {
            scaffoldKey.currentState.openDrawer();
          },
          icon: Image.asset('assets/images/menu.png')),
      title: Text(text),
      actions: [
         IconButton(
            onPressed: () {
              defaultNavigateTo(context: context, widget: (token != null)? NotificationScreen() : HomeScreen(widget: UserScreen(),));
            },
            icon: Image.asset('assets/images/noti.png'))
      ],
      centerTitle: true,
      backgroundColor: HexColor('#00AEAC'),
      toolbarHeight: 50,
    );

Widget defaultDrawerWidget({text, icon, function}) => GestureDetector(
      onTap: function,
      child: Row(
        children: [
          Icon(
            icon,
            color: HexColor('#00AEAC'),
          ),
          SizedBox(
            width: 10.0,
          ),
          Text(
            text,
            style: TextStyle(fontSize: 14),
          )
        ],
      ),
    );

defaultDrawer({context}) => Builder(
      builder: (context) => Drawer(
        child: Padding(
          padding: const EdgeInsets.only(top: 50, right: 10, left: 10),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              children: [
                Image.asset('assets/images/package_logo.png'),
                SizedBox(
                  height: 50.0,
                ),
                defaultDrawerWidget(
                    text: 'الرئيسية',
                    icon: Icons.home,
                    function: () {
                      Navigator.pop(context);
                      defaultFinishNavigate(
                          context: context,
                          widget: HomeScreen(
                            widget: MainScreen(),
                          ));
                    }),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    defaultFinishNavigate(
                        context: context,
                        widget: HomeScreen(
                          widget: NewsScreen(),
                        ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/last_news.png',
                          color: HexColor('#00AEAC'),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          'اخر الاخبار',
                          style: TextStyle(fontSize: 14),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                defaultDrawerWidget(
                    text: 'باقات الاشتراك',
                    icon: Icons.wysiwyg_sharp,
                    function: () {
                      Navigator.pop(context);
                      defaultFinishNavigate(
                          context: context,
                          widget: HomeScreen(
                            widget: PackageScreen(),
                          ));
                    }),
                SizedBox(
                  height: 20,
                ),
                defaultDrawerWidget(
                    text: 'معدل الاداء',
                    icon:
                        Icons.signal_cellular_connected_no_internet_4_bar_sharp,
                    function: () {
                      Navigator.pop(context);
                      defaultNavigateTo(context: context, widget: PerformanceRateScreen());
                    }),
                SizedBox(
                  height: 20,
                ),
                defaultDrawerWidget(
                    text: 'خدماتنا',
                    icon: Icons.design_services,
                    function: () {
                      Navigator.pop(context);
                      defaultNavigateTo(context: context, widget: ServiceScreen());}),
                SizedBox(
                  height: 20,
                ),
                defaultDrawerWidget(
                    text: 'الاخبار',
                    icon: Icons.article_outlined,
                    function: () {
                      Navigator.pop(context);
                      defaultFinishNavigate(
                          context: context,
                          widget: HomeScreen(
                            widget: NewsScreen(),
                          ));
                    }),
                SizedBox(
                  height: 20,
                ),
                defaultDrawerWidget(
                    text: 'تواصل معانا',
                    icon: Icons.phone,
                    function: () {
                      Navigator.pop(context);
                      defaultNavigateTo(context: context, widget: ContactUsScreen());
                    //  launch("tel://01008503574");
                    }),
              ],
            ),
          ),
        ),
      ),
    );

Widget defaultDropButton({hint, key, listItem, function, value}) => Directionality(
  textDirection: TextDirection.rtl,
  child:   Container(
        alignment: AlignmentDirectional.center,
        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 3),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 0),
          ],
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
        child: DropdownButton(
          hint: Text(hint),
          menuMaxHeight: 140.0,
          key: key,
          isExpanded: true,
          items: listItem,
          onChanged: function,
          value: value,
        ),
      ),
);
