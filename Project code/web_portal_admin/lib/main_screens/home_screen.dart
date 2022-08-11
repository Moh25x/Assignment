import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:web_portal_admin/authentication/login_screen.dart';
import 'package:web_portal_admin/riders/all_blocked_riders_screen.dart';
import 'package:web_portal_admin/riders/all_verified_riders_screen.dart';
import 'package:web_portal_admin/sellers/all_blocked_sellers_screen.dart';
import 'package:web_portal_admin/sellers/all_verified_sellers_screen.dart';
import 'package:web_portal_admin/users/all_blocked_users_screen.dart';
import 'package:web_portal_admin/users/all_verified_users_screen.dart';



class HomeScreen extends StatefulWidget
{
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}



class _HomeScreenState extends State<HomeScreen>
{
  String timeText = "";
  String dateText = "";


  String formatCurrentLiveTime(DateTime time)
  {
    return DateFormat("hh:mm:ss a").format(time);
  }

  String formatCurrentDate(DateTime date)
  {
    return DateFormat("dd MMMM, yyyy").format(date);
  }

  getCurrentLiveTime()
  {
    final DateTime timeNow = DateTime.now();
    final String liveTime = formatCurrentLiveTime(timeNow);
    final String liveDate = formatCurrentDate(timeNow);

    if(this.mounted)
    {
      setState(() {
        timeText = liveTime;
        dateText = liveDate;
      });
    }
  }

  @override
  void initState()
  {
    super.initState();

    //time
    timeText = formatCurrentLiveTime(DateTime.now());

    //date
    dateText = formatCurrentDate(DateTime.now());

    Timer.periodic(const Duration(seconds: 1), (timer)
    {
      getCurrentLiveTime();
    });
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors:
              [
                Colors.green,
                Colors.green,
              ],
              begin: FractionalOffset(0, 0),
              end: FractionalOffset(1, 0),
              stops: [0, 1],
              tileMode: TileMode.clamp,
            ),
          ),
        ),
        title: const Text(
          "لوحة التحكم",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                timeText + "\n" + dateText,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  letterSpacing: 3,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            //users activate and block accounts button ui
            Row(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                //active
                Container(
                  width: 300,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.person_add, color: Colors.white,),
                    label: const Text(
                      "حسابات مستخدمين فعالة",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,

                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      onPrimary: Colors.white,
                      padding: const EdgeInsets.all(40),
                      elevation: 10,
                      primary: Colors.green,
                    ),
                    onPressed: ()
                    {
                   Navigator.push(context, MaterialPageRoute(builder: (c)=>AllVerifiedUsersScreen()));
                    },
                  ),
                ),

                const SizedBox(width: 20,),

                //block
                Container(
                  width: 300,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.block_flipped, color: Colors.green,),
                    label: const Text(
                      "حسابات مستخدمين معطلة",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.green,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                        onPrimary: Colors.green,
                        padding: const EdgeInsets.all(40),
                      primary: Colors.white,
                      elevation: 10
                    ),
                    onPressed: ()
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (c)=>AllBlockedUsersScreen()));

                    },
                  ),
                ),
              ],
            ),

            //sellers activate and block accounts button ui
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //active
                Container(
                  width: 300,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.person_add, color: Colors.white,),
                    label: const Text(
                      "حسابات بائعين فعالة",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,

                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(40),
                      elevation: 10,
                      primary: Colors.green,
                    ),
                    onPressed: ()
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (c)=>AllVerifiedSellersScreen()));

                    },
                  ),
                ),

                const SizedBox(width: 20,),

                //block
                Container(
                  width: 300,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.block_flipped, color: Colors.green,),
                    label: const Text(
                      "حسابات بائعين معطلة",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.green,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(40),
                        primary: Colors.white,
                        elevation: 10
                    ),
                    onPressed: ()
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (c)=>AllBlockedSellersScreen()));

                    },
                  ),
                ),
              ],
            ),

            //riders activate and block accounts button ui
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //active
                Container(
                  width: 300,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.person_add, color: Colors.white,),
                    label: const Text(
                      "حسابات سائقين فعالة",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,

                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(40),
                      elevation: 10,
                      primary: Colors.green,
                    ),
                    onPressed: ()
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (c)=>AllVerifiedRidersScreen()));

                    },
                  ),
                ),

                const SizedBox(width: 20,),

                //block
                Container(
                  width: 300,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.block_flipped, color: Colors.green,),
                    label: const Text(
                      "حسابات سائقين معطلة",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.green,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(40),
                        primary: Colors.white,
                        elevation: 10
                    ),
                    onPressed: ()
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (c)=>AllBlockedRidersScreen()));

                    },
                  ),
                ),
              ],
            ),

            //logout button
            Container(
              width: 300,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.logout, color: Colors.white,),
                label: const Text(
                  "تسجيل خروج",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(40),
                  elevation: 10,
                  primary: Colors.red,
                ),
                onPressed: ()
                {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('تأكيد عملية تسجيل الخروج',textAlign: TextAlign.center),
                          content: const Text('هل تريد تأكيد عملية تسجيل الخروج؟',textAlign: TextAlign.end),
                          actions: <Widget>[
                            TextButton(
                                onPressed: () {
                                  //action code for "Yes" button
                                  FirebaseAuth.instance.signOut();
                                  Navigator.pop(context);
                                  Navigator.push(context, MaterialPageRoute(builder: (c)=>LoginScreen()));
                                },
                                child: const Text('نعم' ,textAlign: TextAlign.end,style: TextStyle(color: Colors.green),)),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context); //close Dialog
                              },
                              child: Text('لا',textAlign: TextAlign.end ,style: TextStyle(color: Colors.red),),

                            )
                          ],
                        );
                      });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
