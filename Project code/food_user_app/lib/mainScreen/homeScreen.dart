import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_user_app/assistantMethods/assistanse_Mathods.dart';
import 'package:food_user_app/authentication/login.dart';
import 'package:food_user_app/models/sellers.dart';
import 'package:food_user_app/splachScreen/splash_screen.dart';
import 'package:food_user_app/widgets/sellers_design.dart';
import 'package:food_user_app/widgets/my_drawer.dart';
import 'package:food_user_app/widgets/progres_bar.dart';

import '../globlal/global.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final items=[
    "slider/00.jpg",
    "slider/111.jpg",
    "slider/22.jpg",
    "slider/33.jpg",
    "slider/44.jpg",
    "slider/55.jpg",
    "slider/66.jpg",
    "slider/77.jpg",
  ];
  @override
  void initState() {
    super.initState();
    RestrictBlockedUserFromUsingApp();
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
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(1.0, 0.0),
              stops: [0.0,1.0],
              tileMode: TileMode.clamp,
            ),
          ),
        ),
        title: Text(sharedPreferences!.getString("name")!),
        centerTitle: true,
      ),
      endDrawer: MyDrawer(),


      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                height: MediaQuery.of(context).size.height*.222,
                width: MediaQuery.of(context).size.width,
                child: CarouselSlider(
                  items: items.map((index){
                         return Builder(builder: (BuildContext context){
                           return Container(
                             decoration: BoxDecoration(
                               image: DecorationImage(
                                 image: AssetImage(index),
                                 fit: BoxFit.fill,
                               ),
                               borderRadius: BorderRadius.all(Radius.circular(20))
                            //   color: Colors.black
                             ),
                             width:MediaQuery.of(context).size.width ,
                             margin: const EdgeInsets.symmetric(horizontal: 1.0),
                             child: Padding(

                                 padding: EdgeInsets.all(4),
                              // child: Image.asset(,fit: BoxFit.fill,),

                             ),
                           );
                         });
                  }).toList(),
                  options: CarouselOptions(
                    height: MediaQuery.of(context).size.height*.25,
                    aspectRatio: 16/9,
                    viewportFraction: 0.8,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 2),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.decelerate,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Scrollbar(
              child: Padding(
                padding:  EdgeInsets.all(10),
                child: MediaQuery(
                  data: MediaQuery.of(context).copyWith(
                  ),
                  child: Text(
                    "المتاجر المتاحة",
                    textAlign: TextAlign.right,

                    style: new TextStyle(
                      height: 1.5,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
    shadows: <Shadow>[
    Shadow(
    offset: Offset(1.0, 3.0),
    blurRadius: 10.0,
    color: Colors.green.shade600,
    ),
    ]

                      ),
                  ),
                ),
              ),
            ),
          ),


          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("sellers")
                .snapshots(),
            builder: (context,snapShot){
              return !snapShot.hasData
                  ? SliverToBoxAdapter(
                child: Center(child: circularProgress(),),
              ):SliverStaggeredGrid.countBuilder(
                  crossAxisCount: 1,
                  staggeredTileBuilder: (c)=>StaggeredTile.fit(1),
                  itemBuilder: (context,index){
                    Sellers sModel=Sellers.fromJson(
                        snapShot.data!.docs[index].data()! as Map<String,dynamic>);
                    //design for display sellers_cafes_shrkat

                    return SellersDesignWidget(
                      model: sModel,
                      context: context,
                    );

                  },
                  itemCount: snapShot.data!.docs.length);
            },
          ),
        ],
      ),
    );
  }

   RestrictBlockedUserFromUsingApp() async{
     await FirebaseFirestore.instance
         .collection("users").doc(firebaseAuth.currentUser!.uid).get()
         .then((snapshot){
       if (snapshot.data()!["status"] != "approved") {
         Fluttertoast.showToast(msg: "تم تعطيل حسابك");
         firebaseAuth.signOut();
         Navigator.push(context, MaterialPageRoute(builder: (c)=>MySplashScreen()));
       }
       else{
         clearCartNow(context);
       }

       });

   }
}
