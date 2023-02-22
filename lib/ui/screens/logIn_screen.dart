import 'dart:io';
import 'package:flutter/material.dart';
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


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final controllerPassword = TextEditingController();
  final controllerEmail = TextEditingController();
  bool loading=false;

  @override
  void dispose() {
    controllerPassword.dispose();
    controllerEmail.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final authService= Provider.of<AuthService>(context);
    final permissionService= Provider.of<PermissionService>(context);
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          backgroundColor:greyBackground,
        ),
        body: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: screenSize.height/14,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      Strings.loginText,
                      style:  Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  child: GenericInput(controller: controllerEmail,backgroudColor: Colors.white,shadowColor: Colors.grey,title: Strings.emailTitle,enable: true, autofocus: true,),
                ),
                const Divider(
                  color: greyBackground,
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  child: PasswordInput(controllerEmail: controllerPassword,backgroudColor: Colors.white,shadowColor: Colors.grey,seePassword: true,autofocus: true,title: Strings.passwordTitle,)
                ),
                Expanded(
                  child: Align(
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
                                    await authService.login(controllerEmail.text,controllerPassword.text);
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
                )
              ],
            ),

            Positioned(
              child: loading
                  ? LoadingWidget()
                  : Container(),
            ),
          ],
        )
    );
  }
}

