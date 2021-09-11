import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:e_commerce_abdalla/layout/cubit/cubit.dart';
import 'package:e_commerce_abdalla/layout/cubit/states.dart';
import 'package:e_commerce_abdalla/model/home_model/home_model.dart';
import 'package:e_commerce_abdalla/modules/cart_screen/cart_screen.dart';
import 'package:e_commerce_abdalla/shared/component/component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsScreen extends StatelessWidget {
  final ProductModel productModel;

  DetailsScreen(this.productModel);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context, state) {
        if(state is ShopChangeCartSuccessScreen)
        {
          showToast(text:  '${state.changeCart.message}', state: TypeOfToast.Success,length: 0);

        }
      },
      builder: (context, index) {
        int ind = -1;
        var cubit = ShopAppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            actions: [
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
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: SafeArea(
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * .0,
                  ),
                  buildName(),
                  buildStackImage(size, cubit),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ...productModel.images.map<Widget>((e) {
                        ind = ind + 1;
                        return buildContainer(ind, context);
                      }).toList(),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  buildPrice(cubit),
                  SizedBox(
                    height: 20,
                    child: Divider(
                      thickness: 1.5,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Free delivery ',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'by ',
                              style: TextStyle(),
                            ),
                            Text(
                              'Sun, Sep 12',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          'Order in 10h 5m',
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                    child: Divider(
                      thickness: 1.5,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://img.pikbest.com/png-images/qiantu/yellow-vip-logo_2622515.png!c1024wm0/compress/true/progressive/true/format/webp/fw/1024'),
                          backgroundColor: Colors.white,
                        ),
                        Text(
                          '  Earn EGP 33.99',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          ' cashback',
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text(
                          ' Get Salla VIP ',
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                    child: Divider(
                      thickness: 1.5,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          'Offer Details',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.all_inclusive_outlined,
                              color: Colors.blue,
                            ),
                            Text('  Enjoy hassle free return with this offer',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                    child: Divider(
                      thickness: 1.5,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      children: [
                        Icon(
                          Icons.where_to_vote_rounded,
                          color: Colors.blue,
                        ),
                        Text('  2 year warranty',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                    child: Divider(
                      thickness: 1.5,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.add_business_sharp),
                            Text(
                              ' Sold by ',
                              style: TextStyle(),
                            ),
                            Text(
                              ' Salla',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Seller',
                                  style: TextStyle(),
                                ),
                                Text(
                                  'Reviews',
                                  style: TextStyle(),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.orangeAccent,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.orangeAccent,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.orangeAccent,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.orangeAccent,
                            ),
                            Icon(
                              Icons.star_half_rounded,
                              color: Colors.orangeAccent,
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Text(
                              '(4.5)',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                    child: Divider(
                      thickness: 1.5,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Description',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(productModel.description),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Padding buildPrice(ShopAppCubit cubit) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'EGP',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                  Text(
                    '  ${productModel.price.round()}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              if (productModel.discount != 0)
                Row(
                  children: [
                    Text(
                      'EGP ${productModel.oldPrice}',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.lineThrough),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.2),
                        shape: BoxShape.rectangle,
                      ),
                      child: Text(
                        '${productModel.discount} %',
                        style: TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
            ],
          ),
          Spacer(),
          Container(
            decoration: BoxDecoration(
              color: cubit.cart[productModel.id]==null?Colors.white:cubit.cart[productModel.id]?Colors.blue:Colors.white,
                shape: BoxShape.circle, border: Border.all( color:cubit.cart[productModel.id]==null?Colors.black:cubit.cart[productModel.id]?Colors.white:Colors.black,)),
            child: IconButton(
              icon: Icon(
                Icons.add_shopping_cart_sharp,
                size: 30,
                color:cubit.cart[productModel.id]==null?Colors.black:cubit.cart[productModel.id]?Colors.white:Colors.black,
              ),
              onPressed: () {
                cubit.changeMyCart(productModel.id);


              },
            ),
          ),
        ],
      ),
    );
  }

  Stack buildStackImage(Size size, ShopAppCubit cubit) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: size.height * .3,
          child: CarouselSlider(
            items: productModel.images
                .map(
                  (e) => CachedNetworkImage(
                    imageUrl: e,
                    placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                )
                .toList(),
            options: CarouselOptions(
                autoPlayAnimationDuration: Duration(seconds: 1),
                autoPlayInterval: Duration(seconds: 3),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
                viewportFraction: 1.0,
                height: size.height * .25,
                enlargeCenterPage: true,
                onPageChanged: (int i, k) {
                  cubit.changeCurrentIndexImage(i);
                }),
          ),
        ),
      ],
    );
  }

  Padding buildName() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Text(
        productModel.name,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
    );
  }

  Container buildContainer(int num, context) {
    return Container(
      height: 10,
      width: 10,
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: ShopAppCubit.get(context).currentIndexImage == num
            ? Colors.blue
            : Colors.grey,
      ),
    );
  }
}
