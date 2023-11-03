
import 'dart:async';

import 'package:bike_rental/select_loc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'BookingScreen.dart';
import 'globle.dart';

class userScreen extends StatefulWidget {
  const userScreen({super.key});

  @override

  State<userScreen> createState() => _userScreenState();
}

class _userScreenState extends State<userScreen> {
  DatabaseReference publicRef = FirebaseDatabase.instance.ref('public');



  @override
  Widget build(BuildContext context) {
    bool darkTheme = MediaQuery
        .of(context)
        .platformBrightness == Brightness.dark;
    return Scaffold(
      backgroundColor: darkTheme ? Colors.black87 : Colors.white,
      appBar: AppBar(
        title: Text('Vehicals'),
        backgroundColor: darkTheme ? Colors.amber.shade400 : Colors.blue,
        actions: [
        ],

      ),
      body: Column(
        children: [
          Expanded(
              child: FirebaseAnimatedList(
                query: publicRef.orderByChild('city').equalTo(city),
                itemBuilder: (BuildContext context, DataSnapshot snapshot,
                    Animation<double> animation, int index) {
                  return Column(
                    children: [
                      SizedBox(height: 20,),
                      Container(
                        height: 100,

                        decoration: BoxDecoration(
                            color: darkTheme ? Colors.grey.shade800 : Colors
                                .blue.shade200,
                            borderRadius: BorderRadius.circular(10)

                        ),
                        child: ListTile(
                          title: Text(snapshot.child('vehicalname').value.toString(), style: TextStyle(fontSize: 25,
                              color: darkTheme ? Colors.white : Colors.black),),
                          subtitle: Text('''${snapshot.child('colony').value.toString()}, ${snapshot.child('city').value.toString()}''', style: TextStyle(fontSize: 20,
                              color: darkTheme ? Colors.white : Colors.black),),
                          trailing: ElevatedButton(
                            onPressed: () async{
                              DatabaseReference publicbtnRef = FirebaseDatabase.instance.ref('public');
                           publicbtnRef.once().then((snap) {
                              adminuid = snapshot.child('id').value.toString();
                              admin_vehicalid = snapshot.child('vehicalnumber').value.toString();

                              print(adminuid);
                              print(admin_vehicalid);
                           }).then((value) {
                             DatabaseReference userRef = FirebaseDatabase.instance.ref('user').child(adminuid!).child('vehicaldetail').child(admin_vehicalid!);
                             userRef.once().then((snap) {
                               print(snapshot.child('status').value.toString());
                               if (snapshot.child('status').value.toString() == "0") {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => bookingScreen()));
                                     userRef.update(
                                       {
                                         'status': "1",
                                       }).then((value) {
                                     Fluttertoast.showToast(msg: 'Done');
                                   });
                                 }

                               else{
                                 Fluttertoast.showToast(msg: 'Already booked');
                               }
                             });
                           });


                           },
                            child: Text('Book Now'),
                          ),
                        ),
                      ),
                      SizedBox(height: 10,)
                    ],
                  );
                },


              )
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Location()));
        },
        child: Icon(Icons.location_on_outlined, size: 40,),
        backgroundColor: darkTheme ? Colors.amber.shade400 : Colors.blue,

      ),
    );
  }

}