import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:e_commerce_abdalla/layout/cubit/cubit.dart';
import 'package:e_commerce_abdalla/layout/cubit/states.dart';
import 'package:e_commerce_abdalla/model/categories/categories.dart';
import 'package:e_commerce_abdalla/model/getCategories/getCategories.dart';
import 'package:e_commerce_abdalla/model/home_model/home_model.dart';
import 'package:e_commerce_abdalla/modules/details/details_screen.dart';
import 'package:e_commerce_abdalla/shared/component/component.dart';
import 'package:e_commerce_abdalla/shared/constants/constats.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetCategories extends StatelessWidget {
  final DataModel model;

  GetCategories(this.model);

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
        return Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  if(state is ShopGetCategoriesLoadingScreen)
                    SizedBox(height: size.height*0.35,),
                  Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    color: Colors.black.withOpacity(0.2),
                    padding: EdgeInsets.all(6),
                    child: Text(
                      '${model.name.toUpperCase()} PRODUCT',

                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ConditionalBuilder(
                      condition: state is! ShopGetCategoriesLoadingScreen,
                      builder: (context)=> cubit.getCategoriesModel==null||cubit.getCategoriesModel.data.data.length==0?Column(
                        children: [
                          SizedBox(height: size.height*.2,),
                          Icon(
                            Icons.shopping_bag_outlined,
                            size: 100,
                            color: Colors.blue.withOpacity(0.5),
                          ),
                          Text(
                            'No Product Add Yet',
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          )
                        ],
                      ): Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          border: Border.all(color: Colors.grey),
                        ),

                        child: GridView.count(
                          crossAxisCount: 2,
                          children: List.generate(
                            cubit.getCategoriesModel.data.data.length,
                                (index) => GestureDetector(
                                  onTap: (){
                                    print(cubit.getCategoriesModel.data.data[index].id);
                                    cubit.update();
                                    navigateTo(context, DetailsScreen(cubit.getCategoriesModel.data.data[index]));
                                  },
                                  child: buildProductItem(size, context,
                                  cubit.getCategoriesModel.data.data[index]),
                                ),
                          ),
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          mainAxisSpacing: 1,
                          crossAxisSpacing: 1,
                          childAspectRatio: 1 / 1.7,
                        ),
                      ),
                      fallback: (context)=>Center(child: LinearProgressIndicator(
                        minHeight: 10,
                      ),),
                    ),

                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildProductItem(size, context, ProductModel model) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              CachedNetworkImage(
                imageUrl: model.image,
                placeholder: (context, url) =>
                    Center(child: CircularProgressIndicator()),
                height: size.height * 0.25,
                width: double.infinity,
              ),
              if (model.discount != 0)
                Container(
                  margin: EdgeInsets.only(left: 5),
                  color: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    'Discount',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              if (model.discount != 0)
                Positioned(
                  right: size.width * 0.05,
                  top: size.height * 0.01,
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    width: size.width * 0.15,
                    height: size.height * 0.03,
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      '${model.discount}%',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: size.height * .009,
                ),
                Row(
                  children: [
                    Text(
                      '${model.price.round()} ',
                      style: TextStyle(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                          height: 1.5),
                    ),
                    SizedBox(
                      width: 2.0,
                    ),
                    if (model.discount != 0)
                      Text(
                        '${model.oldPrice.round()}',
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            height: 1.5,
                            decoration: TextDecoration.lineThrough),
                      ),
                    Spacer(),
                    CircleAvatar(
                      backgroundColor:
                      ShopAppCubit.get(context).favorite[model.id]==null?Colors.grey:ShopAppCubit.get(context).favorite[model.id]
                          ? kPrimaryColor
                          : Colors.grey,
                      radius: 15,
                      child: IconButton(
                        icon: Icon(Icons.favorite_border),
                        onPressed: () {
                          ShopAppCubit.get(context)
                              .changeFavoriteItem(model.id);
                        },
                        padding: EdgeInsets.zero,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
