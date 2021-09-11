import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:e_commerce_abdalla/layout/cubit/cubit.dart';
import 'package:e_commerce_abdalla/layout/cubit/states.dart';
import 'package:e_commerce_abdalla/model/categories/categories.dart';
import 'package:e_commerce_abdalla/model/home_model/home_model.dart';
import 'package:e_commerce_abdalla/modules/details/details_screen.dart';
import 'package:e_commerce_abdalla/modules/get_categories_data/get_Categories_data.dart';
import 'package:e_commerce_abdalla/shared/component/component.dart';
import 'package:e_commerce_abdalla/shared/constants/constats.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
        Size size = MediaQuery.of(context).size;
        return ConditionalBuilder(
          condition: cubit.homeModel != null && cubit.categoriesModel != null,
          builder: (context) => homeProduct(
              cubit.homeModel, size, cubit.categoriesModel, context,cubit),
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget homeProduct(
      HomeModel model, Size size, CategoriesModel categoryModel, context,cubit) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 150,
            width: double.infinity,
            child: CarouselSlider(
              items: model.data.banners
                  .map((e) => Image(
                        image: NetworkImage(
                          e.image,
                        ),
                        width: double.infinity,
                        fit: BoxFit.fill,
                      ))
                  .toList(),
              options: CarouselOptions(
                autoPlay: true,
                autoPlayAnimationDuration: Duration(seconds: 1),
                autoPlayInterval: Duration(seconds: 3),
                //disableCenter: true,
                reverse: false,
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
                viewportFraction: 1.0,
                height: size.height * .25,
                enlargeCenterPage: true,
                initialPage: 0,
              ),
            ),
          ),
          Container(
              alignment: Alignment.center,
              width: double.infinity,
              color: Colors.black.withOpacity(0.2),
              padding: EdgeInsets.all(6),
              child: Text(
                'Categories',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )),
          SizedBox(
            height: size.height * .03,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
                height: size.height * 0.2,
                child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, index) =>
                        GestureDetector(
                          onTap: (){
                            navigateTo(context, GetCategories(categoryModel.data.data[index]));
                            cubit.getCategoriesData(cubit.categoriesModel.data.data[index].id);
                          },
                        child: categoriesItem(size, categoryModel.data.data[index])),
                    separatorBuilder: (_, index) => SizedBox(
                          width: 5,
                        ),
                    itemCount: categoryModel.data.data.length)),
          ),
          SizedBox(
            height: size.height * .001,
          ),
          Container(
              alignment: Alignment.center,
              width: double.infinity,
              color: Colors.black.withOpacity(0.2),
              padding: EdgeInsets.all(6),
              child: Text(
                'New Product',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[300],
              border: Border.all(color: Colors.grey),
            ),
            child: GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: List.generate(
                  model.data.products.length,
                  (index) => Center(
                      child: GestureDetector(
                        onTap: (){
                          ShopAppCubit.get(context).update();
                          navigateTo(context, DetailsScreen(model.data.products[index]));
                        },
                          child: showProduct(
                              model.data.products[index], size, context)))),
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
              childAspectRatio: 1 / 1.7,
            ),
          ),
        ],
      ),
    );
  }

  Widget categoriesItem(Size size, DataModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 100,
          height: 100,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            border: Border.all(width: 2, color: kPrimaryColor),
            //borderRadius: BorderRadius.circular(50),
            shape: BoxShape.circle,
          ),
          child: CachedNetworkImage(
            imageUrl: model.image,
            fit: BoxFit.cover,
            placeholder: (context, url) => Center(
              child: CircularProgressIndicator(),

            ),
          ),
        ),
        SizedBox(
          height: size.height * .009,
        ),
        Container(
            alignment: Alignment.center,
            //  color: Colors.red,
            width: size.width * .3,
            child: Center(
              child: Text(
                model.name,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            )),
      ],
    );
  }

  Widget showProduct(ProductModel model, Size size, context) => Container(
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
                            ShopAppCubit.get(context).favorite[model.id]
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
