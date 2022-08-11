import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:food_user_app/assistantMethods/assistanse_Mathods.dart';
import 'package:food_user_app/splachScreen/splash_screen.dart';
import 'package:food_user_app/widgets/menus_design.dart';
import '../models/menus.dart';
import '../models/sellers.dart';
import '../widgets/progres_bar.dart';
import '../widgets/text_widget_header.dart';

class MenusScreen extends StatefulWidget {
 final Sellers? model;
 MenusScreen({this.model});
  @override
  _MenusScreenState createState() => _MenusScreenState();
}

class _MenusScreenState extends State<MenusScreen> {
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
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(1.0, 0.0),
              stops: [0.0,1.0],
              tileMode: TileMode.clamp,
            ),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            clearCartNow(context);
            Navigator.push(context, MaterialPageRoute(builder: (c)=>MySplashScreen()));
          },
        ),
        title: const Text(
          "منتجات",
          style: TextStyle(
              fontSize: 30,
              fontFamily: "Hacen"
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
       ),
      body:CustomScrollView(
        slivers: [
          SliverPersistentHeader(
              pinned:true,
              delegate: TextWidgetHeader(title: widget.model!.sellerName.toString()+ " قائمة ")),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("sellers")
                .doc(widget.model!.sellerUID)
                .collection("menus")
                .orderBy("publishedDate",descending: true)
                .snapshots(),
            builder: (context,snapshot){
              return !snapshot.hasData ?SliverToBoxAdapter(
                child: Center(child: circularProgress(),) ,
              ):SliverStaggeredGrid.countBuilder(
                crossAxisCount: 1,
                staggeredTileBuilder: (c)=>StaggeredTile.fit(1),
                itemBuilder: (context,index){
                  Menus model=Menus.fromJson(
                    snapshot.data!.docs[index].data()! as Map<String,dynamic>,
                  );
                  return MenusDesignWidget(
                    model: model,
                    context: context,
                  );
                },
                itemCount: snapshot.data!.docs.length,
              );
            },
          ),
        ],
      ),
    );
  }
}
