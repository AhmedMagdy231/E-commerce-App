import 'package:conditional_builder/conditional_builder.dart';
import 'package:e_commerce_abdalla/layout/cubit/cubit.dart';
import 'package:e_commerce_abdalla/layout/shop_layout.dart';
import 'package:e_commerce_abdalla/model/user.dart';
import 'package:e_commerce_abdalla/modules/login/cubit/cubit.dart';
import 'package:e_commerce_abdalla/modules/login/cubit/states.dart';
import 'package:e_commerce_abdalla/modules/register/register.dart';
import 'package:e_commerce_abdalla/shared/component/component.dart';
import 'package:e_commerce_abdalla/shared/constants/constats.dart';
import 'package:e_commerce_abdalla/shared/network/local/cashHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<LoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if(state is ShopSuccessState){
            if(state.userModel.status){
              showToast(text: state.userModel.message,state: TypeOfToast.Success);
              kToken=state.userModel.data.token;
              print(state.userModel.data.email);
              ShopAppCubit.get(context).changeCurrentIndex(0);
              ShopAppCubit.get(context).getHomeData();
              ShopAppCubit.get(context).getProfileData();
              ShopAppCubit.get(context).getFavorite();
              CashHelper.putData(key: 'token', value: state.userModel.data.token).then((value){
                navigateToToFinish(context, ShopHomeLayout());
              });



            }else{
              showToast(text: state.userModel.message,state: TypeOfToast.Error);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: Theme.of(context).textTheme.headline4.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          'Login now to brows our hot offers',
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultFormTextField(
                            controller: emailController,
                            valid: (String value) {
                              if (value.isEmpty) {
                                return 'Please Enter Your Email';
                              }
                            },
                            label: 'Email',
                            prefix: Icons.email),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormTextField(
                          controller: passwordController,
                          valid: (String value) {
                            if (value.isEmpty) {
                              return 'Please Enter Your Password';
                            }
                          },
                          label: 'Password',
                          prefix: Icons.lock_outline,
                          isPassword: !LoginCubit.get(context).isShown,
                          suffix: LoginCubit.get(context).suffixIcon,
                          suffixFunction: (){
                            LoginCubit.get(context).changeShown();
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopLoadingState,
                          builder: (context) => defaultButton(
                              function: () {
                                if(formKey.currentState.validate()){
                                  LoginCubit.get(context).userLogin(emailController.text, passwordController.text);
                                }
                              },
                              text: 'LOGIN',
                              radius: 15),
                          fallback: (context) => Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t have an account?'),
                            defaultTextButton(
                                function: () {
                                  navigateTo(context, RegisterScreen());
                                },
                                text: 'REGISTER'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },

    );
  }
}
