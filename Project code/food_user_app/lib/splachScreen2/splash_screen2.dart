import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_user_app/authentication2/auth_screen.dart';

import '../globlal/global.dart';
import '../mainScreen2/homeScreen.dart';


class MySplashScreen2 extends StatefulWidget {
  const MySplashScreen2({Key? key}) : super(key: key);

  @override
  _MySplashScreen2State createState() => _MySplashScreen2State();
}

class _MySplashScreen2State extends State<MySplashScreen2> {

  startTimer(){

    Timer(const Duration(seconds: 3),()async{

      //if seller is loggedin in app
      if(firebaseAuth.currentUser != null){
        Navigator.push(context, MaterialPageRoute(builder: (c)=>const HomeScreen()));
      }
      //if not
     else{
        Navigator.push(context, MaterialPageRoute(builder: (c)=>const AuthScreen()));
      }
     });
  }
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: const BoxDecoration(
        gradient:  LinearGradient(
        colors: [
        Colors.white,
        Colors.green,
        ],
        begin:  FractionalOffset(0.0, 0.0),
    end:  FractionalOffset(1.0, 0.0),
    stops: [0.0,1.0],
    tileMode: TileMode.clamp,
    )
    ),

    child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset("images/logo.png"),
              ),
              const SizedBox(height: 10,),

            ],
          ),
        ),
      ),
    );
  }
}
