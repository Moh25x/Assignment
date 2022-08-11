import 'package:flutter/material.dart';
import '../mainScreen/items_screen.dart';
import '../mainScreen2/item_detail_screen.dart';
import '../model2/items.dart';

class ItemsDesignWidget extends StatefulWidget {
  Items? model;
  BuildContext? context;

  ItemsDesignWidget({
    this.model,this.context,
  });
  @override
  _ItemsDesignWidgetState createState() => _ItemsDesignWidgetState();
}

class _ItemsDesignWidgetState extends State<ItemsDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (c)=>ItemDetailsScreen(model:widget.model)));
      },
      splashColor: Colors.green,
      child: Padding(padding: EdgeInsets.symmetric(horizontal: 70,vertical: 5),
        child: Container(
          height: 285,
          width: MediaQuery.of(context).size.width,
          child: Column(

            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20), // Image border
                child: SizedBox.fromSize(
                  size: Size.fromRadius(100), // Image radius
                  child: Image.network(widget.model!.thumbnailUrl!,
                    height: 220,
                    fit: BoxFit.cover,),
                ),
              ),

              Text(widget.model!.title!,
                style: const TextStyle(
                    color: Colors.green,
                    fontSize: 18,
                    fontFamily: "Hacen"
                ),
              ),
              const SizedBox(height: 2,),
              Text(widget.model!.shortInfo!,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),),
              const SizedBox(height: 5,),
              Divider(
                height: 4,
                thickness: 3,
                color: Colors.green,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
