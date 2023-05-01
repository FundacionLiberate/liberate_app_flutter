import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:liberate/model/entities/liberate_type.dart';
import 'package:liberate/model/entities/liberate_user.dart';

class DatabaseService{

   final users = FirebaseFirestore.instance.collection('Users');
   final files = FirebaseFirestore.instance.collection('Archivos');
   final types = FirebaseFirestore.instance.collection('Tipos');


   Stream<DocumentSnapshot<Map<String, dynamic>>> currentUser(String userId){
     return users.doc(userId).snapshots();
   }


   Stream<QuerySnapshot<Map<String, dynamic>>> getCategoryTypeFiles(String categoryType){
     return files.where("tipo",isEqualTo: categoryType).snapshots();
   }



   Stream<QuerySnapshot<Map<String, dynamic>>> getStreamTipos(){
     return types.snapshots();
   }


   Future<bool> addUser(LiberateUser user) async{
     try {
       await users.doc(user.uid).set(user.toJson());
       return true;
     } catch (e) {
       return Future.error(e);
     }
   }


   Future<bool> addType(LiberateType type) async{
     try {
       DocumentReference reference= files.doc();
       type.id=reference.id;
       await files.doc(type.id).set(type.toJson());
       return true;
     } catch (e) {
       return Future.error(e);
     }
   }


   Future<bool> deleteType(String id) async{
     try {
       await files.doc(id).delete();
       return true;
     } catch (e) {
       return Future.error(e);
     }
   }


}
