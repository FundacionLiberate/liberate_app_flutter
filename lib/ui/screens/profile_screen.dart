import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constant/strings.dart';
import '../../provider/currentUser_provider.dart';
import '../../services/auth_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final authService= Provider.of<AuthService>(context);
    final currentUser= Provider.of<CurrentUserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(Strings.profileTitle, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        ),
        actions: [
         Padding(
           padding: const EdgeInsets.only(
             right: 20
           ),
           child: Align(
               alignment: Alignment.center,
               child:  InkWell(
                 onTap: (){
                   authService.signOut();
                   currentUser.clearCurrentUser();
                 },
                 child: Text(Strings.signOutTitle, style: const TextStyle(color: Colors.red, ),),
               )
           ),
         )
        ],
      ),
    );
  }
}
