class Sellers{
  String? sellerName;
  String? sellerUID;
  String? sellerAvatarUrl;
  String? sellerEmail;

  Sellers(
      {this.sellerName,
      this.sellerUID,
      this.sellerAvatarUrl,
      this.sellerEmail});

  Sellers.fromJson(Map <String,dynamic> json){
    sellerUID=json["sellerUID"];
    sellerName=json["sellerName"];
    sellerAvatarUrl=json["sellerAvatarUrl"];
    sellerEmail=json["sellerEmail"];
  }
  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data=new Map<String,dynamic>();
    data["sellerUID"]=this.sellerUID;
    data["sellerName"]=this.sellerName;
    data["sellerAvatarUrl"]=this.sellerAvatarUrl;
    data["sellerEmail"]=this.sellerEmail;

    return data;
  }
}