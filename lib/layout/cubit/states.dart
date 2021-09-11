import 'package:e_commerce_abdalla/model/changeCart/changeCart.dart';
import 'package:e_commerce_abdalla/model/change_favorite/change_favorite.dart';
import 'package:e_commerce_abdalla/model/user.dart';

abstract class ShopAppStates{}
class ShopAppInitialState extends ShopAppStates{}
class ShopAppChangeBottomNavigator extends ShopAppStates{}
class ShopHomeLoadingScreen extends ShopAppStates{}
class ShopHomeSuccessScreen extends ShopAppStates{}
class ShopHomeErrorScreen extends ShopAppStates{}
class ShopCategoriesSuccessScreen extends ShopAppStates{}
class ShopCategoriesErrorScreen extends ShopAppStates{}
class ShopFavoriteSuccessScreen extends ShopAppStates{
  final ChangeFavorite model;
  final int id;

  ShopFavoriteSuccessScreen(this.model,this.id);
}
class ShopFavoritesSuccessScreen extends ShopAppStates{}
class ShopFavoriteErrorScreen extends ShopAppStates{}

class ShopGetFavoriteSuccessScreen extends ShopAppStates{}
class ShopGetFavoriteErrorScreen extends ShopAppStates{}
class ShopGetFavoriteLoadingScreen extends ShopAppStates{}
class ShopEmpty extends ShopAppStates{}

class ShopGetProfileSuccessScreen extends ShopAppStates{}
class ShopGetProfileErrorScreen extends ShopAppStates{}
class ShopGetProfileLoadingScreen extends ShopAppStates{}

class ShopUpdateProfileSuccessScreen extends ShopAppStates{
  ShopLoginModel userModel;
  ShopUpdateProfileSuccessScreen(this.userModel);
}
class ShopUpdateProfileErrorScreen extends ShopAppStates{}
class ShopUpdateProfileLoadingScreen extends ShopAppStates{}

class ShopChangeIndexImage extends ShopAppStates{}
class ShopDetailsScreen extends ShopAppStates{}

class ShopGetCategoriesSuccessScreen extends ShopAppStates{}
class ShopGetCategoriesErrorScreen extends ShopAppStates{}
class ShopGetCategoriesLoadingScreen extends ShopAppStates{}


class ShopChangeCartSuccessScreen extends ShopAppStates{
  final ChangeCart changeCart;
  ShopChangeCartSuccessScreen(this.changeCart);
}
class ShopChangeCartErrorScreen extends ShopAppStates{}
class ShopChangeCartLoadingScreen extends ShopAppStates{}

class ShopChangeCartSucScreen extends ShopAppStates{}


class ShopGetCartSuccessScreen extends ShopAppStates{}
class ShopGetCartErrorScreen extends ShopAppStates{}
class ShopGetCartLoadingScreen extends ShopAppStates{}