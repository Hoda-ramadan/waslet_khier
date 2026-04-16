import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  const TitleText({required this.caseName});
 final  String caseName ; 
  @override
  Widget build(BuildContext context) {
    return  Text(
     caseName,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }
}
