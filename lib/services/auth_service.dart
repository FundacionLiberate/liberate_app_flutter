import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

import '../model/Exception/credentials_exception.dart';
import 'data_validator.dart';


class AuthService{

  static final _auth = FirebaseAuth.instance;
  Stream<User?> get authStatus=>_auth.authStateChanges();


  login(String email, String password) async{
    DataValidator.validateEmailPassword(email.trim(), password);
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email.trim(), password: password);
    }catch(e){
      throw CredentialsException(message: "Correo o contraseña inválida.");
    }
    Logger().i("Login successfully!!!");
  }


  Future<String>signUp(String email, String password) async{
    DataValidator.validateEmailPassword(email.trim(), password);
    await _auth.createUserWithEmailAndPassword(email: email.trim(), password:password);
    return  _auth.currentUser!.uid;
  }


  Future<void> signOut() async {
    await _auth.signOut();
  }


}