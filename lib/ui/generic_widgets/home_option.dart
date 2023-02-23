import 'package:flutter/material.dart';


class HomeOption extends StatelessWidget {
  const HomeOption({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 2),
        borderRadius: const BorderRadius.all(Radius.circular(10))
      ),
    );
  }
}
