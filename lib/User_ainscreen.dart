import 'package:bike_rental/admin.dart';
import 'package:bike_rental/login.dart';
import 'package:bike_rental/main.dart';
import 'package:bike_rental/select_loc.dart';
import 'package:bike_rental/user_screen.dart';
import 'package:bike_rental/vehical_detail.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'Assistant_method.dart';
import 'globle.dart';

class userMainScreen extends StatefulWidget {
  const userMainScreen({super.key});

  @override
  State<userMainScreen> createState() => _userMainScreenState();
}

class _userMainScreenState extends State<userMainScreen> {

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      currentUser = null;
      print(currentUser);
      Fluttertoast.showToast(msg: "Successfully signed out");


      // Successfully signed out
    } catch (e) {
      // Handle errors, if any
      print('Error signing out: $e');
      Fluttertoast.showToast(msg: 'Error signing out: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    bool darkTheme = MediaQuery.of(context).platformBrightness == Brightness.dark;
    DatabaseReference locRef = FirebaseDatabase.instance.ref()
        .child('user').child(currentUser!.uid).child('location');
    return Scaffold(
      appBar: AppBar(title: Text('Select Role'),backgroundColor: darkTheme?Colors.amber.shade400 : Colors.blue,
        actions: [
          IconButton(onPressed: ()async{
            await signOut();
          }, icon: Icon(Icons.logout_outlined)),
          IconButton(onPressed: ()async{
            Navigator.push(context, MaterialPageRoute(builder: (context)=>logIn()));
          }, icon: Icon(Icons.login_outlined)),
          IconButton(onPressed: ()async{
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyApp()));
          }, icon: Icon(Icons.refresh_outlined))
        ],
      ),
      backgroundColor: darkTheme ? Colors.black87: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () async {
                if(firebaseAuth.currentUser != null){
                  firebaseAuth.currentUser !=null ? AssistantMethod.readCurrenOnlinUserInfo() : null;
                  locRef.once().then((snap) {
                    if (snap.snapshot.value != null) {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>userScreen()));
                    }
                    else{
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Location()));
                    }
                  });

                }
                else{
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Location()));
                }
              },
              child: Container(

                height: 40,
                width: 200,
                decoration: BoxDecoration(
                  color: darkTheme?Colors.amber.shade400 : Colors.blue,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(child: Text("User",style: TextStyle(fontSize: 20),)),
              ),

            ),
            SizedBox(height: 20,),

          ],
        ),
      ),
    );
  }
}
