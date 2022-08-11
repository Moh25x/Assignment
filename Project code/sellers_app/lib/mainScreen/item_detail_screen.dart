import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../globlal/global.dart';
import '../model/items.dart';
import '../splachScreen/splash_screen.dart';
import '../widgets/simple_app_bar.dart';


class ItemDetailsScreen extends StatefulWidget
{
  final Items? model;
  ItemDetailsScreen({this.model});

  @override
  _ItemDetailsScreenState createState() => _ItemDetailsScreenState();
}




class _ItemDetailsScreenState extends State<ItemDetailsScreen>
{
  TextEditingController counterTextEditingController = TextEditingController();


  deleteItem(String itemID)
  {
    FirebaseFirestore.instance
        .collection("sellers")
        .doc(sharedPreferences!.getString("uid"))
        .collection("menus")
        .doc(widget.model!.menuID!)
        .collection("items")
        .doc(itemID)
        .delete().then((value)
    {
      FirebaseFirestore.instance
          .collection("items")
          .doc(itemID)
          .delete();

      Navigator.push(context, MaterialPageRoute(builder: (c)=> const MySplashScreen()));
      Fluttertoast.showToast(msg: "تم حذف المنتج بنجاح.");
    });
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: SimpleAppBar(title: sharedPreferences!.getString("name"),),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20)), // Image border
            child: SizedBox.fromSize(
              child: Image.network(widget.model!.thumbnailUrl.toString(),
                height: 250,
                width: 400,
                fit: BoxFit.fill,),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.model!.title.toString(),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.model!.longDescription.toString(),
              textAlign: TextAlign.justify,
              style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(

               "₪ "+widget.model!.price.toString(),

              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
          ),

          const SizedBox(height: 15,),
  Center(
    child: ElevatedButton(
    onPressed: (){
    showDialog(
    context: context,
    builder: (context) {
    return AlertDialog(
    title: Text('تأكيد عملية حذف المنتج',textAlign: TextAlign.end),
    content: Text('هل تريد تأكيد عملية الحذف؟',textAlign: TextAlign.end),
    actions: <Widget>[
    TextButton(
    onPressed: () {
    //action code for "Yes" button
    deleteItem(widget.model!.itemID!);
    Navigator.pop(context);
    },
    child: Text('نعم' ,textAlign: TextAlign.end,style: TextStyle(color: Colors.green),)),
    TextButton(
    onPressed: () {
    Navigator.pop(context); //close Dialog
    },
    child: Text('لا',textAlign: TextAlign.end ,style: TextStyle(color: Colors.red),),

    )
    ],
    );
    });
    },
    child: const Text("حذف المنتج",style: TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 18,
    ),
    ),
    style: ElevatedButton.styleFrom(
    primary: Colors.green,
    elevation: 5.0,
    padding: const EdgeInsets.symmetric(horizontal: 80,vertical: 5)
    ),
    ),
  ),


  // Text(
                  //   "حذف المنتج",
                  //   style: TextStyle(color: Colors.white, fontSize: 15),
                  // )

        ],
      ),
    );
  }
}
