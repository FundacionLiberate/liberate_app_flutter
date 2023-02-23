import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constant/assetImages.dart';
import '../../constant/strings.dart';
import '../../provider/currentUser_provider.dart';
import '../generic_widgets/home_option.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final currentUser= Provider.of<CurrentUserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(Strings.homeTitle, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        ),
      ),
      body:Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: Align(
                alignment: Alignment.center,
                child: GridView(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,childAspectRatio: 0.8, crossAxisSpacing: 20, mainAxisSpacing: 20),
                  children: [
                    HomeOption(title: Strings.informesTitle, imagePath: AssetImages.informeIconPath),
                    HomeOption(title: Strings.boletinesTitle, imagePath:AssetImages.boletinIconPath),
                    HomeOption(title: Strings.revistasTitle, imagePath:AssetImages.magazineIconPath),
                    HomeOption(title: Strings.capacitacionesTitle, imagePath:AssetImages.capacitacionesIconPath ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(

              ),
            )
          ],
        ),
      )
    );
  }
}
