
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../globlal/global.dart';

import '../mainScreen2/homeScreen.dart';
import '../model2/menus.dart';
import '../widgets/error_dialog.dart';
import 'package:firebase_storage/firebase_storage.dart' as storageRef;

import '../widgets2/progres_bar.dart';

class ItemsUploadScreen extends StatefulWidget {
 final Menus? model;
 ItemsUploadScreen({this.model});
  @override
  _ItemsUploadScreenState createState() => _ItemsUploadScreenState();
}

class _ItemsUploadScreenState extends State<ItemsUploadScreen>
{
  XFile? imageXfile;
  final ImagePicker _picker=ImagePicker();

  TextEditingController shortInfoContrroler=TextEditingController();
  TextEditingController titleContrroler=TextEditingController();
  TextEditingController discrptionContrroler=TextEditingController();
  TextEditingController priceController=TextEditingController();


  bool uploading=false;
  String unigueIdName=DateTime.now().millisecondsSinceEpoch.toString();
  defaultScreen(){
    return Scaffold(
      appBar: AppBar(
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
        title: const Text(
          "اضافة صنف جديدة",
          style: TextStyle(
              fontSize: 30,
              fontFamily: "Hacen"
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions:[ IconButton(
            onPressed: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (c)=>const HomeScreen()));
            },
            icon: const Icon(Icons.arrow_forward_outlined)),],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.green,
              Colors.white,
            ],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(1.0, 0.0),
            stops: [0.0,1.0],
            tileMode: TileMode.clamp,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.shop_two,size: 200,color: Colors.white,),

