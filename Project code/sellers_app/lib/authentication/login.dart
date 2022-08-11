import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sellers_app/authentication/auth_screen.dart';
import 'package:sellers_app/globlal/global.dart';
import 'package:sellers_app/mainScreen/homeScreen.dart';
import 'package:sellers_app/widgets/customeTextField.dart';
import 'package:sellers_app/widgets/error_dialog.dart';
import 'package:sellers_app/widgets/loading_dialog.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController passwordController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  final GlobalKey<FormState> _formKey=GlobalKey<FormState>();


  formValidation(){
    if(emailController.text.isNotEmpty &&
        emailController.text.contains("@")&&
        emailController.text.contains(".com")&&
        passwordController.text.isNotEmpty){
      //login
      //تم التعطيل
     loginNow();
    }
    else{
      showDialog(
          context: context,
          builder: (c){
            return ErrorDialog(
              message: "ادخل الايميل و كلمة المرور",
            );
          });
    }
  }

  loginNow() async{

    showDialog(
        context: context,
        builder: (c){
          return LoadingDialog(
            message: "فحص المدخلات",
          );
        });
   User? crrentUser;

   await firebaseAuth.signInWithEmailAndPassword(
       email: emailController.text.trim(),
       password: passwordController.text
   ).then((auth) {
     crrentUser=auth.user;
   }).catchError((error){
     Navigator.pop(context);
     showDialog(
         context: context,
         builder: (c){
           return ErrorDialog(
             message: "خطأ"+error.message.toString(),
           );
         });
   });
   if(crrentUser !=null){

     readDataAndSetDataLocally(crrentUser!);

   }
  }

  Future readDataAndSetDataLocally(User currentUser) async{
    await FirebaseFirestore.instance
        .collection("sellers").doc(currentUser.uid)
        .get().then((snapshot)async{
          if(snapshot.exists) {
            if (snapshot.data()!["status"] == "approved") {
              await sharedPreferences!.setString("uid", currentUser.uid);
              await sharedPreferences!.setString(
                  "email", snapshot.data()!["sellerEmail"]);
              await sharedPreferences!.setString(
                  "name", snapshot.data()!["sellerName"]);
              await sharedPreferences!.setString(
                  "photoUrl", snapshot.data()!["sellerAvatarUrl"]);
              Navigator.pop(context);
              Navigator.push(
                  context, MaterialPageRoute(builder: (c) => HomeScreen()));
            } else{
              firebaseAuth.signOut();
              Navigator.pop(context);
              Fluttertoast.showToast(msg: "قام الأدمن بتعطيل حسابك");
            }
          }
          else{
            firebaseAuth.signOut();
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (c)=>AuthScreen()));
            showDialog(
                context: context,
                builder: (c){
                  return ErrorDialog(
                    message: "استخدم حساب فعال",
                  );
                });

          }


    });
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children:  [
          Container(
            alignment: Alignment.bottomCenter,
            child:  Padding(
              padding: const EdgeInsets.all(8),
              child: Image.asset("images/logo.png",
              height: 270,
              ),
            ),
          ),

          Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextFiled(
                    data: Icons.email,
                    controller: emailController,
                    hintText: "البريد الالكتروني",
                    isObsece: false,
                  ),
                  CustomTextFiled(
                    data: Icons.lock,
                    controller: passwordController,
                    hintText: "كلمة المرور",
                    isObsece: true,
                  ),
                  const SizedBox(height: 30,),
                  ElevatedButton(
                    onPressed: (){
                      formValidation();
                    },
                    child: const Text("دخول",style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                    ),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        padding: const EdgeInsets.symmetric(horizontal: 80,vertical: 5)
                    ),
                  ),



                ],
              ),
          ),


        ],
      ),

    );
  }
}
