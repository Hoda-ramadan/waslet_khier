import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/card_of_charity.dart';

class StauseRow extends StatelessWidget {
   StauseRow({super.key, required this.personCount , required this.endDate, required this.remaindMoney});
  int personCount =0  ;
  int endDate = 0  ; 
  double remaindMoney =0 ;
  @override
  Widget build(BuildContext context) {
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CardOfCharity(icon: FontAwesomeIcons.person, charitydata: '$personCount' ,charitydataType: "متبرع"),
        SizedBox(width: 20),
        CardOfCharity(icon: Icons.timelapse_outlined,  charitydata: "$endDate" ,charitydataType: "يوم متبقي"),
        SizedBox(width: 20),
        CardOfCharity(
          icon: Icons.attach_money_outlined,
           charitydata: "$remaindMoney" ,charitydataType: "ج.م متبقي"
        ),
      ],
    );
  }
}
