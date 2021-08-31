import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:abc_trade/layout/home_screen.dart';
import 'package:abc_trade/modules/cubit/cubit.dart';
import 'package:abc_trade/modules/cubit/state.dart';
import 'package:abc_trade/modules/user/user_Screen.dart';
import 'package:abc_trade/shared/components.dart';
import 'package:abc_trade/shared/local/shared.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? _mySelectionQouta;
  GlobalKey<dynamic> dropBottonKeyQouta= GlobalKey();
  var currentDate;
 String? country;
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var countryController = TextEditingController();
  var timeController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> _globalKey = new GlobalKey<FormState>();
  String? countryCode;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TradeCubit, TradeStates>(
        listener: (context, state){
          if(state is TradeSaveDeviceTokenSuccess){
            print('Save Token Success');
          }
          if(state is TradeRegisterSuccess){
              if(TradeCubit.get(context).registers!.status == 0){
                Fluttertoast.showToast(
                    msg: 'قيمة الحقل البريد الالكتروني مُستخدمة من قبل',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 3,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 16.0);
              }else{
                  defaultFinishNavigate(widget: HomeScreen(widget: UserScreen(),),context: context);
              }
          }
        },
      builder: (context, state){
          var qouta = TradeCubit.get(context);
          var token = CashHelper.getData(key: 'loginToken');
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              key: _scaffoldKey,
              drawer: defaultDrawer(context: context),
              appBar: defaultHomeAppBar(
                token: token,
                context: context,
                  scaffoldKey: _scaffoldKey,
                  text: 'إشتراك'
              ),
              body: SingleChildScrollView(
                child: Form(
                  key: _globalKey,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0,
                        left:30,
                        right: 30
                    ),
                    child: Column(
                      children: [
                        Image.asset('assets/images/package_logo.png'),
                        SizedBox(height: 30.0,),
                        defaultFormText(
                          hint: 'الاسم',
                          align: TextAlign.right,
                          icon: Icons.person,
                          controller: nameController,
                          validator: (v){
                            if(v.isEmpty){
                              return 'برجاء ادخال الاسم';
                            }
                          }
                        ),

                        SizedBox(height: 5.0,),
                        defaultFormText(
                            hint: 'البريد الالكترونى',
                            align: TextAlign.right,
                            icon: Icons.email,
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validator: (v){
                              if(v.isEmpty){
                                return 'برجاء ادخال البريد الالكترونى';
                              }
                            }
                        ),
                        SizedBox(height: 5.0,),
                        defaultMobileSaudiTextForm(
                          controller: phoneController,
                        ),
                        // defaultMobileTextForm(control: phoneController,code: countryCode),
                        SizedBox(height: 5.0,),
                        // Container(
                        //   height: 50,
                        //   decoration: BoxDecoration(
                        //     color: Colors.white,
                        //     boxShadow: [
                        //       BoxShadow(
                        //           color: Colors.black38, spreadRadius: 0, blurRadius: 0),
                        //     ],
                        //     borderRadius: BorderRadius.circular(25.0),
                        //   ),
                        //   width: double.infinity,
                        //   child: FlatButton(
                        //     child: Container(
                        //       child: Row(
                        //         mainAxisAlignment: MainAxisAlignment.end,
                        //         crossAxisAlignment: CrossAxisAlignment.end,
                        //         children: [
                        //           if(country == null)
                        //             Text('الدولة',
                        //               style: TextStyle(color: Colors.black, fontSize: 14),
                        //             ),
                        //           if(country != null)
                        //             Text('$country',
                        //               style: TextStyle(color: Colors.black, fontSize: 14),
                        //             ),
                        //           Spacer(),
                        //           Icon(Icons.arrow_drop_down_sharp, size: 20, color: Colors.black,),
                        //         ],
                        //       ),
                        //     ) ,
                        //     onPressed: (){
                        //       print('${countryController.text}');
                        //       showCountryPicker(
                        //         context: context,
                        //         exclude: <String>[
                        //           'KN',
                        //           'MF',
                        //           'AF',
                        //           'AX',
                        //         ],
                        //         showPhoneCode: false,
                        //         onSelect: (Country countries) {
                        //           setState(() {
                        //             countryController.clear();
                        //             country = countries.name;
                        //           });
                        //         },
                        //         countryListTheme: CountryListThemeData(
                        //           borderRadius: BorderRadius.only(
                        //             topLeft: Radius.circular(40.0),
                        //             topRight: Radius.circular(40.0),
                        //           ),
                        //           inputDecoration: InputDecoration(
                        //             labelText: 'Search',
                        //             hintText: 'Start typing to search',
                        //             prefixIcon: const Icon(Icons.search),
                        //             border: OutlineInputBorder(
                        //               borderSide: BorderSide(
                        //                 color: const Color(0xFF8C98A8).withOpacity(0.2),
                        //               ),
                        //             ),
                        //           ),
                        //         ),
                        //       );
                        //     },
                        //   ),
                        // ),
                        // SizedBox(height: 5.0,),
                        // GestureDetector(
                        //   onTap: ()async{
                        //     final DateTime? pickedDate = await showDatePicker(
                        //         context: context,
                        //         initialDate: DateTime.now(),
                        //         firstDate: DateTime(1950),
                        //         lastDate: DateTime(2050));
                        //     var formate = "${pickedDate!.day}-${pickedDate.month}-${pickedDate.year}";
                        //     if (pickedDate != null && pickedDate != currentDate)
                        //       setState(() {
                        //         currentDate = formate;
                        //       });
                        //   },
                        //   child: Container(
                        //     height: 55.0,
                        //     width: double.infinity,
                        //     alignment: Alignment.center,
                        //     decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.all(Radius.circular(25.0)),
                        //       color: HexColor('#00AEAC'),
                        //     ),
                        //     padding: EdgeInsetsDirectional.only(
                        //       end: 10,
                        //       start: 10,
                        //     ),
                        //     child: Row(
                        //       children: [
                        //         Text((currentDate == null) ? 'تاريخ الميلاد' : '$currentDate', style: TextStyle(color: Colors.white),),
                        //         Spacer(),
                        //         Icon(Icons.calendar_today_sharp, color: Colors.white,)
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        defaultDropButton(
                            hint: 'الباقه',
                            key: dropBottonKeyQouta,
                            listItem: qouta.packages.map((item) {
                              return new DropdownMenuItem(
                                child: new Text('${item['name']}'),
                                value: item['id'].toString(),
                              );
                            }).toList(),
                            function: (newVal) {
                              setState(() {
                                _mySelectionQouta = newVal as String;
                              });
                            },
                            value: _mySelectionQouta
                        ),
                        SizedBox(height: 5.0,),
                        defaultFormText(
                          hint: 'كلمه المرور',
                          controller: passwordController,
                          type: TextInputType.name,
                          obscure: true,
                          icon: Icons.lock_outline_sharp,
                            validator: (v){
                              if(v.isEmpty){
                                return 'برجاء ادخال كلمة السرى';
                              }
                            }
                        ),
                        SizedBox(height: 5.0,),
                        defaultFormText(
                          hint: 'تاكيد كلمه المرور',
                          controller: confirmPasswordController,
                          type: TextInputType.name,
                          obscure: true,
                          icon: Icons.lock_outline_sharp,
                            validator: (v){
                              if(v != passwordController.text){
                                return 'تاكيد الرقم السرى غير صحيح';
                              }
                            }
                        ),
                        SizedBox(height: 20.0,),
                       ConditionalBuilder(
                           condition: state is! TradeRegisterLoading,
                           builder: (context)=>
                               defaultMaterialButton(
                               text: 'تسجيل',
                               function: (){
                                 if(_globalKey.currentState!.validate()){
                                   qouta.register(
                                       password: passwordController.text,
                                       email: emailController.text,
                                       phone: '966${phoneController.text}',
                                       name: nameController.text,
                                       package: _mySelectionQouta,
                                   );

                                   if(TradeCubit.get(context).registers!.status != 0){
                                     TradeCubit.get(context).saveDeviceToken(
                                       device_id: qouta.register(),
                                       user_id: qouta.register().userIdApi
                                     );
                                   }
                                   if(TradeCubit.get(context).registers!.status != 0 && state is TradeSaveDeviceTokenSuccess){
                                     qouta.registerFirebase(
                                       password: passwordController.text,
                                       email: emailController.text,
                                     );
                                   }
                                 }
                                 print(_mySelectionQouta);
                               }
                           ),
                         fallback: (context)=> Center(child: CircularProgressIndicator(),),
                       )
                      ],
                    ),
                  ),
                ),
              ),

            ),
          );
      },
    );
  }
}
