import 'package:flutter/material.dart';
import 'package:food_user_app/assistantMethods/cart_Item_counter.dart';
import 'package:food_user_app/mainScreen/cart_screen.dart';
import 'package:provider/provider.dart';

class MyAppBar extends StatefulWidget with PreferredSizeWidget{
  final PreferredSizeWidget? bottom;
  final String? sellerUID;
  MyAppBar({this.bottom,this.sellerUID});
  @override
  _MyAppBarState createState() => _MyAppBarState();

  @override
  Size get preferredSize => bottom==null
      ?Size(56, AppBar().preferredSize.height)
      :Size(56,80+AppBar().preferredSize.height);
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.green,
              Colors.green,
            ],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(1.0, 0.0),
            stops: [0.0,1.0],
            tileMode: TileMode.clamp,
          ),
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.ac_unit),
        onPressed: (){
          Navigator.pop(context);
        },
      ),
      title: const Text(
        "اطلب",
        style: TextStyle(
            fontSize: 30,
            fontFamily: "Hacen"
        ),
      ),
      centerTitle: true,
      automaticallyImplyLeading: true,
      actions:[
        Stack(
          children: [
            IconButton(
              icon:  Icon(Icons.shopping_cart),
              onPressed: (){
                   Navigator.push(context, MaterialPageRoute(builder: (c)=> CartScreen(sellerUID: widget.sellerUID,)));
                //send the user for cart screen
              },
            ),

          ],
        ),
      ],
    );
  }
}
