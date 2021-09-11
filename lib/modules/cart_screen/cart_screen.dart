import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:e_commerce_abdalla/layout/cubit/cubit.dart';
import 'package:e_commerce_abdalla/layout/cubit/states.dart';
import 'package:e_commerce_abdalla/model/home_model/home_model.dart';
import 'package:e_commerce_abdalla/shared/component/component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopAppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('Cart'),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Container(
                margin: EdgeInsets.symmetric(horizontal: 15,vertical: 20),
                height: size.height * 0.15,
                width: double.infinity,
                padding: EdgeInsets.all(
                20,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 10.0,
                      // offset: Offset(10,10)
                    ),
                  ],
                ),

                child: Column(
                  children: [
                    Row(
                      children: [
                        Text('Total',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                        Spacer(),
                        Text('EGP ${cubit.getCart.data.total}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.blue),),
                      ],
                    ),
                    Spacer(),
                    defaultButton(function: (){}, text: 'Complete Your Order',height: 40),
                  ],
                ),
              ),

              ConditionalBuilder(
                condition: cubit.getCart != null,
                builder: (context) =>  Expanded(
                  child: cubit.getCart.data.data.length==0?Column(
                    children: [
                      SizedBox(height: 100,),
                      Icon(
                        Icons.add_shopping_cart,
                        size: 100,
                        color: Colors.blue.withOpacity(0.5),
                      ),
                      Text(
                        'No Item is Added',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                       SizedBox(height: 30,),
                      defaultButton(function: (){
                        cubit.changeCurrentIndexImage(0);
                        Navigator.of(context).pop();
                      }, text: 'Go  Shopping',height: 40,width: 250),
                    ],
                  ):ListView.builder(itemBuilder: (context,index)=>Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: buildCart(size, cubit.getCart.data.data[index],context),
                  ),
                  itemCount: cubit.getCart.data.data.length,
                  ),
                ),

                fallback: (context) =>  Center(child: CircularProgressIndicator(),),
              ),

            ],
          ),
        );
      },
    );
  }

  Container buildCart(Size size, ProductModel model,context) {
    return Container(
      height: size.height * 0.22,
      width: double.infinity,
      padding: EdgeInsets.only(
        right: 5,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 10.0,
            // offset: Offset(10,10)
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  width: 100,
                  height: 120,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 3),
                    child: CachedNetworkImage(
                        imageUrl: model.image),
                  )),
              SizedBox(width: 10,),
              Expanded(
                child: Container(
                  height: 120,
                  //color: Colors.red,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        model.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Row(
                          children: [
                            Text(
                              'EGP ${model.price.round()}',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'EGP ${model.price.round()}',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.lineThrough),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Divider(
            thickness: 1.5,
          ),
          SizedBox(
            height: 5,
          ),
          GestureDetector(
            onTap: (){
              ShopAppCubit.get(context).changeMyCart(model.id);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'Remove',
                  style: TextStyle(color: Colors.red),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
