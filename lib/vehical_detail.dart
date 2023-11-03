

import 'package:bike_rental/admin.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import 'Assistant_method.dart';
import 'globle.dart';
import 'login.dart';


class vehicalDtail extends StatefulWidget{
  @override
  State<vehicalDtail> createState() => _vehicalDtailState();
}

class _vehicalDtailState extends State<vehicalDtail> {


  final vehicalnameTextEditingController = TextEditingController();
  final vehicaltypeTextEditingController = TextEditingController();
  final vehicalnumberTextEditingController = TextEditingController();
  final stateTextEditingController = TextEditingController();
  final cityTextEditingController = TextEditingController();
  final colonyTextEditingController = TextEditingController();
  final databaseRef = FirebaseDatabase.instance.ref('user').child(currentUser!.uid);
  final publicRef = FirebaseDatabase.instance.ref('public');


  final _formkey =GlobalKey<FormState>();
  void _submit()async{
    if(_formkey.currentState!.validate()) {
      if (await firebaseAuth.currentUser != null) {
        if (currentUser != null) {
          Map vehicalMap = {
            "vehicalname": vehicalnameTextEditingController.text.trim(),
            "vehicaltype": vehicaltypeTextEditingController.text.trim(),
            "vehicalnumber": vehicalnumberTextEditingController.text.trim(),
            "state": stateTextEditingController.text.trim(),
            "city": cityTextEditingController.text.trim(),
            "colony": colonyTextEditingController.text.trim(),
            "status":"0",
          };
          Map publiclMap = {
            "id": currentUser!.uid,
            "vehicalname": vehicalnameTextEditingController.text.trim(),
            "vehicaltype": vehicaltypeTextEditingController.text.trim(),
            "vehicalnumber": vehicalnumberTextEditingController.text.trim(),
            "state": stateTextEditingController.text.trim(),
            "city": cityTextEditingController.text.trim(),
            "colony": colonyTextEditingController.text.trim(),
            "status":"0"
          };
          databaseRef.child('vehicaldetail').child(vehicalnumberTextEditingController.text.trim()).set(vehicalMap);
          publicRef.child(DateTime.now().millisecond.toString()).set(publiclMap);

        }
        await Fluttertoast.showToast(msg: "succcessfully enterd");
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (Context) => Admin()));
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
        backgroundColor: darkTheme ? Colors.black87: Colors.white,
        body: ListView(
          padding: EdgeInsets.all(10),
          children: [
            SizedBox(
              height: 100,
            ),
            Center(
              child: Text("Vehical Detail",
                style: TextStyle(
                  color: darkTheme ? Colors.amber.shade400 : Colors.blue,
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
                            hintText: "Vehical Name",
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
                            vehicalnameTextEditingController.text =text;
                          }),
                        ),
                        SizedBox(height: 15,),
                        TextFormField(
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(50)
                          ],
                          decoration: InputDecoration(
                            hintText: "Vehical type(car or bike)",

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
                              return 'Vehical type can\'t be empty';
                            }
                            if(text.length<2){
                              return 'Please Enter a valid Vehical type';
                            }
                            if(text.length>49){
                              return 'Vehical type can\'t be greater than 50';
                            }


                          },
                          onChanged: (text)=>setState(() {
                            vehicaltypeTextEditingController.text =text;
                          }),
                        ),
                        SizedBox(height: 20,),
                        TextFormField(
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(50)
                          ],
                          decoration: InputDecoration(
                            hintText: "Vehical Number",
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
                              return 'Vehical Number can\'t be empty';
                            }
                            if(text.length<2){
                              return 'Please Enter a valid Vehical Number';
                            }
                            if(text.length>49){
                              return 'Vehical Number can\'t be greater than 50';
                            }

                          },
                          onChanged: (text)=>setState(() {
                            vehicalnumberTextEditingController.text =text;
                          }),
                        ),
                        SizedBox(height: 8,),
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
                        TextFormField(
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(50)
                          ],
                          decoration: InputDecoration(
                            hintText: "city",
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
                              return 'city can\'t be empty';
                            }
                            if(text.length<2){
                              return 'Please Enter a valid city';
                            }
                            if(text.length>49){
                              return 'city can\'t be greater than 50';
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
                            hintText: "colony",
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
                              return 'colony can\'t be empty';
                            }
                            if(text.length<2){
                              return 'Please Enter a valid colony';
                            }
                            if(text.length>49){
                              return 'colony can\'t be greater than 50';
                            }
                          },
                          onChanged: (text)=>setState(() {
                            colonyTextEditingController.text =text;
                          }),
                        ),
                        SizedBox(height: 20,),
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