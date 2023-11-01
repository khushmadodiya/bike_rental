import 'package:bike_rental/user_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
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

  final  cityTextEditingController = TextEditingController();
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
    DatabaseReference pRef = FirebaseDatabase.instance.ref('public');
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
              height: 50,
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
              padding: const EdgeInsets.fromLTRB(40,20,40,40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Form(
                    key:_formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(height: 150,width: 250,
                           decoration: BoxDecoration(
                             color: darkTheme ? Colors.grey.shade400:Colors.blue.shade100,
                             borderRadius: BorderRadius.circular(20)
                           ),

                            child: FirebaseAnimatedList(
                              query:pRef,
                              itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
                                final title = Text(snapshot.child('city').value.toString());
                                if(cityTextEditingController.text.isEmpty){
                                  print(title);
                                  return Container();
                                }
                                else if(title.toString().contains(cityTextEditingController.text.toLowerCase().toLowerCase())){
                                 return InkWell(
                                   child: ListTile(
                                            title: Text(snapshot.child('city').value.toString(),style: TextStyle(fontSize: 20),),
                                     subtitle: Text('''${snapshot.child('colony').value.toString()}, ${snapshot.child('city').value.toString()}''',style: TextStyle(fontSize: 20),),

                                   ),
                                   onTap: (){
                                     setState(() {
                                       cityTextEditingController.text = snapshot.child('city').value.toString();
                                       stateTextEditingController.text=snapshot.child('state').value.toString();
                                     });

                                   },
                                 );


                                }
                                else{
                                  Container(child: Text('else'),);
                                }
                                return Container();
                              },


                            )
                        ),
                        SizedBox(height: 10,),
                        TextFormField(
                          controller: cityTextEditingController,
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
                              return 'city can\'t be empty';
                            }
                            if(text.length<2){
                              return 'city Enter a valid Name';
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
                          controller: stateTextEditingController,
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
                              return 'state Enter a valid state';
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
