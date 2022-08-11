import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_user_app/assistantMethods/cart_Item_counter.dart';
import 'package:food_user_app/mainScreen/welcome_screen.dart';
import 'package:food_user_app/splachScreen/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'assistantMethods/address_changer.dart';
import 'assistantMethods/total_amount.dart';
import 'globlal/global.dart';

Future<void> main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences=await SharedPreferences.getInstance();
  await Firebase.initializeApp();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
         ChangeNotifierProvider(create: (c)=>CartItemCounter()),
         ChangeNotifierProvider(create: (c)=> TotalAmount()),
        ChangeNotifierProvider(create: (c)=> AddressChanger()),
      ],
      child: new MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'user App',
        theme: ThemeData(

          primarySwatch: Colors.blue,
        ),
        home: const WelcomeScreen(),
      ),
    );
  }
}