              ElevatedButton(
                  onPressed: (){
                    takeImage(context);
                  },
                  style:ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  child: const Text("اضافة صنف جديدة",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white
                    ),))
            ],
          ),
        ),
      ),
    );
  }
  takeImage(mcontext){

    return showDialog(
        context: mcontext,
        builder: (context){
          return  SimpleDialog(
            title: const Text("صورة القائمة",
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            children: [
              const Divider(height: 2,
                color: Colors.grey,
                thickness: 2,
              ),
              SimpleDialogOption(
                child: const Text("التقط صورة من الكاميرا",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                onPressed: captureImageWithCamera,
              ),
              const Divider(height: 2,
                color: Colors.grey,
                thickness: 2,
              ),
              SimpleDialogOption(
                child: const Text("اختار صورة من معرض الصور",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                onPressed: pickImageFromGallery,
              ),
              const Divider(height: 2,
                color: Colors.grey,
                thickness: 2,
              ),
              SimpleDialogOption(
                child: const Text("انهاء",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
                onPressed:()=> Navigator.pop(context),
              ),

            ],
          );
        });

  }

  captureImageWithCamera()async{
    Navigator.pop(context);
    imageXfile=await _picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 720,
      maxWidth: 1280,
    );
    setState(() {
      imageXfile;
    });
  }

  pickImageFromGallery() async{
    Navigator.pop(context);
    imageXfile=await _picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 720,
      maxWidth: 1280,
    );
    setState(() {
      imageXfile;
    });
  }

  itemsUploadFormScreen(){
    return Scaffold(
      appBar: AppBar(
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
        title: const Text(
          "اضافة اصناف جديدة",
          style: TextStyle(
              fontSize: 25,
              fontFamily: "Hacen"
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,

        leading: TextButton(
          onPressed: uploading?null: ()=>validatUploadForm(),

          child: const Text("اضافة",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
              fontFamily: "Hacen",

            ),
          ),
        ),
        actions:[ IconButton(
            onPressed: (){
              clearMenuUploadForm();
            },
            icon: const Icon(Icons.arrow_forward_outlined)),],
      ),

      body: ListView(

        children: [
          uploading==true?linearProgress():const Text(""),
          Container(
            height: 230,
            width: MediaQuery.of(context).size.width*0.8,
            child: Center(
              child: AspectRatio(
                aspectRatio: 16/9,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
                    image: DecorationImage(
                      image: FileImage(
                        File(imageXfile!.path),
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

              ),
            ),
          ),
          const Divider(
            color: Colors.green,
            thickness: 1,
          ),
          ListTile(
            leading: const Icon(
              Icons.perm_device_information,
              color:Colors.green,),
            title: Container(
              width: 250,
              margin: EdgeInsets.only(right: 20),
              child:  TextField(
                textAlign: TextAlign.right,
                style: const TextStyle(color: Colors.black),
                controller: shortInfoContrroler,
                decoration: const InputDecoration(
                    hintText: "معلومات الصنف",
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none
                ),
              ),
            ),
          ),
          const Divider(
            color: Colors.green,
            thickness: 1,
          ),
          ListTile(
            leading: const Icon(
              Icons.title,
              color:Colors.green,),
            title: Container(
              width: 250,
              margin: EdgeInsets.only(right: 20),
              child:  TextField(
                textAlign: TextAlign.right,
                style: const TextStyle(color: Colors.black),
                controller: titleContrroler,
                decoration: const InputDecoration(
                    hintText: "عنوان الصنف",
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none
                ),
              ),
            ),
          ),
          const Divider(
            color: Colors.green,
            thickness: 1,
          ),

          ListTile(
            leading: const Icon(
              Icons.description,
              color:Colors.green,),
            title: Container(
              width: 250,
              margin: EdgeInsets.only(right: 20),
              child:  TextField(
                textAlign: TextAlign.right,
                style: const TextStyle(color: Colors.black),
                controller: discrptionContrroler,
                decoration: const InputDecoration(
                    hintText: "وصف الصنف",
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none
                ),
              ),
            ),
          ),
          const Divider(
            color: Colors.green,
            thickness: 1,
          ),
          ListTile(
            leading: const Icon(
              Icons.camera,
              color:Colors.green,),
            title: Container(
              width: 250,
              margin: EdgeInsets.only(right: 20),
              child:  TextField(
                keyboardType: TextInputType.number,
                textAlign: TextAlign.right,
                style: const TextStyle(color: Colors.black),
                controller: priceController,
                decoration: const InputDecoration(
                    hintText: "اضافة السعر",
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none
                ),
              ),
            ),
          ),
          const Divider(
            color: Colors.green,
            thickness: 1,
          ),

        ],
      ),

    );
  }

  clearMenuUploadForm(){
    setState(() {
      shortInfoContrroler.clear();
      titleContrroler.clear();
      priceController.clear();
      discrptionContrroler.clear();
      imageXfile=null;
    });
  }

  validatUploadForm()async{
    if(imageXfile!=null){
      if(shortInfoContrroler.text.isNotEmpty&& titleContrroler.text.isNotEmpty&&discrptionContrroler.text.isNotEmpty&&priceController.text.isNotEmpty)
      {
        setState(() {
          uploading=true;
        });

        //up loading image
        String downloadUrl= await uploadImage(File(imageXfile!.path));
        //save info to firestore
        saveInfo(downloadUrl);
      }
      else{
        showDialog(
            context: context,
            builder: (c) {
              return ErrorDialog(
                message: "من فضلك تأكد من انهاء جميع الحقول",
              );
            }
        );
      }

    }
    else{
      showDialog(
          context: context,
          builder: (c) {
            return ErrorDialog(
              message: "من فضلك تأكد من اختيار الصورة",
            );
          }
      );
    }
  }

  uploadImage(mImageFile)async{
    storageRef.Reference reference=storageRef.FirebaseStorage
        .instance
        .ref()
        .child("items");

    storageRef.UploadTask uploadTask=reference.child(unigueIdName+".jpg").putFile(mImageFile);
    storageRef.TaskSnapshot taskSnapshot=await uploadTask.whenComplete((){});
    String downloadUrl=await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  saveInfo(String downloadUrl)async
  {
    final ref=FirebaseFirestore.instance
        .collection("sellers")
        .doc(sharedPreferences!.getString("uid"))
        .collection("menus").doc(widget.model!.menuID)
    .collection("items");

    ref.doc(unigueIdName).set({
      "itemID":unigueIdName,
      "menuID":widget.model!.menuID,
      "sellerUID":sharedPreferences!.getString("uid"),
      "sellerName":sharedPreferences!.getString("name"),
      "shortInfo":shortInfoContrroler.text.toString(),
      "longDescription":discrptionContrroler.text.toString(),
      "price":int.parse(priceController.text),
      "title":titleContrroler.text.toString(),
      "publishedDate":DateTime.now(),
      "status":"available",
      "thumbnailUrl":downloadUrl,
    }).then((value) {
      final itemsRef=FirebaseFirestore.instance
          .collection("items");
      itemsRef.doc(unigueIdName).set({
        "itemID":unigueIdName,
        "menuID":widget.model!.menuID,
        "sellerUID":sharedPreferences!.getString("uid"),
        "sellerName":sharedPreferences!.getString("name"),
        "shortInfo":shortInfoContrroler.text.toString(),
        "longDescription":discrptionContrroler.text.toString(),
        "price":int.parse(priceController.text),
        "title":titleContrroler.text.toString(),
        "publishedDate":DateTime.now(),
        "status":"available",
        "thumbnailUrl":downloadUrl,
      });
    }).then((value) {
      clearMenuUploadForm();
      setState(() {
        unigueIdName=DateTime.now().millisecondsSinceEpoch.toString();
        uploading=false;
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return imageXfile== null ?defaultScreen(): itemsUploadFormScreen();
  }
}
