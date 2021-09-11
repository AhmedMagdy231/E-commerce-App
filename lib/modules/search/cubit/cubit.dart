import 'package:bloc/bloc.dart';
import 'package:e_commerce_abdalla/model/search/search_model.dart';
import 'package:e_commerce_abdalla/modules/search/cubit/states.dart';
import 'package:e_commerce_abdalla/shared/constants/constats.dart';
import 'package:e_commerce_abdalla/shared/network/end_point.dart';
import 'package:e_commerce_abdalla/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchStates>{
  SearchCubit():super(SearchInitialState());

  static SearchCubit get(context)=>BlocProvider.of(context);

SearchModel searchModel;
  void getSearch(String text){
    emit(SearchLoadingState());
      DioHelper.postData(url: SEARCH, data: {
        'text':text,
      },
      token: kToken,
      ).then((value){
        searchModel=SearchModel.fromJson(value.data);
        emit(SearchSuccessStates());
      }).catchError((error){
        print(error.toString());
        emit(SearchErrorStates());
      });
  }



}