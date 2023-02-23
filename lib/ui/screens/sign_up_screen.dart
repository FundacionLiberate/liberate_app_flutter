import 'dart:io';
import 'package:flutter/material.dart';
import 'package:liberate/controller/signup_controller.dart';
import 'package:liberate/provider/currentUser_provider.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import '../../../constant/strings.dart';
import '../../model/Exception/credentials_exception.dart';
import '../../model/Exception/existing_user_exception.dart';
import '../../model/Exception/wrong_input_exception.dart';
import '../../services/auth_service.dart';
import '../../services/permission_service.dart';
import '../../themes/colors.dart';
import '../generic_widgets/generic_input_widget.dart';
import '../generic_widgets/loading_widget.dart';
import '../generic_widgets/password_input.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final controllerPassword = TextEditingController();
  final controllerRepeatPassword = TextEditingController();
  final controllerEmail = TextEditingController();
  final controllerName = TextEditingController();
  final SignUpController signUpController= SignUpController();
  bool loading=false;

  @override
  void dispose() {
    controllerPassword.dispose();
    controllerEmail.dispose();
    controllerRepeatPassword.dispose();
    controllerName.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final currentUser= Provider.of<CurrentUserProvider>(context);
    final permissionService= Provider.of<PermissionService>(context);
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          backgroundColor:greyBackground,
        ),
        body: Stack(
          children: [
           SingleChildScrollView(
             child:  Column(
               children: [
                 Container(
                   padding: const EdgeInsets.only(
                     bottom: 15
                   ),
                   child: Align(
                     alignment: Alignment.centerLeft,
                     child: Text(
                       Strings.registerText,
                       style:  Theme.of(context).textTheme.headlineMedium,
                     ),
                   ),
                 ),

                 SizedBox(
                   width: double.infinity,
                   child: GenericInput(controller: controllerName,backgroudColor: Colors.white,shadowColor: Colors.grey,title: Strings.nameTitle,enable: true, autofocus: true,),
                 ),

                 const Divider(
                   color: greyBackground,
                 ),

                 SizedBox(
                   width: double.infinity,
                   child: GenericInput(controller: controllerEmail,backgroudColor: Colors.white,shadowColor: Colors.grey,title: Strings.emailTitle,enable: true, autofocus: true,),
                 ),

                 const Divider(
                   color: greyBackground,
                 ),


                 SizedBox(
                     width: double.infinity,
                     child: PasswordInput(controllerEmail: controllerPassword,backgroudColor: Colors.white,shadowColor: Colors.grey,seePassword: true,autofocus: true,title: Strings.passwordTitle)
                 ),

                 const Divider(
                   color: greyBackground,
                 ),


                 SizedBox(
                     width: double.infinity,
                     child: PasswordInput(controllerEmail: controllerRepeatPassword,backgroudColor: Colors.white,shadowColor: Colors.grey,seePassword: true,autofocus: true,title: Strings.repeatPasswordTitle)
                 ),


                 Align(
                   alignment: Alignment.bottomCenter,
                   child: Container(
                       color: Colors.white,
                       width: double.infinity,
                       height: screenSize.height/9,
                       child: Center(
                         child: FractionallySizedBox(
                           heightFactor: 0.6,
                           widthFactor: 0.9,
                           child: ElevatedButton(
                               onPressed: ()async{
                                 try{
                                   setState(() {loading=true;});
                                   if(Platform.isIOS) await permissionService.requestTrackingPermission();
                                   currentUser.setCurrentUser(await signUpController.createUser(controllerEmail.text, controllerName.text, controllerPassword.text, controllerRepeatPassword.text));
                                   setState(() {loading=false;});
                                   if (!mounted) return;
                                   Navigator.pop(context);
                                 }catch (e){
                                   setState(() {loading=false;});
                                   if(e is WrongInputException || e is ExistingUserException || e is CredentialsException){
                                     ScaffoldMessenger.of(context).showSnackBar(
                                       SnackBar(
                                         content: Text(e.toString()),
                                         backgroundColor: Colors.red,
                                       ),
                                     );
                                     Logger().e('Login Error: ${e.toString()}');
                                   }else{
                                     Logger().e('Other Error: ${e.toString()}');
                                   }
                                 }
                               },
                               child: Center(
                                 child: Text(
                                   Strings.loginText,
                                   style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
                                 ),
                               )
                           ),
                         ),
                       )
                   ),
                 ),
               ],
             ),
           ),
            Positioned(
              child: loading
                  ? LoadingWidget()
                  : Container(),
            ),
          ],
        ),
    );
  }
}
