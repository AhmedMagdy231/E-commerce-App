import 'package:e_commerce_abdalla/model/user.dart';

abstract class ShopRegisterStates {}

class ShopRegisterInitialState extends ShopRegisterStates{}
class ShopRegisterLoadingState extends ShopRegisterStates{}
class ShopRegisterSuccessState extends ShopRegisterStates{
  ShopLoginModel userModel;
  ShopRegisterSuccessState(this.userModel);
}
class ShopRegisterErrorState extends ShopRegisterStates{
  final String error;
  ShopRegisterErrorState(this.error);
}
class ShopRegisterChangeShown extends ShopRegisterStates{}