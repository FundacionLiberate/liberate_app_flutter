import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:liberate/model/entities/liberate_user.dart';

class DatabaseService{

   final users = FirebaseFirestore.instance.collection('Users');

   Future<bool> addUser(LiberateUser user) async{
    try {
      await users.doc(user.uid).set(user.toJson());
      return true;
    } catch (e) {
      return Future.error(e);
    }
  }


   Stream<DocumentSnapshot<Map<String, dynamic>>> currentUser(String userId){
     return users.doc(userId).snapshots();
   }



}
