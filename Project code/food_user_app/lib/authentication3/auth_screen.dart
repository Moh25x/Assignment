import 'package:flutter/material.dart';
import 'package:food_user_app/authentication3/login.dart';
import 'package:food_user_app/authentication3/register.dart';

class AuthScreen3 extends StatefulWidget {
  const AuthScreen3({Key? key}) : super(key: key);

  @override
  _AuthScreen3State createState() => _AuthScreen3State();
}

class _AuthScreen3State extends State<AuthScreen3> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
         appBar: PreferredSize(
           preferredSize: Size.fromHeight(90.0),
           child: AppBar(
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
             automaticallyImplyLeading: false,

             bottom: const TabBar(
               tabs:[
                 Tab(
                   icon: Icon(Icons.lock,color: Colors.white,)
                   ,text: "دخول",),
                 Tab(
                   icon: Icon(Icons.person,color: Colors.white,)
                   ,text: "تسجيل",),
               ],
               indicatorColor: Colors.white38,
               indicatorWeight: 6,
             ),

           ),
         ),

          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.green,
                  Colors.white,
                ],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              ),
            ),
            child:  TabBarView(
              children: [
                LoginScreen(),
                RegisterScreen(),
              ],
            ),
          ),
        ),
    );
  }
}
