class HomeModel{
  bool status;
  HomeDataModel data;

  HomeModel.fromJson(Map<String,dynamic> json){
    status=json['status'];
    data=HomeDataModel.fromjson(json['data']);
  }
}


class HomeDataModel{
  List<BannerModel> banners=[
    BannerModel('https://k.nooncdn.com/cms/pages/20210815/36e72c3baf15379e0da770e2b9c4bb42/en_banner-01.gif'),
    BannerModel('https://k.nooncdn.com/cms/pages/20210906/946c88595ca48d216b1ca840616a4ac6/en_banner-01.gif'),
    BannerModel('https://k.nooncdn.com/cms/pages/20210902/c0755c4643dbe290806893fb41a16b75/en_banner-01.png'),
  ];
  List<ProductModel> products=[];

  HomeDataModel.fromjson(Map<String,dynamic> json){


    // json['banners'].forEach((element){
    //   banners.add(BannerModel.fromJson(element));
    // });

    json['products'].forEach((element){

       products.add(ProductModel.fromJson(element));
    });

  }

}

class BannerModel{
  int id;
  String image;
  BannerModel(this.image);
   BannerModel.fromJson(Map<String,dynamic> json){
     id=json['id'];
     image=json['image'];
   }
}

class ProductModel{
  int id;
  dynamic oldPrice;
  dynamic price;
  dynamic discount;
  String image;
  String name;
  bool inFavorite;
  bool inCart;
  String description;
  List<dynamic> images=[];
  ProductModel.fromJson(Map<String,dynamic> json){
    id=json['id'];
    oldPrice=json['old_price'];
    name=json['name'];
    price=json['price'];
    discount=json['discount'];
    image=json['image'];
    inFavorite=json['in_favorites'];
    inCart=json['in_cart'];
    description=json['description'];
    images=json['images'];



  }
}