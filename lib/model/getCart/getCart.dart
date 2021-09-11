import 'package:e_commerce_abdalla/model/home_model/home_model.dart';

class GetCart{

  bool status;
  DataModel data;
  GetCart.fromJson(Map<String ,dynamic>  json){
    status=json['status'];
    data=DataModel.fromJson(json['data']);

  }

}


class DataModel{
  List<ProductModel> data=[];
  dynamic subTotal;
  dynamic total;
  DataModel.fromJson(Map<String,dynamic> json){
     json['cart_items'].forEach((element){
       data.add(ProductModel.fromJson(element['product']));
     });
     subTotal=json['sub_total'];
     total=json['total'];

  }
}

