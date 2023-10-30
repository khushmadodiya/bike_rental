import 'package:bike_rental/user_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'globle.dart';

class Location extends StatefulWidget {
  const Location({super.key});

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {

  final cityTextEditingController = TextEditingController();
  final stateTextEditingController = TextEditingController();
  final databaseRef = FirebaseDatabase.instance.ref('user').child(currentUser!.uid);

  final _formkey =GlobalKey<FormState>();
  void _submit()async{
    if(_formkey.currentState!.validate()) {
      if ( firebaseAuth.currentUser != null) {
        if (currentUser != null) {
          Map locMap = {
            "state": stateTextEditingController.text.trim(),
            "city": cityTextEditingController.text.trim(),
          };
          databaseRef.child('location').set(locMap);
        }
        city = cityTextEditingController.text.trim();
        print(city!);
        state = stateTextEditingController.text.trim();
        await Fluttertoast.showToast(msg: "succcessfully enterd");
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (Context) => userScreen()));
      }
      else {
        Fluttertoast.showToast(msg: "Not all fields are valid");
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    bool darkTheme = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: darkTheme ? Colors.grey.shade800: Colors.white,
        body: ListView(
          padding: EdgeInsets.all(10),
          children: [
            SizedBox(
              height: 100,
            ),
            Center(
              child: Text("your Location",
                style: TextStyle(
                  color: darkTheme ? Colors.amber.shade300 : Colors.blue,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40,30,40,50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Form(
                    key:_formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextFormField(
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(50)
                          ],
                          decoration: InputDecoration(
                            hintText: "City",

                            filled: true,
                            fillColor: darkTheme ? Colors.white54 : Colors.black12,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    width: 0,
                                    style: BorderStyle.none
                                )
                            ),
                            prefixIcon: Icon(Icons.person,color: darkTheme ? Colors.amber.shade400: Colors.grey,),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (text){
                            if(text==null || text.isEmpty){
                              return 'Name can\'t be empty';
                            }
                            if(text.length<2){
                              return 'Please Enter a valid Name';
                            }
                            if(text.length>49){
                              return 'Name can\'t be greater than 50';
                            }
                          },
                          onChanged: (text)=>setState(() {
                            cityTextEditingController.text =text;
                          }),
                        ),
                        SizedBox(height: 15,),
                        TextFormField(
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(50)
                          ],
                          decoration: InputDecoration(
                            hintText: "state",
                            hintStyle: TextStyle(
                                color: Colors.grey.shade800,
                                fontSize: 20
                            ),
                            filled: true,
                            fillColor: darkTheme ? Colors.white54 : Colors.black12,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    width: 0,
                                    style: BorderStyle.none
                                )
                            ),
                            prefixIcon: Icon(Icons.person,color: darkTheme ? Colors.amber.shade400: Colors.grey,),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (text){
                            if(text==null || text.isEmpty){
                              return 'state can\'t be empty';
                            }
                            if(text.length<2){
                              return 'Please Enter a valid state';
                            }
                            if(text.length>49){
                              return 'state can\'t be greater than 50';
                            }
                          },
                          onChanged: (text)=>setState(() {
                            stateTextEditingController.text =text;
                          }),
                        ),
                        SizedBox(height: 15,),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: darkTheme ? Colors.amber.shade400 : Colors.blue,
                              onPrimary: darkTheme ? Colors.black : Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),

                              ),
                              minimumSize: Size(double.infinity, 50)

                          ),
                          onPressed: (){
                            _submit();
                          }, child: Text("Submit"),


                        ),
                        SizedBox(height: 20,),

                      ],
                    ),
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
