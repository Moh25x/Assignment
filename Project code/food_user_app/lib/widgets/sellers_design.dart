import 'package:flutter/material.dart';
import 'package:food_user_app/mainScreen/menus_screen.dart';
import 'package:food_user_app/models/sellers.dart';
class SellersDesignWidget extends StatefulWidget {
  Sellers? model;

  BuildContext? context;

  SellersDesignWidget({
    this.model,this.context,
});
  @override
  _SellersDesignWidgetState createState() => _SellersDesignWidgetState();
}

class _SellersDesignWidgetState extends State<SellersDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (c)=>MenusScreen(model:widget.model)));
      },
      splashColor: Colors.green,
      child: Padding(padding: EdgeInsets.symmetric(horizontal: 70,vertical: 5),
      child: Container(
        height: 300,
        width: MediaQuery.of(context).size.width,
      //  width: 100,
      child: Column(
        children: [

          ClipRRect(
            borderRadius: BorderRadius.circular(20), // Image border
            child: SizedBox.fromSize(
              size: Size.fromRadius(100), // Image radius
              child: Image.network(widget.model!.sellerAvatarUrl!,
                height: 220,
                fit: BoxFit.cover,),
            ),
          ),
          SizedBox(height: 5,),
          Text(widget.model!.sellerName!,
            style: const TextStyle(
            color: Colors.green,
            fontSize: 20,
            fontFamily: "Hacen"
          ),),

          Text(widget.model!.sellerName!,
            style: const TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),),
          Divider(thickness: 3,color: Colors.green,),
          SizedBox(height: 10,),
        ],
      ),
      ),
      ),
    );
  }
}
