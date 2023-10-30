


import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';


import 'Model.dart';

final FirebaseAuth firebaseAuth =FirebaseAuth.instance;
User? currentUser;
UserModel? userModelCurrentinfo;
String? city;
String? state;


