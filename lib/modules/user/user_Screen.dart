import 'package:conditional_builder/conditional_builder.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:abc_trade/layout/home_screen.dart';
import 'package:abc_trade/modules/cubit/cubit.dart';
import 'package:abc_trade/modules/cubit/state.dart';
import 'package:abc_trade/modules/register/register_screen.dart';
import 'package:abc_trade/modules/user/profile.dart';
import 'package:abc_trade/shared/components.dart';
import 'package:abc_trade/shared/local/shared.dart';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  var token = CashHelper.getData(key: 'loginToken');
  final GlobalKey<FormState> _globalKey = new GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool val = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TradeCubit, TradeStates>(
        listener: (context, state){
          if(state is TradeLoginSuccess){
            if(TradeCubit.get(context).login!.status == false) {
              Fluttertoast.showToast(
                  msg: 'البريد الإلكترونى او الباسورد غير صحيحين',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 3,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }else {
              CashHelper.setData(key: 'loginToken', value: TradeCubit.get(context).login!.user!.token).then((value){
              CashHelper.setData(key: 'userId', value: TradeCubit.get(context).login!.user!.id);
                print('Login Token Saved Success');
                FirebaseMessaging.instance.subscribeToTopic('abc');
                defaultFinishNavigate(context: context,
                    widget: HomeScreen(widget: UserScreen(),));
              });
            }
            if(state is TradeLoginError){
              Fluttertoast.showToast(
                  msg: 'البريد الإلكترونى او الباسورد غير صحيحين',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 3,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
          }
        },
      builder: (context, state){
          return Scaffold(
            body: (token == null) ? SingleChildScrollView(
              child: Form(
                key: _globalKey,
                child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 15,),
                          Image.asset('assets/images/package_logo.png'),
                          SizedBox(height: 15,),
                          Text('تسيجيل الدخول', style: TextStyle(fontSize: 16, color: HexColor('#00AEAC')),),
                          SizedBox(height: 15,),
                          defaultFormText(
                            login: true,
                            hint: 'البريد الالكترونى',
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            icon: Icons.email,
                            context: context,
                            validator: (value){
                             if(value.isEmpty){
                               return 'برجاء ادحال البريد الالكترونى';
                             }
                            }
                          ),
                          SizedBox(height: 15,),
                          defaultFormText(
                              login: true,
                              hint: 'كلمه المرور',
                              controller: passwordController,
                              type: TextInputType.name,
                              obscure: true,
                              icon: Icons.lock_outline_sharp,
                              context: context,
                              validator: (value){
                                if(value.isEmpty){
                                  return 'برجاء ادحال الرقم السرى';
                                }
                              }
                          ),
                          SizedBox(height: 5.0,),
                          Row(
                            children: [
                              Checkbox(
                                value: val ,
                                onChanged: (value){
                                  setState(() {
                                    val = value!;
                                  });
                                },
                              ),
                              SizedBox(width: 3.0,),
                              Text('تذكرنى', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: HexColor('#00AEAC')),),
                            ],
                          ),
                          SizedBox(height: 15.0),
                          ConditionalBuilder(
                            condition: state is! TradeLoginLoading,
                            builder: (context)=> defaultMaterialButton(
                              login: true,
                              function: (){
                                if(_globalKey.currentState!.validate()){
                                  TradeCubit.get(context).loginUser(
                                      email: emailController.text ,
                                      password: passwordController.text
                                  );
                                }
                              },
                              text: 'دخول',
                            ),
                            fallback: (context)=> defaultMaterialButton(
                              login: true,
                              function: (){
                                if(_globalKey.currentState!.validate()){
                                  TradeCubit.get(context).loginUser(
                                      email: emailController.text ,
                                      password: passwordController.text
                                  );
                                }
                              },
                              text: 'دخول',
                            ),
                            ),
                          SizedBox(height: 20.0),
                          Container(
                            height: 35,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                border: Border.all(color: HexColor('#00AEAC'))
                            ),
                            child: MaterialButton(
                              onPressed: (){
                                CashHelper.deleteData(key: 'userIdFirebase');
                                defaultNavigateTo(context: context, widget: RegisterScreen());
                              },
                              height: 15.0,
                              minWidth: 87.0,
                              textColor: HexColor('#FFFFFF'),
                              child: Text(
                                'تسجيل حساب جديد',
                                style: TextStyle(
                                  color: HexColor('#00AEAC'),
                                  fontSize: 13.0,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                ),
              ),
            )
            : Profile()
            ,
          );
      },
    );
  }
}