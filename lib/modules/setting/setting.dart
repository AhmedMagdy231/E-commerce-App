import 'package:conditional_builder/conditional_builder.dart';
import 'package:e_commerce_abdalla/layout/cubit/cubit.dart';
import 'package:e_commerce_abdalla/layout/cubit/states.dart';
import 'package:e_commerce_abdalla/modules/login/LoginScreen.dart';
import 'package:e_commerce_abdalla/modules/register/cubit/states.dart';
import 'package:e_commerce_abdalla/shared/component/component.dart';
import 'package:e_commerce_abdalla/shared/network/local/cashHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context, state) {
        if(state is ShopUpdateProfileSuccessScreen){
          print(state.userModel.status);
          if(state.userModel.status){
            showToast(text: state.userModel.message, state: TypeOfToast.Success);
          }
        }
      },
      builder: (context, state) {
        var model = ShopAppCubit.get(context).shopLoginModel;
        if(model!=null){
          nameController.text = model.data.name;
          emailController.text = model.data.email;
          phoneController.text = model.data.phone;
        }


        return ConditionalBuilder(
            condition: ShopAppCubit.get(context).shopLoginModel != null,
            builder: (context) => Padding(
                  padding: const EdgeInsets.all(20),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Form(
                        key: formKey,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if(state is ShopUpdateProfileLoadingScreen)
                              LinearProgressIndicator(),
                              SizedBox(height: 20,),
                              defaultFormTextField(
                                  controller: nameController,
                                  valid: (String value) {
                                    if(value.isEmpty){
                                      return 'Please Enter Your Name';
                                    }
                                  },
                                  label: 'Name',
                                  prefix: Icons.person),
                              SizedBox(
                                height: 20,
                              ),
                              defaultFormTextField(
                                  controller: emailController,
                                  valid: (String value) {
                                    if(value.isEmpty){
                                      return 'Please Enter Your Email';
                                    }
                                  },
                                  label: 'Email',
                                  prefix: Icons.email),
                              SizedBox(
                                height: 20,
                              ),
                              defaultFormTextField(
                                  controller: phoneController,
                                  valid: (String value) {
                                    if(value.isEmpty){
                                      return 'Please Enter Your Phone';
                                    }
                                  },
                                  label: 'Phone',
                                  prefix: Icons.phone),
                              SizedBox(height: 20,),
                              defaultButton(function: (){
                                if(formKey.currentState.validate()){
                                  ShopAppCubit.get(context).updateProfileData(nameController.text, phoneController.text, emailController.text);
                                }

                              }, text: 'Update',radius: 20),
                              SizedBox(height: 20,),
                              defaultButton(function: (){
                                CashHelper.removeData(key: 'token').then((value){
                                  navigateToToFinish(context, LoginScreen());
                                });

                              }, text: 'SIGN OUT',radius: 20),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
           fallback: (context)=>Center(child: CircularProgressIndicator(),),
        );
      },
    );
  }
}
