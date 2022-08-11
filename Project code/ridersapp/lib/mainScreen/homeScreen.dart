import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ridersapp/mainScreen/earnings_screen.dart';
import 'package:ridersapp/mainScreen/history_screen.dart';
import 'package:ridersapp/mainScreen/not_yet_delivered_screen.dart';
import 'package:ridersapp/mainScreen/parcel_in_progress_screen.dart';
import '../assistantMethods/get_current_location.dart';
import '../authentication/auth_screen.dart';
import '../globlal/global.dart';
import '../splachScreen/splash_screen.dart';
import 'new_orders_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Card makeDashboardItem(String title, IconData iconData, int index)
  {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(8),
      child: Container(
        decoration: index == 0 || index == 3 || index == 4|| index == 1 || index == 2|| index == 5
            ? const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white70,
                Colors.white70,
              ],
              begin:  FractionalOffset(0.0, 0.0),
              end:  FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            )
        )
            : const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.green,
                Colors.green,
              ],
              begin:  FractionalOffset(0.0, 0.0),
              end:  FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            )
        ),
        child: InkWell(
          onTap: ()
          {
            if(index == 0)
            {
              //New Available Orders
              Navigator.push(context, MaterialPageRoute(builder: (c)=> NewOrdersScreen()));
            }
            if(index == 1)
            {
              //Parcels in Progress
              Navigator.push(context, MaterialPageRoute(builder: (c)=> ParcelInProgressScreen()));

            }
            if(index == 2)
            {
              //Not Yet Delivered
              Navigator.push(context, MaterialPageRoute(builder: (c)=> NotYetDeliveredScreen()));

            }
            if(index == 3)
            {
              //History
              Navigator.push(context, MaterialPageRoute(builder: (c)=> HistoryScreen()));

            }
            if(index == 4)
            {
              //Total Earnings
              Navigator.push(context, MaterialPageRoute(builder: (c)=> EarningsScreen()));

            }
            if(index == 5)
            {
              //Logout
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('تأكيد عملية عملية تسجيل الخروح',textAlign: TextAlign.end),
                      content: Text('هل تريد تأكيد عملية تسجيل الخروح',textAlign: TextAlign.end),
                      actions: <Widget>[
                        TextButton(
                            onPressed: () {
                              //action code for "Yes" button
                              firebaseAuth.signOut().then((value) async {
                                await sharedPreferences!.setString("uid", "");
                                await sharedPreferences!.setString("email", "");
                                await sharedPreferences!.setString("name", "");
                                await sharedPreferences!.setString("photoUrl", "");
                                Navigator.push(context, MaterialPageRoute(builder: (c)=>AuthScreen()));
                              });

                              Navigator.pop(context);
                            },
                            child: Text('نعم' ,textAlign: TextAlign.end,style: TextStyle(color: Colors.green),)),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context); //close Dialog
                          },
                          child: Text('لا',textAlign: TextAlign.end ,style: TextStyle(color: Colors.red),),

                        )
                      ],
                    );
                  });
              // firebaseAuth.signOut().then((value){
              //   Navigator.push(context, MaterialPageRoute(builder: (c)=> const AuthScreen()));
              // });
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            verticalDirection: VerticalDirection.down,
            children: [
              const SizedBox(height: 50.0),
              Center(
                child: Icon(
                  iconData,
                  size: 40,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 10.0),
              Center(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  RestrictBlockedUserFromUsingApp() async{
    await FirebaseFirestore.instance
        .collection("riders").doc(firebaseAuth.currentUser!.uid).get()
        .then((snapshot){
      if (snapshot.data()!["status"] != "approved") {
        Fluttertoast.showToast(msg: "تم تعطيل حسابك");
        firebaseAuth.signOut();
        Navigator.push(context, MaterialPageRoute(builder: (c)=>MySplashScreen()));
      }
      else{
        UserLocation uLocation = UserLocation();
        uLocation.getCurrentLocation();
        getPerParcelDeliveryAmount();
        getRiderPreviousEarnings();
      }

    });

  }

  @override
  void initState() {
    super.initState();
    RestrictBlockedUserFromUsingApp();

  }


  getRiderPreviousEarnings()
  {
    FirebaseFirestore.instance
        .collection("riders")
        .doc(sharedPreferences!.getString("uid"))
        .get().then((snap)
    {
      previousRiderEarnings = snap.data()!["earnings"].toString();
    });
  }

  getPerParcelDeliveryAmount()
  {
    FirebaseFirestore.instance
        .collection("perDelivery")
        .doc("alizeb438")
        .get().then((snap)
    {
      perParcelDeliveryAmount = snap.data()!["amount"].toString();
    });
  }

  @override
  Widget build(BuildContext context) {
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
        title: Text(sharedPreferences!.getString("name")!,style: TextStyle(color: Colors.white,fontSize: 25),),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 1),
        child: GridView.count(
          crossAxisCount: 2,
          padding: const EdgeInsets.all(2),
          children: [
            makeDashboardItem("طلبات متاحة", Icons.assignment, 0),
            makeDashboardItem("الطلبات قيد التنفيذ", Icons.airport_shuttle, 1),
            makeDashboardItem("طلبات لم تسلم بعد", Icons.location_history, 2),
            makeDashboardItem("أرشيف الطلبات", Icons.done_all, 3),
            makeDashboardItem("الرصيد", Icons.monetization_on, 4),
            makeDashboardItem("تسجيل خروج", Icons.logout, 5),
          ],
        ),
      ),
    );
  }
}
