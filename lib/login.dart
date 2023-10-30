

import 'package:bike_rental/Assistant_method.dart';
import 'package:bike_rental/Mainscreen.dart';
import 'package:bike_rental/signup.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import 'globle.dart';

class logIn extends StatefulWidget{
  @override
  State<logIn> createState() => _logInState();
}

class _logInState extends State<logIn> {
  final emailTextEditingController = TextEditingController();
  final passwordTextEditingController = TextEditingController();
  bool _passwordvisibal =false;

  final _formkey =GlobalKey<FormState>();
  void _submit()async{
    if(_formkey.currentState!.validate()) {
      await firebaseAuth.signInWithEmailAndPassword(email: emailTextEditingController.text, password: passwordTextEditingController.text).then((auth) async {
      currentUser = auth.user;
        await Fluttertoast.showToast(msg: "succcessfully Login");
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (Context) => mainScreen()));
      }).catchError((errorMessage) {
        Fluttertoast.showToast(msg: "Error occured: \n $errorMessage");
        print(errorMessage);
      });
    }
    else{
      Fluttertoast.showToast(msg: "Not all fields are valid");
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
        body: ListView(
          padding: EdgeInsets.all(10),
          children: [
            SizedBox(
              height: 100,
            ),
            Center(
              child: Text("Log IN",
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
                            hintText: "Email",
                            hintStyle: TextStyle(
                                color: Colors.grey.shade800,
                                fontSize: 20
                            ),
                            filled: true,
                            fillColor: darkTheme ? Colors.black26 : Colors.black12,
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
                              return 'Email can\'t be empty';
                            }
                            if(text.length<2){
                              return 'Please Enter a valid Email';
                            }
                            if(EmailValidator.validate(text)==true){
                              return null;
                            }
                            if(text.length>49){
                              return 'Email can\'t be greater than 50';
                            }

                          },
                          onChanged: (text)=>setState(() {
                            emailTextEditingController.text =text;
                          }),
                        ),
                        SizedBox(height: 20,),
                        TextFormField(
                          obscureText: !_passwordvisibal,

                          inputFormatters: [
                            LengthLimitingTextInputFormatter(50)
                          ],
                          decoration: InputDecoration(
                            hintText: "Password",
                            hintStyle: TextStyle(
                                color: Colors.grey.shade800,
                                fontSize: 20

                            ),
                            filled: true,
                            fillColor: darkTheme ? Colors.black26 : Colors.black12,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    width: 0,
                                    style: BorderStyle.none
                                )
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _passwordvisibal ? Icons.visibility : Icons.visibility_off,
                                color: darkTheme ? Colors.amber.shade400 : Colors.grey,
                              ), onPressed: () {
                              setState(() {
                                _passwordvisibal =!_passwordvisibal;
                              });
                            },
                            ),
                            prefixIcon: Icon(Icons.password,color: darkTheme ? Colors.amber.shade400: Colors.grey,),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (text){
                            if(text==null || text.isEmpty){
                              return 'Password can\'t be empty';
                            }
                            if(text.length<2){
                              return 'Please Enter a valid password';
                            }
                            if(text.length>49){
                              return 'Password can\'t be greater than 50';
                            }
                            return null;
                          },
                          onChanged: (text)=>setState(() {
                            passwordTextEditingController.text =text;
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
                          }, child: Text("LogIn"),


                        ),
                        SizedBox(height: 20,),
                        GestureDetector(
                          onTap: (){
                            // Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgetPassword()));
                          },
                          child: Text(
                            'Forgort password',style: TextStyle(color: darkTheme ? Colors.amber.shade400 : Colors.blue

                          ),
                          ),
                        ),
                        SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("have an account",
                              style:TextStyle(color: Colors.grey,fontSize: 15) ,),
                            SizedBox(width: 5,),
                            GestureDetector(
                              onTap: (){
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>register()));
                              },
                              child: Text(
                                'Register',style: TextStyle(fontSize: 15,
                                  color: darkTheme ? Colors.amber.shade400 : Colors.blue ),
                              ),
                            )
                          ],
                        )


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
