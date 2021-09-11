import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_abdalla/layout/cubit/cubit.dart';
import 'package:e_commerce_abdalla/model/getFavorite/getFavorite.dart';
import 'package:e_commerce_abdalla/modules/login/LoginScreen.dart';
import 'package:e_commerce_abdalla/shared/constants/constats.dart';
import 'package:e_commerce_abdalla/shared/network/local/cashHelper.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:e_commerce_abdalla/modules/search/cubit/cubit.dart';

void navigateTo(context, widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

void navigateToToFinish(context, widget) {
  Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => widget), (route) => false);
}

Widget defaultFormTextField({
  @required TextEditingController controller,
  @required Function valid,
  @required String label,
  @required IconData prefix,
  Function onChange,
  Function onSubmit,
  Function suffixFunction,
  bool isPassword = false,
  IconData suffix,
}) {
  return TextFormField(
    controller: controller,
    validator: valid,
    obscureText: isPassword,
    onChanged: onChange,
    onFieldSubmitted: onSubmit,
    decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      labelText: label,
      prefixIcon: Icon(prefix),
      suffixIcon: suffix != null
          ? IconButton(
              icon: Icon(suffix),
              onPressed: suffixFunction,
            )
          : null,
      // focusedBorder: OutlineInputBorder(
      //   borderRadius: BorderRadius.circular(20),
      // ),
      //   enabledBorder: OutlineInputBorder(
      //   borderRadius: BorderRadius.circular(15),
      //
      // ),
    ),
  );
}

Widget defaultButton({
  double width =double.infinity,
  Color color=Colors.blue,
  double height= 50,
  double radius=3.0,
  @required Function function,
  @required String text,
}){
  return Container(
    width: width,
    height: height,
    child: ElevatedButton(
      onPressed: function,
      child: Text(text,),
      style: TextButton.styleFrom(
         shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(radius) ),
      ),
    ),
  );
}

Widget defaultTextButton({
  @required Function function,
  @required String text,
}){
  return TextButton(onPressed: function, child: Text(text));
}

void showToast({@required String text,@required state, int length})=>  Fluttertoast.showToast(
  msg: text,
  toastLength: length==null? Toast.LENGTH_LONG:Toast.LENGTH_SHORT,
  gravity: length==null?ToastGravity.BOTTOM:ToastGravity.TOP,
  timeInSecForIosWeb: 5,
  backgroundColor: whatColor(state),
  textColor: Colors.white,
  fontSize: 16.0,

);

enum TypeOfToast{Success,Error,Warning}

Color whatColor(TypeOfToast state){
  Color color;
  switch (state){
    case TypeOfToast.Success:
       color=Colors.green;
           break;
    case TypeOfToast.Error:
      color=Colors.red;
      break;
    case TypeOfToast.Warning:
      color=Colors.amber;
      break;
  }

  return color;
}

Widget SignOut(context)=>TextButton(
  onPressed: (){
    CashHelper.removeData(key: 'token').then((value){
      navigateToToFinish(context, LoginScreen());
    });
  },
  child: Text('Sign Out'),
);

Container builtFavoriteItem(Size size, Product model, context) {
  return Container(
    padding: EdgeInsets.only(right: 8),
    width: double.infinity,
    height: 120,
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
    child: Row(
      children: [
        Container(
          width: 120,
          height: 100,
          child: Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              CachedNetworkImage(
                imageUrl: model.image,
                placeholder: (context, url) =>
                    Center(child: CircularProgressIndicator()),
                height: 120,
                width: 120,
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
                    width: size.width * 0.1,
                    height: size.height * 0.02,
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
        ),
        SizedBox(
          width: 5,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20,),
              Text(
                model.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: size.height * .009,
              ),
              Spacer(),
              Row(
                children: [
                  Text(
                    '${model.price.round()}',
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        ShopAppCubit.get(context)
                            .changeFavoriteItem(model.id);
                      },
                      padding: EdgeInsets.zero,
                      iconSize: 30,
                      color: Colors.red,
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
