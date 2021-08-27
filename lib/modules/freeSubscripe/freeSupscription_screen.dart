import 'package:abc_trade/shared/local/shared.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:abc_trade/modules/cubit/cubit.dart';
import 'package:abc_trade/modules/cubit/state.dart';
import 'package:abc_trade/modules/register/register_screen.dart';
import 'package:abc_trade/shared/components.dart';

class FreeSubscription extends StatefulWidget {
  @override
  _FreeSubscriptionState createState() => _FreeSubscriptionState();
}

class _FreeSubscriptionState extends State<FreeSubscription> {
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  bool val = false;
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
              drawer: defaultDrawer(context: context),
              appBar: defaultHomeAppBar(
                token: token,
                  context: context,
                  text: 'اشتراك مجانى',
                  scaffoldKey: _scaffoldKey
              ),
              body: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 15,),
                            Image.asset('assets/images/package_logo.png'),
                            SizedBox(height: 15,),
                            Text('إشتراك مجانى', style: TextStyle(fontSize: 16, color: HexColor('#00AEAC')),),
                            SizedBox(height: 15,),
                            defaultFormText(
                              login: true,
                              hint: 'الاسم',
                              controller: nameController,
                              type: TextInputType.emailAddress,
                              icon: Icons.person,
                              align: TextAlign.right,
                              validator: (v){
                                if(v.isEmpty){
                                  return 'برجاء ادخال الاسم';
                                }
                              }
                            ),
                            SizedBox(height: 15,),
                            defaultFormText(
                                login: true,
                                hint: 'البريد الالكترونى',
                                controller: emailController,
                                type: TextInputType.name,
                                icon: Icons.email,
                                align: TextAlign.right,
                                validator: (v){
                                  if(v.isEmpty){
                                    return 'برجاء ادخال البريد الالكترونى';
                                  }
                                }
                            ),
                            SizedBox(height: 15,),
                            defaultMobileSaudiTextForm(login: true, controller: phoneController),
                            SizedBox(height: 5.0,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
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
                                Text('تذكرنى', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: HexColor('#00AEAC')),textAlign: TextAlign.left,),
                              ],
                            ),
                            SizedBox(height: 15.0),
                           ConditionalBuilder(
                               condition: state is! TradeFreeRegisterLoading,
                               builder: (context)=> defaultMaterialButton(
                                 function: (){
                                   if(_formKey.currentState!.validate()){
                                     TradeCubit.get(context).freeRegister(
                                         name: nameController.text,
                                         phone: '966${phoneController.text}',
                                         email: emailController.text
                                     );
                                   }
                                 },
                                 text: 'دخول',
                               ),
                             fallback: (context)=> Center(child: CircularProgressIndicator(),),
                           ),
                            SizedBox(height: 10,),
                            TextButton(
                                onPressed: (){},
                                child: Text('نسيت كلمه المرور ؟',
                                  style: TextStyle(fontSize: 13.0 , fontWeight: FontWeight.bold, color: HexColor('#D11212')),
                                )
                            ),
                            SizedBox(height: 10.0),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(color: HexColor('#00AEAC'))
                              ),
                              child: MaterialButton(
                                onPressed: (){
                                  defaultNavigateTo(context: context, widget: RegisterScreen());
                                },
                                height: 26.0,
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
              ),
            ),
          );
      },
    );
  }
}
