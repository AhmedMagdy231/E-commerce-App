import 'package:bloc/bloc.dart';
import 'package:e_commerce_abdalla/layout/cubit/cubit.dart';
import 'package:e_commerce_abdalla/layout/shop_layout.dart';
import 'package:e_commerce_abdalla/modules/login/LoginScreen.dart';
import 'package:e_commerce_abdalla/modules/login/cubit/cubit.dart';
import 'package:e_commerce_abdalla/modules/on_boarding/on_boarding_screen.dart';
import 'package:e_commerce_abdalla/modules/register/cubit/cubit.dart';
import 'package:e_commerce_abdalla/modules/search/cubit/cubit.dart';
import 'package:e_commerce_abdalla/shared/bloc_observer.dart';
import 'package:e_commerce_abdalla/shared/constants/constats.dart';
import 'package:e_commerce_abdalla/shared/network/local/cashHelper.dart';
import 'package:e_commerce_abdalla/shared/network/remote/dio_helper.dart';
import 'package:e_commerce_abdalla/shared/styles/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CashHelper.init();
  Widget firstWidget;
  bool onBoarding =  CashHelper.getData(key: 'onBoarding');
  kToken =CashHelper.getData(key: 'token');

  if(onBoarding!=null){
    if(kToken!=null) firstWidget=ShopHomeLayout();
    else firstWidget=LoginScreen();
  }else{
    firstWidget = OnBoardingScreen();
  }


  runApp(MyApp(widget: firstWidget,));

}

class MyApp extends StatelessWidget {
  final Widget widget;
  MyApp({this.widget});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>LoginCubit()),
        BlocProvider(create: (context)=>ShopAppCubit()..getHomeData()..CategoriesData()..getFavorite()..getProfileData()..getMyCart()),
        BlocProvider(create: (context)=>RegisterCubit()),
        BlocProvider(create: (context)=>SearchCubit()),
      ],
      child: MaterialApp(
        showSemanticsDebugger: false,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: lightTheme,
        darkTheme: darkTheme,
        home: widget,
      ),
    );
  }
}
