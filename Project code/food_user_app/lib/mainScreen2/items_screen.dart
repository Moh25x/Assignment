import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';


import '../globlal/global.dart';
import '../model2/items.dart';
import '../model2/menus.dart';
import '../uploadscreens/items_upload_screen.dart';
import '../uploadscreens/menus_upload_screen.dart';
import '../widgets/progres_bar.dart';
import '../widgets2/items_design.dart';
import '../widgets2/my_drawer.dart';
import '../widgets2/text_widget_header.dart';

class ItemsScreen extends StatefulWidget {
  final Menus? model;
  ItemsScreen({this.model});

  @override
  _ItemsScreenState createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
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
        title: Text(sharedPreferences!.getString("name")!,
          style: TextStyle(
              fontSize: 30,
              fontFamily: "Hacen"
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: const Icon(Icons.library_add),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (c)=> ItemsUploadScreen(model: widget.model)));
          },
        ),

      ),
      endDrawer: MyDrawer(),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
              delegate: TextWidgetHeader(title: widget.model!.menuTitle.toString()+" قائمة"),
          pinned: true,),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("sellers")
                .doc(sharedPreferences!.getString("uid"))
                .collection("menus")
                .doc(widget.model!.menuID)
                .collection("items")
                .orderBy("publishedDate",descending: true)
                .snapshots(),
            builder: (context,snapshot){
              return !snapshot.hasData ?SliverToBoxAdapter(
                child: Center(child: circularProgress(),) ,
              ):SliverStaggeredGrid.countBuilder(
                crossAxisCount: 1,
                staggeredTileBuilder: (c)=>StaggeredTile.fit(1),
                itemBuilder: (context,index){
                  Items model=Items.fromJson(
                    snapshot.data!.docs[index].data()! as Map<String,dynamic>,
                  );
                  return ItemsDesignWidget(
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
