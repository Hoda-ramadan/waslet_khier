import 'package:flutter/material.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/features/home_feature/data/models/charity_model.dart';

class CharitesCard extends StatelessWidget {
  const CharitesCard({super.key, required this.charityModel});
   final CharityModel charityModel;
  @override
  Widget build(BuildContext context) {
    return Container(

  padding: const EdgeInsets.symmetric(vertical: 4),
  decoration: ShapeDecoration(
    color: Colors.white,
    shape: RoundedRectangleBorder(
      side: BorderSide(
        width: 0.20,
        color: appcolor,
      ),
      borderRadius: BorderRadius.circular(10),
      
    ),
  ),
  
  child: Center(
    child: Column(
       mainAxisAlignment: MainAxisAlignment.center,
  crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        
            Image.asset(charityModel.image),
            
            
             const SizedBox(
              height: 4,
             ),
           SizedBox(
    
    child: Text(
      charityModel.name,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: const Color(0xFF040504),
        fontSize: 10,
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w700,
      ),
    ),
    )
      ],
    ),
  )
  );
  }
}