import 'package:firebase_database/firebase_database.dart';

import 'Model.dart';
import 'globle.dart';

class AssistantMethod {
  static void readCurrenOnlinUserInfo() async {
    currentUser = firebaseAuth.currentUser;
    DatabaseReference userRef = FirebaseDatabase.instance.ref()
        .child('user')
        .child(currentUser!.uid);
    userRef.once().then((snap) {
      if (snap.snapshot.value != null) {
        userModelCurrentinfo = UserModel.fromSnapshot(snap.snapshot);
      }
    });
  }
}