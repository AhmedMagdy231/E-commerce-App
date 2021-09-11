
import 'package:conditional_builder/conditional_builder.dart';
import 'package:e_commerce_abdalla/layout/cubit/cubit.dart';
import 'package:e_commerce_abdalla/layout/cubit/states.dart';
import 'package:e_commerce_abdalla/modules/cart_screen/cart_screen.dart';
import 'package:e_commerce_abdalla/modules/login/LoginScreen.dart';
import 'package:e_commerce_abdalla/modules/search/search_screen.dart';
import 'package:e_commerce_abdalla/shared/component/component.dart';
import 'package:e_commerce_abdalla/shared/network/local/cashHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopHomeLayout extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit,ShopAppStates>(
         listener: (context,state){},
         builder: (context,state){
           var cubit=ShopAppCubit.get(context);
           return Scaffold(
             appBar: AppBar(
               title: Text('Salla'),
               actions: [
                 IconButton(icon: Icon(Icons.search), onPressed: (){
                   navigateTo(context, SearchScreen());
                 }),

                 Stack(
                   children: [
                     IconButton(icon: Icon(Icons.shopping_cart), onPressed: (){
                       cubit.getMyCart();
                       navigateTo(context, CartScreen());

                     }),
                     CircleAvatar(
                       radius: 10,
                       backgroundColor: Colors.red,
                       child: ConditionalBuilder(
                         condition: cubit.getCart != null,
                         builder: (context)=>Text(cubit.getCart.data.data.length.toString()),
                         fallback: (context)=> Center(child: Text('')),
                       ),
                     ),
                   ],
                 ),
               ],
             ),
             body: cubit.myScreen[cubit.currentIndex],
             bottomNavigationBar: BottomNavigationBar(
               items: [
                 BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
                 BottomNavigationBarItem(icon: Icon(Icons.apps),label: 'Category'),
                 BottomNavigationBarItem(icon: Icon(Icons.favorite_border),label: 'Favorite'),
                 BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'Setting'),
               ],
               currentIndex: cubit.currentIndex,
               onTap: (index){
                 cubit.changeCurrentIndex(index);
               },
             ),

           );
         },

    );
  }
}
