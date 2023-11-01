import 'package:bike_rental/user_screen.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'globle.dart';

class bookingScreen extends StatefulWidget {
  const bookingScreen({super.key});

  @override
  State<bookingScreen> createState() => _bookingScreenState();
}

class _bookingScreenState extends State<bookingScreen> {

final pickdateTextEditingController = TextEditingController();
final returndateTextEditingController = TextEditingController();
  final timeTextEditingController = TextEditingController();
  final paymodeTextEditingController = TextEditingController();
  List<String> typelist = ['Online Mode','Offline Mode'];
  String? selectedtype;
final bookuseringRef = FirebaseDatabase.instance.ref('user').child(currentUser!.uid);
final bookadminRef = FirebaseDatabase.instance.ref('user').child(currentUser!.uid);

  final _formkey =GlobalKey<FormState>();
void _submit()async{
  if(_formkey.currentState!.validate()) {
    if (await firebaseAuth.currentUser != null) {
      if (currentUser != null) {
        Map vehicalMap = {
          "vehicalname": pickdateTextEditingController.text.trim(),
          "vehicaltype": returndateTextEditingController.text.trim(),
          "vehicalnumber": timeTextEditingController.text.trim(),
          "state": paymodeTextEditingController.text.trim(),

        };
        bookadminRef.child('vehicaldetail').child(DateTime.now().millisecond.toString()).set(vehicalMap);
        bookuseringRef.child(DateTime.now().millisecond.toString()).set(vehicalMap);

      }
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
        appBar: AppBar(title: Text("Book Your Bike Now"),backgroundColor: darkTheme ? Colors.amber.shade400 : Colors.blue,),
        backgroundColor: darkTheme ? Colors.black87 : Colors.white,
        body: ListView(
          padding: EdgeInsets.all(10),
          children: [
            SizedBox(
              height: 100,
            ),
            Center(
              child: Text("Rent ₹2000/day",
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
                          controller: pickdateTextEditingController,
                          readOnly: true,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(50)
                          ],
                          decoration: InputDecoration(
                            hintText: "Select Date pickup date",
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
                            prefixIcon: Icon(Icons.date_range,color: darkTheme ? Colors.amber.shade400: Colors.grey,),
                          ),
                          onTap: ()async{
                             DateTime? datepicker = await showDatePicker(
                                 context: context,
                                 initialDate: DateTime.now(),
                                 firstDate: DateTime.now(),
                                 lastDate: DateTime(2050),
                             );
                             var date = "${datepicker?.day} - ${datepicker?.month} - ${datepicker?.year}";
                             print(date);
                             pickdateTextEditingController.text = date;
                          },
                        ),
                        SizedBox(height: 15,),
                        TextFormField(
                          controller: returndateTextEditingController,
                          readOnly: true,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(50)
                          ],
                          decoration: InputDecoration(
                            hintText: "Select return date",
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
                            prefixIcon: Icon(Icons.date_range,color: darkTheme ? Colors.amber.shade400: Colors.grey,),
                          ),
                          onTap: ()async{
                             DateTime? datepicker = await showDatePicker(
                                 context: context,
                                 initialDate: DateTime.now(),
                                 firstDate: DateTime.now(),
                                 lastDate: DateTime(2050),
                             );
                             var date = "${datepicker?.day} - ${datepicker?.month} - ${datepicker?.year}";
                             print(date);
                             returndateTextEditingController.text = date;
                          },
                        ),
                        SizedBox(height: 15,),
                        TextFormField(
                          controller: timeTextEditingController,
                          readOnly: true,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(50)
                          ],
                          decoration: InputDecoration(
                            hintText: "Select Time",
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
                            prefixIcon: Icon(Icons.lock_clock,color: darkTheme ? Colors.amber.shade400: Colors.grey,),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onTap: ()async{
                            TimeOfDay? timepicker = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                            );
                            var time = "${timepicker?.hour} : ${timepicker?.minute}  ${timepicker?.period.name}";

                            print(time);
                            timeTextEditingController.text = time;
                          },

                        ),
                        SizedBox(height: 10,),
                        Container(
                          width: 200,

                          decoration: BoxDecoration(
                            color: darkTheme ? Colors.white54 : Colors.black12,
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: Center(
                            child: DropdownButton(
                                hint: Text("Payment Mode",style: TextStyle(color: Colors.grey.shade100),),
                                value: selectedtype,
                                onChanged: (newValue){
                                     setState(() {
                                       selectedtype = newValue.toString();
                                       paymodeTextEditingController.text = selectedtype.toString();
                                     });
                                },
                                items: typelist.map((mode) {
                                  return DropdownMenuItem(child:
                                         Text(mode , style: TextStyle(color: Colors.grey.shade800,),

                                         ),
                                    value: mode,

                                  );
                                }).toList(),
                            ),
                          ),
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
                          }, child: Text("Book Now"),


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
