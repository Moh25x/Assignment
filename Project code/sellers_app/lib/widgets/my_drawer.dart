import 'package:flutter/material.dart';
import 'package:sellers_app/mainScreen/earnings_screen.dart';
import 'package:sellers_app/mainScreen/history_screen.dart';
import 'package:sellers_app/mainScreen/homeScreen.dart';
import 'package:sellers_app/mainScreen/new_orders_screen.dart';

import '../authentication/auth_screen.dart';
import '../globlal/global.dart';

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
                  leading: const Icon(Icons.home,color: Colors.black,),
                  title: const Text("الصفحة الرئيسية",
                    textAlign: TextAlign.right,
                    style: TextStyle(color: Colors.black),),
                  onTap: (){
                   Navigator.push(context, MaterialPageRoute(builder: (c)=>const HomeScreen()));
                  },
                ),
                const   Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),

                // ListTile(
                //   leading: const Icon(Icons.monetization_on,color: Colors.black,),
                //   title: const Text("ارباح",
                //     textAlign: TextAlign.right,
                //     style: TextStyle(color: Colors.black),),
                //   onTap: (){
                //    Navigator.push(context, MaterialPageRoute(builder: (c)=> EarningsScreen()));
                //
                //   },
                // ),
                // const   Divider(
                //   height: 10,
                //   color: Colors.grey,
                //   thickness: 2,
                // ),
                ListTile(
                  leading: const Icon(Icons.reorder,color: Colors.black,),
                  title: const Text("طلب جديد",
                    textAlign: TextAlign.right,
                    style: TextStyle(color: Colors.black),),
                  onTap: (){
                   Navigator.push(context, MaterialPageRoute(builder: (c)=> NewOrdersScreen()));
                  },
                ),
                const   Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),
                ListTile(
                  leading: const Icon(Icons.local_shipping,color: Colors.black,),
                  title: const Text("تأريخ الطلبات",
                    textAlign: TextAlign.right,
                    style: TextStyle(color: Colors.black),),
                  onTap: (){
                   Navigator.push(context, MaterialPageRoute(builder: (c)=> HistoryScreen()));

                  },
                ),
                const   Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),
                ListTile(
                  leading: const Icon(Icons.exit_to_app,color: Colors.black,),
                  title: const Text("تسجيل خروج",
                    textAlign: TextAlign.right,
                    style: TextStyle(color: Colors.black),),
                  onTap: (){

                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('تأكيد عملية تسجيل الخروج',textAlign: TextAlign.end),
                            content: Text('هل تريد تأكيد عملية تسجيل الخروج؟',textAlign: TextAlign.end),
                            actions: <Widget>[
                              TextButton(
                                  onPressed: () {
                                    //action code for "Yes" button
                                    firebaseAuth.signOut().then((value){
                                      Navigator.push(context, MaterialPageRoute(builder: (c)=>AuthScreen()));
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
