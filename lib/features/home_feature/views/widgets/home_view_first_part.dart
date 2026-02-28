import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:waslet_khier/const.dart';

class HomeViewFirstPart extends StatelessWidget {
  const HomeViewFirstPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Row(
        children: [
          Column(
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: IconButton(onPressed :(){},icon :Icon(FontAwesomeIcons.calculator
                ,color: tintAppColor ,)),
              ),
              SizedBox(height: 8,),
              Text('حساب الذكاه',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 12, 
                fontWeight: FontWeight.w500,
                color: Colors.black
              ),
              ),
            ],
          ),
          Spacer(),
           Text('مقترح بالذكاء الصناعي',
           style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 16, 
                fontWeight: FontWeight.w500,
                color: Colors.black),),
           Icon(Icons.error, 
           color: tintAppColor,)
        ],
      ),
    );
  }
}