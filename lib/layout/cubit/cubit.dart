import 'package:bloc/bloc.dart';
import 'package:e_commerce_abdalla/layout/cubit/states.dart';
import 'package:e_commerce_abdalla/model/categories/categories.dart';
import 'package:e_commerce_abdalla/model/changeCart/changeCart.dart';
import 'package:e_commerce_abdalla/model/change_favorite/change_favorite.dart';
import 'package:e_commerce_abdalla/model/getCart/getCart.dart';
import 'package:e_commerce_abdalla/model/getCategories/getCategories.dart';
import 'package:e_commerce_abdalla/model/getFavorite/getFavorite.dart';
import 'package:e_commerce_abdalla/model/home_model/home_model.dart';
import 'package:e_commerce_abdalla/model/user.dart';
import 'package:e_commerce_abdalla/modules/category/catogory_screen.dart';
import 'package:e_commerce_abdalla/modules/details/details_screen.dart';
import 'package:e_commerce_abdalla/modules/favorite/favorite_screen.dart';
import 'package:e_commerce_abdalla/modules/product/product_screen.dart';
import 'package:e_commerce_abdalla/modules/setting/setting.dart';
import 'package:e_commerce_abdalla/shared/constants/constats.dart';
import 'package:e_commerce_abdalla/shared/network/end_point.dart';
import 'package:e_commerce_abdalla/shared/network/remote/dio_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopAppCubit extends Cubit<ShopAppStates> {
  ShopAppCubit() : super(ShopAppInitialState());

  static ShopAppCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;

  void changeCurrentIndex(int index) {
    currentIndex = index;
    emit(ShopAppChangeBottomNavigator());
  }

  List<Widget> myScreen = [
    HomeScreen(),
    CategoryScreen(),
    FavoriteScreen(),
    SettingScreen(),
  ];

  HomeModel homeModel;
  Map<int, bool> favorite = {};
  Map<int, bool> cart = {};

  int currentIndexImage = 0;

  void changeCurrentIndexImage(int index) {
    currentIndexImage = index;
    emit(ShopChangeIndexImage());
  }

  void update() {
    changeCurrentIndexImage(0);
    emit(ShopDetailsScreen());
  }

  void getHomeData() {
    emit(ShopHomeLoadingScreen());
    DioHelper.getData(url: HOME, token: kToken).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel.data.products.forEach((element) {
        favorite.addAll({element.id: element.inFavorite});
        cart.addAll({element.id: element.inCart});
      });
      print(favorite);
      homeModel.data.products[0].images.forEach((element) {
        print(element);
      });

      emit(ShopHomeSuccessScreen());
    }).catchError((error) {
      print(error.toString());

      emit(ShopHomeErrorScreen());
    });
  }

  CategoriesModel categoriesModel;
  ChangeFavorite changeFavorite;

  void CategoriesData() {
    DioHelper.getData(url: GET_CATEGORY).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);

      emit(ShopCategoriesSuccessScreen());
    }).catchError((error) {
      print(error);
      emit(ShopCategoriesErrorScreen());
    });
  }

  void changeFavoriteItem(int productID) {
    print(favorite[productID]);
    if (favorite[productID] == null) {
      favorite.addAll({productID: true});
      emit(ShopFavoritesSuccessScreen());
    }else{
      favorite[productID] = !favorite[productID];
      emit(ShopFavoritesSuccessScreen());

    }

    DioHelper.postData(
      url: FAVORITE,
      data: {'product_id': productID},
      token: kToken,
    ).then((value) {
      changeFavorite = ChangeFavorite.fromJson(value.data);

      if (!changeFavorite.status) {
        favorite[productID] = !favorite[productID];
        print(favorite[productID]);
      }
      getFavorite();
      emit(ShopFavoriteSuccessScreen(changeFavorite, productID));
    }).catchError((error) {
      favorite[productID] = !favorite[productID];

      emit(ShopFavoriteErrorScreen());
    });
  }

  FavoriteModel favoriteModel;
  bool empty = true;

  void getFavorite() {
    DioHelper.getData(url: FAVORITE, token: kToken).then((value) {
      favoriteModel = FavoriteModel.fromJson(value.data);
      favoriteModel.data.data.forEach((element) {
        if(favorite[element.id]==null){
          favorite.addAll({element.product.id:true});
        }
      });
      if (favoriteModel.data.data.length != 0) {
        empty = false;
      } else {
        empty = true;
      }
      emit(ShopEmpty());

      emit(ShopGetFavoriteSuccessScreen());
    }).catchError((error) {
      emit(ShopGetFavoriteErrorScreen());
      print(error.toString());
    });
  }

  ShopLoginModel shopLoginModel;

  void getProfileData() {
    emit(ShopGetProfileLoadingScreen());
    DioHelper.getData(url: PROFILE, token: kToken).then((value) {
      shopLoginModel = ShopLoginModel.formjson(value.data);
      print(shopLoginModel.data.name);
      emit(ShopGetProfileSuccessScreen());
    }).catchError((error) {
      emit(ShopGetProfileErrorScreen());
    });
  }

  void updateProfileData(String name, String phone, String email) {
    emit(ShopUpdateProfileLoadingScreen());
    DioHelper.putData(url: UPDATE_PROFILE, token: kToken, data: {
      'name': name,
      'email': email,
      'phone': phone,
    }).then((value) {
      if (value.data['status'])
        shopLoginModel = ShopLoginModel.formjson(value.data);
      print(shopLoginModel.message);
      emit(ShopUpdateProfileSuccessScreen(shopLoginModel));
    }).catchError((error) {
      print(error.toString());
      emit(ShopUpdateProfileErrorScreen());
    });
  }

  GetCategoriesModel getCategoriesModel;

  void getCategoriesData(int ID) {
    emit(ShopGetCategoriesLoadingScreen());
    DioHelper.getData(url: PRODUCT, query: {'category_id': ID}).then((value) {
      getCategoriesModel = GetCategoriesModel.fromJson(value.data);
      print(getCategoriesModel.data.data.length);
      emit(ShopGetCategoriesSuccessScreen());
    }).catchError((error) {
      print(error.toString());
      emit(ShopGetCategoriesErrorScreen());
    });
  }

  ChangeCart changeCart;

  void changeMyCart(int productID) {
    print(cart[productID]);
    if (cart[productID] == null) {
      cart.addAll({productID: true});
      print(cart[productID]);
      emit(ShopChangeCartSucScreen());
    }else{
      cart[productID] = !cart[productID];
      emit(ShopChangeCartSucScreen());
    }

    DioHelper.postData(url: CART, data: {'product_id': productID},token: kToken)
        .then((value) {
      changeCart = ChangeCart.fromJson(value.data);
      getMyCart();
      emit(ShopChangeCartSuccessScreen(changeCart));
    }).catchError((error) {
      print(error.toString());
      emit(ShopChangeCartErrorScreen());
    });

  }


  GetCart getCart;
  void getMyCart(){



    DioHelper.getData(url: CART,token: kToken).then((value){
      getCart=GetCart.fromJson(value.data);
      getCart.data.data.forEach((element) {
        if(cart[element.id]==null){
          cart.addAll({element.id:true});
        }
      });
      print('-------------------------------------------------');
      print(getCart.data.total);
      print('-------------------------------------------------');
      emit(ShopGetCartSuccessScreen());
    }).catchError((error){
      print(error.toString());
      emit(ShopGetCartErrorScreen());
    });

  }



}
