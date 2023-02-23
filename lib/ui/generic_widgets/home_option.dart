import 'package:flutter/material.dart';

import '../../constant/assetImages.dart';


class HomeOption extends StatelessWidget {
  String title;
  String imagePath;
  HomeOption({Key? key,required this.title, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 2),
        borderRadius: const BorderRadius.all(Radius.circular(10))
      ),
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.all(25),
              child: Image.asset(imagePath),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text(title,style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.grey),),
            ),
          )
        ],
      ),
    );
  }
}
