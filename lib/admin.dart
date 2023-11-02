import 'package:bike_rental/mainScreen.dart';
import 'package:bike_rental/globle.dart';
import 'package:bike_rental/login.dart';
import 'package:bike_rental/vehical_detail.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Admin extends StatefulWidget {
  const Admin({super.key});

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  DatabaseReference vehicalRef = FirebaseDatabase.instance.ref('user')
      .child(currentUser!.uid).child('vehicaldetail');
  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      await Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>mainScreen()));
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
    return Scaffold(
          appBar: AppBar(
            title: Text('Vehical details'),
            backgroundColor: darkTheme?Colors.amber.shade400 : Colors.blue,
            actions: [
              IconButton(onPressed: ()async{

                await signOut();
              }, icon: Icon(Icons.logout_outlined)),
              IconButton(onPressed: ()async{
                print(currentUser!.uid);
                await Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Admin()));
              }, icon: Icon(Icons.refresh_outlined,size: 40,)),

            ],
          ),
      backgroundColor: darkTheme ? Colors.black87: Colors.white,
      body: Column(
        children: [
          Expanded(
              child: FirebaseAnimatedList(
                query:vehicalRef,
                itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
                  return GestureDetector(
                    onVerticalDragUpdate: (flag){
                      setState(() {
                          FloatingActionButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>vehicalDtail()));

                        },
                          child: Icon(Icons.add),
                        );
                      });

                    },
                    child: Column(
                      children: [
                        SizedBox(height: 20,),
                        Container(
                          height: 100,

                          decoration: BoxDecoration(
                            color: darkTheme ? Colors.grey.shade800 : Colors.blue.shade200,
                            borderRadius: BorderRadius.circular(10)

                          ),
                          child: ListTile(
                              title: Text(snapshot.child('vehicalname').value.toString(),style: TextStyle(fontSize: 25,color: darkTheme?Colors.white:Colors.black),),
                              subtitle: Text('''${snapshot.child('colony').value.toString()}, ${snapshot.child('city').value.toString()}''',style: TextStyle(fontSize: 20,color: darkTheme?Colors.white:Colors.black),),
                          ),
                        ),
                        SizedBox(height: 10,),
                      ],
                    ),
                  );
                },


              )
          ),

        ],
      ),
      floatingActionButton:  FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>vehicalDtail()));

      },
        child: Icon(Icons.add),
        backgroundColor: darkTheme ? Colors.amber.shade400 : Colors.blue.shade200,
      ),
    );
  }
}
