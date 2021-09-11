import 'package:conditional_builder/conditional_builder.dart';
import 'package:e_commerce_abdalla/layout/shop_layout.dart';
import 'package:e_commerce_abdalla/modules/login/LoginScreen.dart';
import 'package:e_commerce_abdalla/modules/register/cubit/cubit.dart';
import 'package:e_commerce_abdalla/modules/register/cubit/states.dart';
import 'package:e_commerce_abdalla/shared/component/component.dart';
import 'package:e_commerce_abdalla/shared/constants/constats.dart';
import 'package:e_commerce_abdalla/shared/network/local/cashHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, ShopRegisterStates>(
      listener: (context, state) {
        if(state is ShopRegisterSuccessState){
          if(state.userModel.status){
            showToast(text: state.userModel.message,state: TypeOfToast.Success);
            kToken=state.userModel.data.token;
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
                        'Register',
                        style: Theme.of(context).textTheme.headline4.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Text(
                        'Register now to brows our hot offers',
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      defaultFormTextField(
                          controller: nameController,
                          valid: (String value) {
                            if (value.isEmpty) {
                              return 'Please Enter Your Name';
                            }
                          },
                          label: 'Name',
                          prefix: Icons.person),
                      SizedBox(
                        height: 15.0,
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
                        isPassword: !RegisterCubit.get(context).isShown,
                        suffix: RegisterCubit.get(context).suffixIcon,
                        suffixFunction: () {
                          RegisterCubit.get(context).changeShown();
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      defaultFormTextField(
                          controller: phoneController,
                          valid: (String value) {
                            if (value.isEmpty) {
                              return 'Please Enter Your phone';
                            }
                          },
                          label: 'Phone',
                          prefix: Icons.phone),
                      SizedBox(
                        height: 30,
                      ),
                      ConditionalBuilder(
                        condition: state is! ShopRegisterLoadingState,
                        builder: (context) => defaultButton(
                            function: () {
                              if (formKey.currentState.validate()) {
                                RegisterCubit.get(context).userRegister(
                                    emailController.text,
                                    passwordController.text,
                                    phoneController.text,
                                    nameController.text,
                                );
                              }
                            },
                            text: 'Register',
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
                          Text('Have an account already !!'),
                          defaultTextButton(
                              function: () {
                                navigateTo(context, LoginScreen());
                              },
                              text: 'Login'),
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
