import 'package:abc_trade/layout/home_screen.dart';
import 'package:abc_trade/modules/user/user_Screen.dart';
import 'package:abc_trade/shared/local/shared.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:abc_trade/modules/cubit/cubit.dart';
import 'package:abc_trade/modules/cubit/state.dart';
import 'package:abc_trade/modules/discrimination/discrimination_Screen.dart';
import 'package:abc_trade/modules/instant_recommendations/instant_recommendations_screen.dart';
import 'package:abc_trade/modules/freeSubscripe/freeSupscription_screen.dart';
import 'package:abc_trade/modules/performance/performance_screen.dart';
import 'package:abc_trade/modules/recommand/recommandScreen.dart';
import 'package:abc_trade/modules/service/service_screen.dart';
import 'package:abc_trade/shared/components.dart';

class MainScreen extends StatelessWidget {
  // List<dynamic> photo = [
  //   'assets/images/slider1.jpg',
  //   'assets/images/slider2.jpg',
  //   'assets/images/slider3.jpg',
  // ];
  var token = CashHelper.getData(key: 'loginToken');
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return BlocConsumer<TradeCubit, TradeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var data = TradeCubit.get(context);
        return Scaffold(
            backgroundColor: Colors.white,
            body: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: ExactAssetImage('assets/images/backGround.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                    padding: EdgeInsets.all(15.0),
                    color: Colors.white70,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        ConditionalBuilder(
                            condition: state is! TradeSliderLoading,
                            builder: (context)=> Container(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15.0),
                                child: CarouselSlider(
                                  items: TradeCubit.get(context).slider
                                      .map(
                                        (e) => Builder(builder: (context) {
                                      return Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(15.0),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: HexColor('#00AEAC'),
                                                  spreadRadius: 0,
                                                  blurRadius: 0),
                                            ],
                                          ),
                                          child: Image.network('http://abctdawl.com/storage/app/${e['image']}',fit: BoxFit.cover, width: double.infinity,)
                                      );
                                    }),
                                  )
                                      .toList(),
                                  options: CarouselOptions(
                                    // autoPlayCurve: Curves.easeInCirc,
                                    autoPlayInterval: Duration(seconds: 3),
                                    autoPlayAnimationDuration:
                                    Duration(milliseconds: 1200),
                                    reverse: false,
                                    viewportFraction: 1,
                                    aspectRatio: 2,
                                    enlargeCenterPage: true,
                                    scrollDirection: Axis.horizontal,
                                    autoPlay: true,
                                  ),
                                ),
                              ),
                            ),
                          fallback: (context)=> Center(child: CircularProgressIndicator(),),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! TradePerformanceShortError,
                          builder: (context) => ConditionalBuilder(
                            condition: data.rate != null,
                            builder: (context) => defaultBuildDataDetails(width: width, context: context),
                            fallback: (context) => Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          fallback: (context) =>
                              Center(child: Text('!!! Check Your Internet')),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            defaultMainContainer(
                                text: 'معدلات الاداء',
                                function: () {
                                  defaultNavigateTo(
                                      context: context,
                                      widget: PerformanceRateScreen());
                                },
                                image: 'assets/images/recommand.png'),
                            Spacer(),
                            defaultMainContainer(
                                text: 'التوصيات',
                                function: () {
                                  defaultNavigateTo(
                                      context: context,
                                      widget: RecommandScreen());
                                },
                                image: 'assets/images/stock-marker.png'),
                            Spacer(),
                            defaultMainContainer(
                                text: 'خدماتنا',
                                function: () {
                                  defaultNavigateTo(
                                      context: context,
                                      widget: ServiceScreen());
                                },
                                image: 'assets/images/trader.png'),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            defaultMainContainer(
                                text: 'إشتراك مجانى',
                                function: () {
                                  defaultNavigateTo(
                                      context: context,
                                      widget: FreeSubscription());
                                },
                                image: 'assets/images/free.png'),
                            Spacer(),
                            defaultMainContainer(
                                text: 'ما يميزنا',
                                function: () {
                                  defaultNavigateTo(
                                      context: context,
                                      widget: DiscriminationScreen());
                                },
                                image: 'assets/images/star.png'),
                            Spacer(),
                                defaultMainContainer(
                                    text: 'توصيات لحظيه',
                                    function: () {
                                      defaultNavigateTo(
                                          context: context,
                                          widget:  (token != null) ? InstantRecommendations() : HomeScreen(widget: UserScreen(),));
                                    },
                                    image: 'assets/images/recommand_now.png'),
                          ],
                        ),
                      ],
                    )),
              ],
            ));
      },
    );
  }
}
