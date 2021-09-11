import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_abdalla/layout/cubit/cubit.dart';
import 'package:e_commerce_abdalla/layout/cubit/states.dart';
import 'package:e_commerce_abdalla/model/getFavorite/getFavorite.dart';
import 'package:e_commerce_abdalla/shared/component/component.dart';
import 'package:e_commerce_abdalla/shared/constants/constats.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context, state) {
        if (state is ShopFavoriteSuccessScreen) {
          if (!state.model.status) {
            showToast(text: state.model.message, state: TypeOfToast.Error);
          } else {
            showToast(
                text: state.model.message,
                state: TypeOfToast.Success,
                length: 0);
          }
        }
      },
      builder: (context, state) {
        var cubit = ShopAppCubit.get(context);
        print(cubit.empty);
        return cubit.empty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.favorite_border,
                      size: 100,
                      color: Colors.red.withOpacity(0.5),
                    ),
                    Text(
                      'No Favorite Add Yet',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    )
                  ],
                ),
              )
            : ListView.separated(
             physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(10),
                      child: builtFavoriteItem(
                          size,
                          cubit.favoriteModel.data.data[index].product,
                          context),
                    ),
                separatorBuilder: (context, index) => SizedBox(


                    ),
                itemCount: cubit.favoriteModel.data.data.length);
      },
    );
  }


}
