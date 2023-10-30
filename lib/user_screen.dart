import 'package:bike_rental/select_loc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class userScreen extends StatefulWidget {
  const userScreen({super.key});

  @override
  State<userScreen> createState() => _userScreenState();
}

class _userScreenState extends State<userScreen> {

  @override
  Widget build(BuildContext context) {
    bool darkTheme = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: Text('Vehicals'),
        backgroundColor:darkTheme ? Colors.amber.shade400 : Colors.blue ,
        actions: [
          IconButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Location()));
          },
          icon: Icon(Icons.location_on_outlined,size: 40,))
        ],
      ),
    );
  }
}
