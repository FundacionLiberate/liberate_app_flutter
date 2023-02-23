import 'package:flutter/cupertino.dart';
import 'package:liberate/model/entities/liberate_user.dart';

class CurrentUserProvider extends ChangeNotifier{

  LiberateUser? currentUser;

  setCurrentUser(LiberateUser user){
    currentUser=user;
    notifyListeners();
  }

  setCurrentUserFromJSON(Map<String, dynamic> json){
    currentUser= LiberateUser.fromJson(json);
    notifyListeners();
  }

  clearCurrentUser(){
    currentUser=LiberateUser();
    notifyListeners();
  }


}