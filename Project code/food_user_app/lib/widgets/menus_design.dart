import 'package:flutter/material.dart';
import 'package:food_user_app/mainScreen/items_screen.dart';
import 'package:food_user_app/models/menus.dart';
import 'package:food_user_app/models/sellers.dart';
class MenusDesignWidget extends StatefulWidget {
  Menus? model;

  BuildContext? context;

  MenusDesignWidget({
    this.model,this.context,
  });
  @override
  _MenusDesignWidgetState createState() => _MenusDesignWidgetState();
}

class _MenusDesignWidgetState extends State<MenusDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (c)=>ItemsScreen(model:widget.model)));
      },
      splashColor: Colors.green,
      child:  Padding(padding: EdgeInsets.symmetric(horizontal: 70),
        child: Container(
          height: 300,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
            SizedBox(height: 10,),
              ClipRRect(
                borderRadius: BorderRadius.circular(20), // Image border
                child: SizedBox.fromSize(
                  size: Size.fromRadius(100), // Image radius
                  child:  Image.network(widget.model!.thumbnailUrl!,
                    height: 220,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 5,),
              Text(widget.model!.menuTitle!,
                style: const TextStyle(
                    color: Colors.green,
                    fontSize: 20,
                    fontFamily: "Hacen"
                ),),

              Text(widget.model!.menuInfo!,
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
