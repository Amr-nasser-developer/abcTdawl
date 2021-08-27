import 'package:abc_trade/shared/local/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:abc_trade/modules/contact_us/contact_info.dart';
import 'package:abc_trade/modules/cubit/cubit.dart';
import 'package:abc_trade/modules/cubit/state.dart';
import 'package:abc_trade/shared/components.dart';

class ContactUsScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var messageController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _globalKey = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TradeCubit, TradeStates>(
        listener: (context, state){},
      builder: (context, state){
        var token = CashHelper.getData(key: 'loginToken');
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              key: _scaffoldKey,
              appBar: defaultHomeAppBar(
                token: token,
                context: context,
                text: 'تواصل معنا',
                scaffoldKey: _scaffoldKey
              ),
              drawer: defaultDrawer(
                context: context,
              ),
              body: SingleChildScrollView(
                child: Form(
                  key: _globalKey,
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          defaultFormText(
                            hint: 'الاسم',
                            context: context,
                            icon: Icons.person,
                            login: true,
                            type: TextInputType.name,
                            controller: nameController,
                            validator: (value){
                              if(value!.isEmpty){
                                return'برجاء ادخال الاسم';
                              }else{
                                return null;
                              }
                            }
                          ),
                          SizedBox(height: 10.0,),
                          defaultFormText(
                            hint: 'البريد الالكترونى',
                            icon: Icons.email,
                            context: context,
                            login: true,
                            type: TextInputType.emailAddress,
                            controller: emailController,
                              validator: (value){
                                if(value!.isEmpty){
                                  return'برجاء ادخال البريد الالكترونى';
                                }else{
                                  return null;
                                }
                              }
                          ),
                          SizedBox(height: 10.0,),
                          defaultFormText(
                            hint: 'رقم الموبيل',
                            context: context,
                            login: true,
                            icon: Icons.phone,
                            controller: phoneController,
                            type: TextInputType.visiblePassword,
                              validator: (value){
                                if(value!.isEmpty){
                                  return'برجاء ادخال رقم الموبيل';
                                }else{
                                  return null;
                                }
                              }
                          ),
                      SizedBox(height: 10,),
                          defaultFormText(
                              hint: 'الرسالة',
                              context: context,
                              login: true,
                              controller: messageController,
                              type: TextInputType.text,
                              icon: Icons.message,
                              className: 'contactUS',
                              validator: (value){
                                if(value!.isEmpty){
                                  return'برجاء ادخال رسالتك';
                                }else{
                                  return null;
                                }
                              }
                          ),
                          SizedBox(height: 20.0,),
                          defaultMaterialButton(
                            login: true,
                            text: 'ارسال',
                            function: (){
                              if(_globalKey.currentState!.validate()){
                                TradeCubit.get(context).postContactUs(
                                  email: emailController.text,
                                  name: nameController.text,
                                  phone: phoneController.text,
                                );
                              }
                            }
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
              floatingActionButton: FloatingActionButton(
                onPressed: (){
                  defaultNavigateTo(context: context, widget: ContactInfoScreen());
                },
                child: Icon(Icons.support_agent_sharp),
                heroTag: 'من نحن',
                tooltip: 'من نحن',
                backgroundColor: HexColor('#00AEAC'),
              ),
            ),
          );
      },
    );
  }
}
