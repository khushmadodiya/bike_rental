


import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';


import 'Model.dart';

final FirebaseAuth firebaseAuth =FirebaseAuth.instance;
User? currentUser;
UserModel? userModelCurrentinfo;
DatabaseReference vehicalRef = FirebaseDatabase.instance.ref()
    .child('user').child(currentUser!.uid).child('vehicaldetail');
DatabaseReference locRef = FirebaseDatabase.instance.ref()
    .child('user').child(currentUser!.uid).child('location');
