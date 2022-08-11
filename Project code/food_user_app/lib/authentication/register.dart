
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart'as fStorage;
import 'package:shared_preferences/shared_preferences.dart';
import '../globlal/global.dart';
import '../mainScreen/homeScreen.dart';
import '../widgets/customeTextField.dart';
import '../widgets/error_dialog.dart';
import '../widgets/loading_dialog.dart';

class RegisterScreen extends StatefulWidget {

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

 TextEditingController nameController=TextEditingController();
 TextEditingController passwordController=TextEditingController();
 TextEditingController confirmPasswordController=TextEditingController();
 TextEditingController emailController=TextEditingController();


 XFile? imageXfile;
 final GlobalKey<FormState> _formKey=GlobalKey<FormState>();
 final ImagePicker _picker=ImagePicker();


 String sellerImageUrl="";

 Future<void> _getImage()async{
   imageXfile=await _picker.pickImage(source: ImageSource.gallery);

   setState(() {
     imageXfile;
   });
 }


 Future<void> forValidation()async {
   if (imageXfile == null) {
     showDialog(
         context: context,
         builder: (c) {
           return ErrorDialog(
             message: "من فضلك اختار صورة الشركة",
           );
         }
     );
   }
   else {
     if (passwordController.text == confirmPasswordController.text) {
       if (confirmPasswordController.text.isNotEmpty &&
           emailController.text.isNotEmpty &&
           emailController.text.contains("@")&&
           emailController.text.contains(".com")&&
           nameController.text.isNotEmpty) {
         //start up date image
         showDialog(
             context: context,
             builder: (c){
               return LoadingDialog(
                 message: "تسجيل الحساب",
               )
               ;
             });
         String fileName=DateTime.now().millisecondsSinceEpoch.toString();
         fStorage.Reference reference=fStorage.FirebaseStorage.instance.ref().child("users").child(fileName);
         fStorage.UploadTask uploadTask=reference.putFile(File(imageXfile!.path));
         fStorage.TaskSnapshot taskSnapshot=await uploadTask.whenComplete((){});
         await taskSnapshot.ref.getDownloadURL().then((url){
           sellerImageUrl=url;

           //save information to fir store database

           authenticateSellerAndSignUp();
         });

       }
       else {
         showDialog(
             context: context,
             builder: (c) {
               return ErrorDialog(
                 message: " من فضلك تأكد من انهاء جميع الحقول بالشكل المطلوب",
               );
             }
         );
       }
     }
     else {
       showDialog(
           context: context,
           builder: (c) {
             return ErrorDialog(
               message: "كلمة المرور غير متطابقة",
             );
           }
       );
     }
   }
 }

 void authenticateSellerAndSignUp()async{
   User? currentUser;
    await firebaseAuth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text).then((auth){
          currentUser=auth.user;

    }).catchError((error){
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (c) {
            return ErrorDialog(
              message: "خطا" + error.message.toString(),
            );
          });
    });

    if(currentUser!=null){
      saveDataToFirestore(currentUser!).then((value){
      Navigator.pop(context);
        //send the user for home page

         Route newRoute=MaterialPageRoute(builder: (c)=>HomeScreen());
         Navigator.pushReplacement(context, newRoute);

      });
    }
 }

 Future saveDataToFirestore(User currentUser)async{
   FirebaseFirestore.instance.collection("users").doc(currentUser.uid).set({
     "uid":currentUser.uid,
     "email":currentUser.email,
     "name":nameController.text.trim(),
     "photoUrl":sellerImageUrl,
     "status":"approved",
   });
   // save data locally
   sharedPreferences=await SharedPreferences.getInstance();
   await sharedPreferences!.setString("uid", currentUser.uid);
   await sharedPreferences!.setString("email", currentUser.email.toString());
   await sharedPreferences!.setString("name", nameController.text.trim());
   await sharedPreferences!.setString("photoUrl", sellerImageUrl);
   await sharedPreferences!.setStringList("userCart", ["garbageValue"]);


 }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children:  [
          const SizedBox(height: 10,),
          InkWell(

            onTap: (){
              _getImage();
            },
            child: CircleAvatar(
              radius: MediaQuery.of(context).size.width*0.20,
              backgroundColor: Colors.white,
              backgroundImage: imageXfile==null?null : FileImage(File(imageXfile!.path)),
              child: imageXfile==null?Icon(
                Icons.add_photo_alternate,
                color: Colors.grey,
                size: MediaQuery.of(context).size.width*0.20,
              ):null,
            ),
          ),
          const SizedBox(height: 8,),
          Form(
              key: _formKey,
              child:Column(
                children: [
                 CustomTextFiled(
                   data: Icons.person,
                   controller: nameController,
                   hintText: "اسم المستخدم",
                   isObsece: false,
                 ),
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

                  CustomTextFiled(
                    data: Icons.lock,
                    controller: confirmPasswordController,
                    hintText: "تأكيد كلمة المرور",
                    isObsece: true,
                  ),

                ],
              ),

          ),
          const SizedBox(height: 30,),
          ElevatedButton(
              onPressed: (){
                forValidation();
            },
              child: const Text("تسجيل",style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              ),
            style: ElevatedButton.styleFrom(
              primary: Colors.green,
              padding: const EdgeInsets.symmetric(horizontal: 80,vertical: 5)
            ),
          ),
          const SizedBox(height: 30,),
        ],
      ),
    );
  }
}



