import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../assistantMethods/assistanse_Mathods.dart';
import '../assistantMethods/cart_Item_counter.dart';
import '../assistantMethods/total_amount.dart';
import '../models/items.dart';
import '../splachScreen/splash_screen.dart';
import '../widgets/cart_item_design.dart';
import '../widgets/progres_bar.dart';
import '../widgets/text_widget_header.dart';
import 'address_screen.dart';


class CartScreen extends StatefulWidget
{
  final String? sellerUID;

  CartScreen({this.sellerUID});

  @override
  _CartScreenState createState() => _CartScreenState();
}




class _CartScreenState extends State<CartScreen>
{
  List<int>? separateItemQuantityList;
  num totalAmount = 0;

  @override
  void initState() {
    super.initState();

    totalAmount = 0;
    Provider.of<TotalAmount>(context, listen: false).displayTotalAmount(0);

    separateItemQuantityList = separateItemQuantities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.green,
                  Colors.green,
                ],
                begin:  FractionalOffset(0.0, 0.0),
                end:  FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp,
              )
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.clear_all),
          onPressed: ()
          {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('تأكيد عملية حذف سلة المشتريات',textAlign: TextAlign.end),
                    content: Text('هل تريد تأكيد عملية الحذف؟',textAlign: TextAlign.end),
                    actions: <Widget>[
                      TextButton(
                          onPressed: () {
                            //action code for "Yes" button
                            clearCartNow(context);
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
        ),
        title: const Text(
          "مشتريات",
          style: TextStyle(fontSize: 45, fontFamily: "Signatra"),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart, color: Colors.white,),
                onPressed: ()
                {
                  print("clicked");
                },
              ),

            ],
          ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const SizedBox(width: 10,),
          Align(
            alignment: Alignment.bottomLeft,
            child: FloatingActionButton.extended(
              heroTag: "btn1",
              label: const Text("مسح القائمة", style: TextStyle(fontSize: 16),),
              backgroundColor: Colors.red,
              icon: const Icon(Icons.clear_all),
              onPressed: ()
              {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('تأكيد عملية حذف سلة المشتريات',textAlign: TextAlign.end),
                        content: Text('هل تريد تأكيد عملية الحذف؟',textAlign: TextAlign.end),
                        actions: <Widget>[
                          TextButton(
                              onPressed: () {
                                //action code for "Yes" button
                                clearCartNow(context);
                                Navigator.pop(context);
                                Navigator.push(context, MaterialPageRoute(builder: (c)=> const MySplashScreen()));
                                Fluttertoast.showToast(msg: "تم تنظيف سلة المشتريات");

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
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: FloatingActionButton.extended(
              heroTag: "btn2",
              label: const Text("ادفع الان", style: TextStyle(
                  fontSize: 16),
              textAlign: TextAlign.center,
              ),
              backgroundColor: Colors.green,
              icon: const Icon(Icons.navigate_next),
              onPressed: ()
              {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (c)=> AddressScreen(
                          totalAmount: totalAmount.toDouble(),
                          sellerUID: widget.sellerUID,
                        ),
                    ),
                );
              },
            ),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          
          //overall total amount
          SliverPersistentHeader(
              pinned: true,
              delegate: TextWidgetHeader(title: "قائمة مشترياتي")
          ),

          SliverToBoxAdapter(
            child: Consumer2<TotalAmount, CartItemCounter>(builder: (context, amountProvider, cartProvider, c)
            {
              return Padding(
                padding: const EdgeInsets.all(8),
                child: Center(
                  child: cartProvider.count == 0
                      ? Container()
                      : Text(
                          "السعر الاجمالي : " + amountProvider.tAmount.toString(),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight:  FontWeight.w500,
                            ),
                        ),
                ),
              );
            }),
          ),
          
          //display cart items with quantity number
         new StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("items")
                .where("itemID", whereIn: separateItemIDs())
                .orderBy("publishedDate", descending: true)
                .snapshots(),
            builder: (context, snapshot)
            {
              return !snapshot.hasData
                  ? SliverToBoxAdapter(child: Center(child: circularProgress(),),)
                  : snapshot.data!.docs.length == 0
                  ? //startBuildingCart()
                     new Container()
                  : SliverList(
                    delegate: SliverChildBuilderDelegate((context, index)
                    {
                      Items model = Items.fromJson(
                        snapshot.data!.docs[index].data()! as Map<String, dynamic>,
                      );

                      if(index == 0)
                      {
                        totalAmount = 0;
                        totalAmount = totalAmount + (model.price! * separateItemQuantityList![index]);
                      }
                      else
                      {
                        totalAmount = totalAmount + (model.price! * separateItemQuantityList![index]);
                      }

                      if(snapshot.data!.docs.length - 1 == index)
                      {
                        WidgetsBinding.instance!.addPostFrameCallback((timeStamp)
                        {
                          Provider.of<TotalAmount>(context, listen: false).displayTotalAmount(totalAmount.toDouble());
                        });
                      }

                      return CartItemDesign(
                        model: model,
                        context: context,
                        quanNumber: separateItemQuantityList![index],
                      );
                    },
                    childCount: snapshot.hasData ? snapshot.data!.docs.length : 0,
                  ),
                 );
            },
          ),
        ],
      ),
    );
  }
}
