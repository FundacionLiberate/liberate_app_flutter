import 'package:liberate/util/text_utils.dart';

import '../model/Exception/wrong_input_exception.dart';


class DataValidator{


  static validateEmailPassword(String email, String password){
    if(email.isEmpty || email.isEmail()==false || email.endsWith("@fundacionliberate.org.co")){
      throw WrongInputException(message: "Ingresa un email válido.");
    }else if(password.isEmpty || password.length<8){
      throw WrongInputException(message: "Ingresa una contraseña válida. (Min:8 caracteres).");
    }
  }






}