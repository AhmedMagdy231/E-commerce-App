class ChangeCart{
  bool status;
  String message;
  ChangeCart.fromJson(Map<String,dynamic> json){
    status=json['status'];
    message=json['message'];
  }
}