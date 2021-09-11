import 'package:bloc/bloc.dart';
import 'package:e_commerce_abdalla/model/user.dart';
import 'package:e_commerce_abdalla/modules/login/cubit/states.dart';
import 'package:e_commerce_abdalla/modules/register/cubit/states.dart';
import 'package:e_commerce_abdalla/shared/network/end_point.dart';
import 'package:e_commerce_abdalla/shared/network/remote/dio_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<ShopRegisterStates> {
  RegisterCubit() : super(ShopRegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);
  ShopLoginModel userModel;

  void userRegister(String email, String password, String phone, String name) {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(
      lang: 'en',
      url: REGISTER,
      data: {
        'email': email,
        'password': password,
        'phone': phone,
        'name': name,
      },
    ).then((value) {
      userModel = ShopLoginModel.formjson(value.data);
      emit(ShopRegisterSuccessState(userModel));
    }).catchError((error) {
      emit(ShopRegisterErrorState(error));
    });
  }

  bool isShown = false;
  IconData suffixIcon = Icons.visibility_off_rounded;

  void changeShown() {
    isShown = !isShown;
    suffixIcon = isShown ? Icons.visibility : Icons.visibility_off_rounded;
    emit(ShopRegisterChangeShown());
  }
}
