import 'package:e_commerce_abdalla/model/home_model/home_model.dart';

class GetCategoriesModel{
  bool status;
  DataModele data;
  GetCategoriesModel.fromJson(Map<String,dynamic> json){
    status=json['status'];
    data=DataModele.fromJson(json['data']);

  }
}

class DataModele{
  int current_page;
  List<ProductModel> data=[];
  DataModele.fromJson(Map<String,dynamic> json){
    current_page=json['current_page'];
    json['data'].forEach((element){
      data.add(ProductModel.fromJson(element));

    });
  }
}

// class Product{
//
//   int id;
//   dynamic oldPrice;
//   dynamic price;
//   dynamic discount;
//   String image;
//   String name;
//   String description;
//   List<dynamic> images=[];
//
//   Product.fromJson(Map<String,dynamic> json){
//     id=json['id'];
//     oldPrice=json['old_price'];
//     name=json['name'];
//     price=json['price'];
//     discount=json['discount'];
//     image=json['image'];
//     description=json['description'];
//     images=json['images'];
//
//   }
//
// }