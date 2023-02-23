import 'package:flutter/material.dart';
import 'package:liberate/themes/colors.dart';
import '../../constant/assetImages.dart';
import '../../constant/routes.dart';
import '../../constant/strings.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(
              left: 15,
              right: 15
          ),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.only(
                    top: 5,
                    bottom: 5
                  ),
                  child: Center(
                    child: Image.asset(AssetImages.logoPath),
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Center(
                  child: Image.asset(AssetImages.welcomeImagePath),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.only(
                    top: 30,
                    bottom: 30
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child:  ElevatedButton(
                            onPressed: (){
                              Navigator.pushNamed(context,Routes.loginScreen);
                            },
                            child:  Center(
                              child: Text(Strings.loginText, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white)),
                            )
                        ),
                      ),
                      const Divider(),
                      Expanded(
                        flex: 1,
                        child:  ElevatedButton(
                            style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                              backgroundColor: MaterialStateProperty.all<Color>(greyBackground),
                              shape: MaterialStateProperty.resolveWith<OutlinedBorder>((_) {
                                return RoundedRectangleBorder(
                                  side: const BorderSide(width: 1.0, color: mainGreen),
                                  borderRadius: BorderRadius.circular(10),
                                );
                              }),
                            ),
                            onPressed: (){
                              Navigator.pushNamed(context,Routes.signUpScreen);
                            },
                            child:  Center(
                              child: Text(Strings.registerText, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: mainGreen)),
                            )
                        ),
                      )
                    ],
                  ),
                )
              )
            ],
          ),
        ),
      )
    );
  }
}
