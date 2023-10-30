import 'package:bike_rental/globle.dart';
import 'package:bike_rental/vehical_detail.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Admin extends StatefulWidget {
  const Admin({super.key});

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  DatabaseReference vehicalRef = FirebaseDatabase.instance.ref()
      .child('user').child(currentUser!.uid).child('vehicaldetail');
  @override
  Widget build(BuildContext context) {
    bool darkTheme = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
          appBar: AppBar(
            title: Text('Vehical details'),
            backgroundColor: darkTheme?Colors.amber.shade400 : Colors.blue,
            actions: [
              IconButton(onPressed: ()async{
                print(currentUser!.uid);
                await Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Admin()));
              }, icon: Icon(Icons.refresh_outlined,size: 40,)),
              IconButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>vehicalDtail()));
                 }, icon: Icon(Icons.add,size: 40,))
            ],
          ),
      backgroundColor: darkTheme ? Colors.grey.shade800: Colors.white,
      body: Column(
        children: [
          Expanded(
              child: FirebaseAnimatedList(
                query:vehicalRef,
                itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
                  return Column(
                    children: [
                      SizedBox(height: 20,),
                      Container(
                        height: 100,

                        decoration: BoxDecoration(
                          color: Colors.blue.shade200,
                          borderRadius: BorderRadius.circular(10)

                        ),
                        child: ListTile(
                            title: Text(snapshot.child('vehicalname').value.toString(),style: TextStyle(fontSize: 25),),
                            subtitle: Text('''${snapshot.child('colony').value.toString()}, ${snapshot.child('city').value.toString()}''',style: TextStyle(fontSize: 20),),
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

    );
  }
}
