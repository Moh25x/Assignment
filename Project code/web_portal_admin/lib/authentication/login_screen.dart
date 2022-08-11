import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../main_screens/home_screen.dart';


class LoginScreen extends StatefulWidget
{
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}



class _LoginScreenState extends State<LoginScreen>
{
  String adminEmail = "";
  String adminPassword = "";

  allowAdminToLogin() async
  {
     SnackBar snackBar = const SnackBar(
      content: Text(
        "فحص المدخلات ، من فضلك انتظر قليلا",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 36,
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.green,
      duration: Duration(seconds: 6),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);


    User? currentAdmin;
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: adminEmail,
        password: adminPassword,
    ).then((fAuth)
    {
      //success
      currentAdmin = fAuth.user;
    }).catchError((onError)
    {
      //in case of error
      //display error message
      final snackBar = SnackBar(
        content: Text(
           onError.toString()+ "خطا : ",
          style: const TextStyle(
            fontSize: 36,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 5),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });

    if(currentAdmin != null)
    {
      //check if that admin record also exists in the admins collection in firestore database
      await FirebaseFirestore.instance
          .collection("admins")
          .doc(currentAdmin!.uid)
          .get().then((snap)
      {
        if(snap.exists)
        {
          Navigator.push(context, MaterialPageRoute(builder: (c)=> const HomeScreen()));
        }
        else
        {
          SnackBar snackBar = const SnackBar(
            content: Text(
              "لا يوجد تسجيل لهذا الحساب ، أنت ليس أدمن",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 36,
                color: Colors.white,
              ),
            ),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 6),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * .5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  //image
                  Image.asset(
                    "images/admin2.png"
                  ),

                  //email text field
                  TextField(
                    onChanged: (value)
                    {
                      adminEmail = value;
                    },
                    textAlign: TextAlign.end,
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.green,
                            width: 2,
                          )
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 2,
                        )
                      ),
                      hintText: "ايميل",
                      hintStyle: TextStyle(color: Colors.grey),
                      icon: Icon(
                        Icons.email,
                        color: Colors.green,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10,),

                  //password text field
                  TextField(
                    onChanged: (value)
                    {
                      adminPassword = value;
                    },
                    textAlign: TextAlign.end,
                    obscureText: true,
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.green,
                            width: 2,
                          )
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 2,
                          )
                      ),
                      hintText: "كلمة مرور",

                      hintStyle: TextStyle(color: Colors.grey),
                      icon: Icon(
                        Icons.admin_panel_settings,
                        color: Colors.green,
                      ),
                    ),
                  ),

                  const SizedBox(height: 30,),

                  //button login
                  ElevatedButton(
                    onPressed: ()
                    {
                      allowAdminToLogin();
                    },

                    style: ButtonStyle(
                   elevation: MaterialStateProperty.all(10),
                      padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 100, vertical: 20)),
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                    ),

                    child: const Text(
                      "دخول",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
