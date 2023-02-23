import 'package:liberate/model/entities/liberate_user.dart';
import 'package:liberate/services/auth_service.dart';
import 'package:liberate/services/data_validator.dart';
import 'package:liberate/services/database_service.dart';

class SignUpController{

  AuthService authService = AuthService();
  DatabaseService databaseService = DatabaseService();

  createUser(String email, String name, String password, String repeatPassword)async{
    String userUid= await authService.signUp(email, password);
    DataValidator.validateName(name);
    DataValidator.validatePasswordsMatch(password, repeatPassword);
    LiberateUser newUser = LiberateUser.newUser(email, name, userUid, DateTime.now());
    await databaseService.addUser(newUser);
    return newUser;
  }






}