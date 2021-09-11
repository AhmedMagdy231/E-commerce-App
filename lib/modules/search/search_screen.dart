import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_abdalla/layout/cubit/cubit.dart';
import 'package:e_commerce_abdalla/model/search/search_model.dart';
import 'package:e_commerce_abdalla/modules/search/cubit/cubit.dart';
import 'package:e_commerce_abdalla/modules/search/cubit/states.dart';
import 'package:e_commerce_abdalla/shared/component/component.dart';
import 'package:e_commerce_abdalla/shared/constants/constats.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchCubit, SearchStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit=SearchCubit.get(context);
        Size size = MediaQuery.of(context).size;
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                defaultFormTextField(
                    controller: searchController,
                    valid: (String value) {},
                    label: 'Search',
                    onChange: (String value){
                      SearchCubit.get(context).getSearch(searchController.text);

                    },
                    prefix: Icons.search),
                SizedBox(height: 10,),
                if(state is SearchLoadingState)
                  LinearProgressIndicator(),
                if(state is SearchSuccessStates)
                Expanded(child: ListView.separated(
                    itemBuilder: (context,index)=>builtFavoriteItemmm(size,cubit.searchModel.data.data[index],context),
                    separatorBuilder: (context,index)=>SizedBox(
                      height: 10,
                      child: Divider(
                        thickness: 2,
                      ),
                    ),
                    itemCount: cubit.searchModel.data.data.length,
                ),
                ),

              ],
            ),
          ),
        );
      },
    );
  }

  Container builtFavoriteItemmm(Size size, Product model, context) {
    return Container(
      width: double.infinity,
      height: 100,
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
              ],
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
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

                    Spacer(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
