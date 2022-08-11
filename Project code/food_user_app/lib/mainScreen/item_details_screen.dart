import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_user_app/models/items.dart';
import 'package:food_user_app/widgets/app_bar.dart';
import 'package:number_inc_dec/number_inc_dec.dart';

import '../assistantMethods/assistanse_Mathods.dart';

class ItemDetailsScreen extends StatefulWidget {
 final Items? model;

 ItemDetailsScreen({this.model});
  @override
  _ItemDetailsScreenState createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  TextEditingController counterTextEditingController=TextEditingController();




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(sellerUID:widget.model!.sellerUID),
      body:Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20)), // Image border
              child: SizedBox.fromSize(
                child: Image.network(widget.model!.thumbnailUrl.toString(),
                  height: 220,
                  width: 450,
                  fit: BoxFit.cover,),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: NumberInputPrefabbed.roundedButtons(
                controller: counterTextEditingController,
              incDecBgColor: Colors.green,
                min: 1,
                max: 9,
                initialValue: 1,
                buttonArrangement: ButtonArrangement.incRightDecLeft,
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.model!.title.toString(),
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.model!.longDescription.toString(),
                textAlign: TextAlign.justify,
                style: TextStyle(fontWeight: FontWeight.normal,fontSize: 14),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "₪ "+widget.model!.price.toString(),
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
              ),
            ),
            const SizedBox(height: 10,),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child:

              Center(
                child: ElevatedButton(
                  onPressed: (){
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('تأكيد عملية الإضافة',textAlign: TextAlign.end),
                            content: Text('هل تريد تأكيد عملية الإضافة؟',textAlign: TextAlign.end),
                            actions: <Widget>[
                              TextButton(
                                  onPressed: () {
                                    //action code for "Yes" button
                                    int itemCounter=int.parse(counterTextEditingController.text);

                                    //1. check if item exist already in cart
                                    List<String> separateItemIdList=separateItemIDs();
                                    separateItemIdList.contains(widget.model!.itemID)
                                        ?Fluttertoast.showToast(msg: "المنتج موجود بالفعل")
                                        :
                                    //add to cart
                                    addItemToCart(widget.model!.itemID, context, itemCounter);
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
                  child: const Text("اضافة المنتج الى السلة",style: TextStyle(
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


            ),
          ],

        ),
      ) ,
    );
  }
}
