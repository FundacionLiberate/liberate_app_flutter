import 'package:flutter/material.dart';
import 'package:liberate/constant/assetImages.dart';
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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBar(
          title: SizedBox(
            height: 200,
            width: double.infinity,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(Strings.profileTitle, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold))
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Image.asset(AssetImages.logoPath),
                ),
                Expanded(
                  flex: 1,
                  child: Container(),
                )
              ],
            ),
          )
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Consumer<CurrentUserProvider>(
            builder: (context, data, child) {
              return  Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(Strings.nameTitle, style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 22),textAlign: TextAlign.start,),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(data.currentUser!.nombre, style: const TextStyle(color: Colors.grey),textAlign: TextAlign.start),
                  ),

                  const Divider(),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(Strings.emailTitle, style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 22)),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(data.currentUser!.email, style: const TextStyle(color: Colors.grey,)),
                  ),

                  const Divider(),

                  Align(
                      alignment: Alignment.centerLeft,
                      child:  InkWell(
                        onTap: (){
                          authService.signOut();
                          currentUser.clearCurrentUser();
                        },
                        child: Text(Strings.signOutTitle, style: const TextStyle(color: Colors.red,fontSize: 20),),
                      )
                  ),


                ],
              );
            }
        ),
      )
    );
  }
}

/*
*
*
* */