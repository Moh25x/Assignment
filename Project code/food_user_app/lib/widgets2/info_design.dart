import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


import '../globlal/global.dart';
import '../mainScreen2/items_screen.dart';
import '../model2/menus.dart';

class InfoDesignWidget extends StatefulWidget {
  Menus? model;
  BuildContext? context;

  InfoDesignWidget({
    this.model,this.context,
});
  @override
  _InfoDesignWidgetState createState() => _InfoDesignWidgetState();
}

class _InfoDesignWidgetState extends State<InfoDesignWidget> {

  deleteMenu(String menuID)
  {
    FirebaseFirestore.instance.collection("sellers")
        .doc(sharedPreferences!.getString("uid"))
        .collection("menus")
        .doc(menuID)
        .delete();

    Fluttertoast.showToast(msg: "Menu Deleted Successfully.");
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (c)=>ItemsScreen(model:widget.model)));
      },
      splashColor: Colors.green,
      child: Padding(padding: EdgeInsets.symmetric(horizontal: 70,vertical: 5),
      child: Container(
        height: 280,
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

          SizedBox(height: 4,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.model!.menuTitle!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                color: Colors.green,
                fontSize: 20,
                fontFamily: "Hacen"
              ),),

              IconButton(
                onPressed: (){
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('تأكيد عملية الحذف',textAlign: TextAlign.end),
                        content: Text('هل تريد التأكيد على حذف القائمة؟',textAlign: TextAlign.end),
                        actions: <Widget>[
                          TextButton(
                              onPressed: () {
                                //action code for "Yes" button
                                deleteMenu(widget.model!.menuID!);
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
                icon:
              const Icon(
                Icons.delete_sweep,
                color: Colors.redAccent,),)
            ],
          ),
          // Text(widget.model!.menuInfo!,
          //   style: const TextStyle(
          //       color: Colors.grey,
          //       fontSize: 12,
          //     ),),
          Divider(thickness: 3,color: Colors.green,),
          SizedBox(height: 10,),
        ],
      ),
      ),
      ),
    );
  }
}
