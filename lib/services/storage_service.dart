import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';


class StorageService {

  final Reference _storageReference=FirebaseStorage.instance.ref();

  Future<String>uploadFile(String path, File file) async{
    Reference reference= _storageReference.child(path);
    UploadTask uploadTask = reference.putFile(file);
    await uploadTask;
    String url=await reference.getDownloadURL();
    return url;
  }

  deleteFile(String fileName) async{
    String path="gs://liberateapp-80bc4.appspot.com/Archivos/$fileName";
    await FirebaseStorage.instance.refFromURL(path).delete();
  }


}