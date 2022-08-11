import 'package:flutter/material.dart';
import 'package:food_user_app/globlal/global.dart';
import 'package:food_user_app/mainScreen/address_screen.dart';
import 'package:food_user_app/mainScreen/history_screen.dart';
import 'package:food_user_app/mainScreen/homeScreen.dart';
import 'package:food_user_app/mainScreen/my_orders_screen.dart';

import '../authentication/auth_screen.dart';
import '../mainScreen/search_screen.dart';
import '../mainScreen/welcome_screen.dart';

class MyDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(top: 25,bottom: 10),
            child: Column(
              children: [
                //header drawer
                Material(
                  borderRadius: BorderRadius.all(Radius.circular(80)),
                  elevation: 10,
                  child: Padding(
                    padding: EdgeInsets.all(1.0),
                    child: Container(
                      height: 160,
                      width: 160,
                      child:  CircleAvatar(
                        backgroundImage: NetworkImage(sharedPreferences!.getString("photoUrl")!
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10,),
                 Text(
                  sharedPreferences!.getString("name")!,
                   style: TextStyle(color: Colors.black,fontSize: 20),
                )
              ],
            ),
          ),
          const SizedBox(height: 12,),
          Container(
            padding: const EdgeInsets.only(top: 1),

            child: Column(
              children: [
                   const   Divider(
                        height: 10,
                        color: Colors.grey,
                        thickness: 2,
                      ),

                ListTile(
                  leading: Icon(Icons.home,color: Colors.black,),
                  title: Text("الصفحة الرئيسية",
                    textAlign: TextAlign.right,
                    style: TextStyle(color: Colors.black),),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (c)=>HomeScreen()));

                  },
                ),
                const   Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),
                ListTile(
                  leading: Icon(Icons.reorder,color: Colors.black,),
                  title: Text("الطلبات",
                    textAlign: TextAlign.right,
                    style: TextStyle(color: Colors.black),),
                  onTap: (){
                   Navigator.push(context, MaterialPageRoute(builder: (c)=>MyOrdersScreen()));
                  },
                ),
                const   Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),
                ListTile(
                  leading: Icon(Icons.access_time,color: Colors.black,),
                  title: Text("التأريخ",
                    textAlign: TextAlign.right,
                    style: TextStyle(color: Colors.black),),
                  onTap: (){
                   Navigator.push(context, MaterialPageRoute(builder: (c)=>HistoryScreen()));

                  },
                ),
                const   Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),
                ListTile(
                  leading: Icon(Icons.search,color: Colors.black,),
                  title: Text("بحث",
                    textAlign: TextAlign.right,
                    style: TextStyle(color: Colors.black),),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (c)=>SearchScreen()));

                  },
                ),
                const   Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),
                ListTile(
                  leading: Icon(Icons.add_location,color: Colors.black,),
                  title: Text("اضافة عنوان جديد",
                    textAlign: TextAlign.right,
                    style: TextStyle(color: Colors.black),),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (c)=>AddressScreen()));

                  },
                ),
                const   Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),
                ListTile(
                  leading: Icon(Icons.exit_to_app,color: Colors.black,),
                  title: Text("تسجيل خروج",
                    textAlign: TextAlign.right,
                    style: TextStyle(color: Colors.black),),
                  onTap: () async{
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('تأكيد عملية عملية تسجيل الخروح',textAlign: TextAlign.end),
                            content: Text('هل تريد تأكيد عملية تسجيل الخروح',textAlign: TextAlign.end),
                            actions: <Widget>[
                              TextButton(
                                  onPressed: () {
                                    //action code for "Yes" button
                                    firebaseAuth.signOut().then((value) async {
                                      await sharedPreferences!.setString("uid", "");
                                      await sharedPreferences!.setString("email", "");
                                      await sharedPreferences!.setString("name", "");
                                      await sharedPreferences!.setString("photoUrl", "");
                                      Navigator.push(context, MaterialPageRoute(builder: (c)=>WelcomeScreen()));
                                    });

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
                const   Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),

              ],
            ) ,
          ),
        ],
      ),
    );
  }
}
