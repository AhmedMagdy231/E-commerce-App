import 'package:e_commerce_abdalla/model/user.dart';

abstract class ShopLoginStates {}

class ShopLoginInitialState extends ShopLoginStates{}
class ShopLoadingState extends ShopLoginStates{}
class ShopSuccessState extends ShopLoginStates{
  ShopLoginModel userModel;
  ShopSuccessState(this.userModel);
}
class ShopErrorState extends ShopLoginStates{
  final String error;
  ShopErrorState(this.error);
}
class ShopLoginChangeShown extends ShopLoginStates{}