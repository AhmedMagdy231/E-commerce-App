import 'package:bloc/bloc.dart';
import 'package:e_commerce_abdalla/model/user.dart';
import 'package:e_commerce_abdalla/modules/login/cubit/states.dart';
import 'package:e_commerce_abdalla/shared/network/end_point.dart';
import 'package:e_commerce_abdalla/shared/network/remote/dio_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<ShopLoginStates> {
  LoginCubit() : super(ShopLoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);
  ShopLoginModel userModel;

  void userLogin(String email, String password) {
    emit(ShopLoadingState());
    DioHelper.postData(
      lang: 'en',
      url: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      print('ddddddddddddddddddddddddddddddddddddddddddddddddddddddd');
      userModel = ShopLoginModel.formjson(value.data);
      emit(ShopSuccessState(userModel));
    }).catchError((error) {
      emit(ShopErrorState(error));
    });
  }
  bool isShown = false;
  IconData suffixIcon=Icons.visibility_off_rounded;
   void changeShown(){
    isShown = !isShown;
    suffixIcon = isShown?Icons.visibility:Icons.visibility_off_rounded;
    emit(ShopLoginChangeShown());
  }

}
