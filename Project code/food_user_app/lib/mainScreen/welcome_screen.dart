import 'package:flutter/material.dart';
import 'package:food_user_app/splachScreen2/splash_screen2.dart';
import 'package:food_user_app/splachScreen3/splash_screen.dart';

import '../splachScreen/splash_screen.dart';
import '../widgets/text_utils.dart';


class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [

             Padding(
               padding: const EdgeInsets.only(left: 85.0),
               child: Image.asset(
                  'images/mmm.png',
                width: 200,
                 height: 600,
                 // fit: BoxFit.cover,
                ),
             ),

            Container(
              color: Colors.black.withOpacity(0.1),
              width: double.infinity,
              height: double.infinity,
              child: Column(
               // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                SizedBox(height: 100,),
                  Container(
                    height: 60,
                    width: 230,
                    // decoration: BoxDecoration(
                    //   color: Colors.black.withOpacity(0.3),
                    //   borderRadius: BorderRadius.circular(5),
                    // ),
                    child: Row(
                 //     mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextUtils(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          text: "الفلسطيني",
                          color: Colors.black,
                          underLine: TextDecoration.none,
                        ),
                        const SizedBox(
                          width: 7,
                        ),

                        TextUtils(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          text: "البيت",
                          color: Colors.black,
                          underLine: TextDecoration.none,
                        ),

                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 300,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 12,
                        )),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (c)=>MySplashScreen()));
                 //     Get.offNamed(Routes.loginScreen);
                    },
                    child: TextUtils(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      text: 'تسجيل دخول مستخدم',
                      color: Colors.white,
                      underLine: TextDecoration.none,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 12,
                        )),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (c)=>MySplashScreen2()));
                      //     Get.offNamed(Routes.loginScreen);
                    },
                    child: TextUtils(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      text: 'تسجيل دخول بائع',
                      color: Colors.white,
                      underLine: TextDecoration.none,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 12,
                        )),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (c)=>MySplashScreen3()));
                      //     Get.offNamed(Routes.loginScreen);
                    },
                    child: TextUtils(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      text: 'تسجيل دخول سائق',
                      color: Colors.white,
                      underLine: TextDecoration.none,
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
