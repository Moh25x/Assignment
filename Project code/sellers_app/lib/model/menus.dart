import 'package:cloud_firestore/cloud_firestore.dart';

class Menus{

  String? menuID;
  String? sellerUID;
  String? menuTitle;
  String? menuInfo;
  Timestamp? publishedData;
  String? thumbnailUrl;
  String? status;

  Menus(
      {this.menuID,
      this.sellerUID,
      this.menuTitle,
      this.menuInfo,
      this.publishedData,
      this.thumbnailUrl,
      this.status});

  Menus.fromJson(Map<String,dynamic> json){
    menuID=json["menuID"];
    sellerUID=json['sellerUID'];
    menuTitle=json['menuTitle'];
    menuInfo=json['menuInfo'];
    publishedData=json['publishedData'];
    thumbnailUrl=json['thumbnailUrl'];
    status=json['status'];
  }

  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data=Map<String,dynamic>();
    data["menuID"]=menuID;
    data['sellerUID']=sellerUID;
    data['menuTitle']=menuTitle;
    data['menuInfo']=menuInfo;
    data['publishedData']=publishedData;
    data['thumbnailUrl']=thumbnailUrl;
    data['status']=status;

    return data;
  }
}