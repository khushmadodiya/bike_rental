import 'dart:async';
import 'package:bike_rental/mainScreen.dart';
import 'package:bike_rental/admin.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Assistant_method.dart';
import 'globle.dart';
import 'login.dart';


class splesh extends StatefulWidget{

  @override
  State<splesh> createState() => _spleshState();
}

class _spleshState extends State<splesh> {
  stimer()async{
    Timer(Duration(seconds: 3), () async{
      if(await firebaseAuth.currentUser != null){
        firebaseAuth.currentUser !=null ? AssistantMethod.readCurrenOnlinUserInfo() : null;
        DatabaseReference userRef = FirebaseDatabase.instance.ref()
            .child('user')
            .child(currentUser!.uid);
        userRef.once().then((snap) {

          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>mainScreen()));
        });


      }
      else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>logIn()));
      }
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    stimer();
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("VeloRental",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),)),
    );
  }
}