
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_user_app/splachScreen2/splash_screen2.dart';


import '../globlal/global.dart';
import '../model2/menus.dart';
import '../splachScreen/splash_screen.dart';
import '../uploadscreens/menus_upload_screen.dart';
import '../widgets/progres_bar.dart';
import '../widgets/text_widget_header.dart';
import '../widgets2/info_design.dart';
import '../widgets2/my_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    RestrictBlockedUserFromUsingApp();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: MyDrawer(),
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
          icon: const Icon(Icons.post_add),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (c)=>const MenusUploadScreen()));

          },
        ),
      ),
      body:CustomScrollView(
        slivers: [
          SliverPersistentHeader(
              pinned:true,
              delegate: TextWidgetHeader(title: "القائمة")),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("sellers")
                .doc(sharedPreferences!.getString("uid"))
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
                    return InfoDesignWidget(
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
  RestrictBlockedUserFromUsingApp() async{
    await FirebaseFirestore.instance
        .collection("sellers").doc(firebaseAuth.currentUser!.uid).get()
        .then((snapshot){
      if (snapshot.data()!["status"] != "approved") {
        Fluttertoast.showToast(msg: "تم تعطيل حسابك");
        firebaseAuth.signOut();
        Navigator.push(context, MaterialPageRoute(builder: (c)=>MySplashScreen2()));
      }
      else{

      }

    });

  }

}


