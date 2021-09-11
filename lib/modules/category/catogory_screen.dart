import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:e_commerce_abdalla/layout/cubit/cubit.dart';
import 'package:e_commerce_abdalla/layout/cubit/states.dart';
import 'package:e_commerce_abdalla/model/categories/categories.dart';
import 'package:e_commerce_abdalla/modules/get_categories_data/get_Categories_data.dart';
import 'package:e_commerce_abdalla/shared/component/component.dart';
import 'package:e_commerce_abdalla/shared/constants/constats.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopAppCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.categoriesModel != null,
          builder: (context) => ListView.separated(
            physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => GestureDetector(
                onTap: (){
                  navigateTo(context, GetCategories(cubit.categoriesModel.data.data[index]));
                  cubit.getCategoriesData(cubit.categoriesModel.data.data[index].id);

                },
                child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:
                          categoriesRow(cubit.categoriesModel.data.data[index]),
                    ),
              ),
              separatorBuilder: (context, index) => SizedBox(
                    child: Divider(thickness: 1.5,),
                  ),
              itemCount: cubit.categoriesModel.data.data.length),
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Row categoriesRow(DataModel model) {
    return Row(
      children: [
        Container(
          height: 100,
          width: 100,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(width: 1, color: kPrimaryColor)),
          child: CachedNetworkImage(
            imageUrl: model.image,
            placeholder: (context, url) => CircularProgressIndicator(),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Text(
          model.name,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Spacer(),
        Icon(
          Icons.arrow_forward_ios,
          size: 30,
          color: kPrimaryColor,
        ),
      ],
    );
  }
}
