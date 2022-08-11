import 'package:flutter/material.dart';
import 'package:ridersapp/authentication/register.dart';
import 'login.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
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
