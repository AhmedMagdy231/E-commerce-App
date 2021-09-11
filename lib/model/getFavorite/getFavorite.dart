class FavoriteModel{
  bool status;
  DataModel data;
  FavoriteModel.fromJson(Map<String,dynamic> json){
    status=json['status'];
    data=DataModel.fromJson(json['data']);

  }
}

class DataModel{
  int current_page;
  List<FavoriteData> data=[];
  DataModel.fromJson(Map<String,dynamic> json){
    current_page=json['current_page'];
    json['data'].forEach((element){
      data.add(FavoriteData.fromJson(element));

    });

  }
}

class FavoriteData{
  int id;
  Product product;
  FavoriteData.fromJson(Map<String,dynamic> json){
    id=json['id'];
    product=Product.fromJson(json['product']);
  }


}

class Product{

  int id;
  dynamic oldPrice;
  dynamic price;
  dynamic discount;
  String image;
  String name;
  String description;
  List<dynamic> images=[];

  Product.fromJson(Map<String,dynamic> json){
    id=json['id'];
    oldPrice=json['old_price'];
    name=json['name'];
    price=json['price'];
    discount=json['discount'];
    image=json['image'];
    description=json['description'];
    images=json['images'];
  }

}