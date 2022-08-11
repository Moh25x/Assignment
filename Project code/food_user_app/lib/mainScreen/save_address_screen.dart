import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import '../globlal/global.dart';
import '../models/address.dart';
import '../widgets/simple_app_bar.dart';
import '../widgets/text_field.dart';

class SaveAddressScreen extends StatelessWidget
{
  final _name = TextEditingController();
  final _phoneNumber = TextEditingController();
  final _flatNumber = TextEditingController();
  final _city = TextEditingController();
  final _state = TextEditingController();
  final _completeAddress = TextEditingController();
  final _locationController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  List<Placemark>? placemarks;
  Position? position;


  getUserLocationAddress() async
  {
    Position newPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high
    );

    position = newPosition;

    placemarks = await placemarkFromCoordinates(
        position!.latitude, position!.longitude
    );

    Placemark pMark = placemarks![0];

    String fullAddress = '${pMark.subThoroughfare} ${pMark.thoroughfare}, ${pMark.subLocality} ${pMark.locality}, ${pMark.subAdministrativeArea}, ${pMark.administrativeArea} ${pMark.postalCode}, ${pMark.country}';

    _locationController.text = fullAddress;

    _flatNumber.text = '${pMark.subThoroughfare} ${pMark.thoroughfare}, ${pMark.subLocality} ${pMark.locality}';
    _city.text = '${pMark.subAdministrativeArea}, ${pMark.administrativeArea} ${pMark.postalCode}';
    _state.text = '${pMark.country}';
    _completeAddress.text = fullAddress;
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: SimpleAppBar(),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.green,
        label: const Text("حفظ الموقع"),
        icon: const Icon(Icons.save),
        onPressed: ()
        {
          //save address info
          if(formKey.currentState!.validate())
          {
            final model = Address(
              name: _name.text.trim(),
              state: _state.text.trim(),
              fullAddress: _completeAddress.text.trim(),
              phoneNumber: _phoneNumber.text.trim(),
              flatNumber: _flatNumber.text.trim(),
              city: _city.text.trim(),
              lat: position!.latitude,
              lng: position!.longitude,
            ).toJson();
            
            FirebaseFirestore.instance.collection("users")
                .doc(sharedPreferences!.getString("uid"))
                .collection("userAddress")
                .doc(DateTime.now().millisecondsSinceEpoch.toString())
                .set(model).then((value)
            {
              Fluttertoast.showToast(msg: "تم حفظ الموقع الجديد.");
              formKey.currentState!.reset();
            });
          }
        },
      ),
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const SizedBox(height: 6,),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                " : اضافة موقع جديد",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,

                ),
              ),
            ),

            ListTile(
              title: const Icon(
                Icons.person_pin_circle,
                color: Colors.green,
                size: 35,
              ),
              leading: Container(
                width: 290,
                child: TextField(
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  controller: _locationController,
                  decoration: const InputDecoration(
                    hintText: "حدد العنوان الخاص بك",
                    hintStyle: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
            ),

            const SizedBox(height: 6,),

            Center(
              child: ElevatedButton.icon(
                label: const Text(
                  "تحديد العنوان تلقائي",
                  style: TextStyle(color: Colors.white),
                ),
                icon: const Icon(Icons.location_on, color: Colors.white,),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green),
                   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                onPressed: ()
                {
                  //getCurrentLocationWithAddress
                  getUserLocationAddress();
                },
              ),
            ),
         Padding(
           padding: const EdgeInsets.all(8.0),
           child: Divider(thickness: 3,color: Colors.grey,),
         ),
            SizedBox(height: 20,),

            Form(
              key: formKey,
              child: Column(
                children: [
                  MyTextField(
                    hint: "الاسم",
                    controller: _name,
                  ),
                  MyTextField(
                    hint: 'رقم الهاتف',
                    controller: _phoneNumber,
                  ),
                  MyTextField(
                    hint: 'المدينة',
                    controller: _city,
                  ),
                  MyTextField(
                    hint: 'الدولة / المدينة',
                    controller: _state,
                  ),
                  MyTextField(
                    hint: 'عنوان الشارع',
                    controller: _flatNumber,
                  ),
                  MyTextField(
                    hint: 'العنوان بالكامل',
                    controller: _completeAddress,
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
