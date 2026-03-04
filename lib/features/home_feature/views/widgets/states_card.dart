import 'package:flutter/material.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/features/home_feature/data/models/state_model.dart';
import 'package:waslet_khier/features/home_feature/views/widgets/detals_buttom.dart';
import 'package:waslet_khier/features/home_feature/views/widgets/donate_now_buttom.dart';
import 'package:waslet_khier/features/home_feature/views/widgets/progress_parth_with_label.dart';

class StatesCard extends StatelessWidget {
  const StatesCard({super.key, required this.stateModel});
final StateModel stateModel ;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width:  175,
      
        
        decoration: ShapeDecoration(
      color:  Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      shadows: [
        BoxShadow(
          color: Color(0x19000000),
          blurRadius: 4,
          offset: Offset(4, 4),
          spreadRadius: 0,
        )
      ],
        ),
        child: Column(
      children: [
        Container(
          width: 175,
          height: 109,
          decoration: ShapeDecoration(
            image: DecorationImage(
        image: AssetImage(stateModel!.statesImage),
        fit: BoxFit.cover,
            ),
            shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
            ),
          ),
        ),
      
         Padding(
       padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 16),
       child: Column(
         
         children: [
           SizedBox(
             width: 154,
             child: Text(
            stateModel.stateName,
            textAlign: TextAlign.right,
            style: TextStyle(
              color: const Color(0xFF040504),
              fontSize: 10,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w500,
            ),
             ),
           ), 
           
             Text(
              stateModel.stateDecription,
            textAlign: TextAlign.right,
            style: TextStyle(
              color: const Color(0xFF686B6A) /* gray-dark */,
              fontSize: 6,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
            ),
             ),  
             Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
             
              Text(
              stateModel.stateOrganzatio,  textAlign: TextAlign.right,
              style: TextStyle(
                color: const Color(0xFF686B6A),
                fontSize: 8,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
              ),
              ),
                Image.asset('assets/images/bx_buildings.png' ,width: 16,
              height: 16,),
            ],
             ), 
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
            Text(
              stateModel.persantage.toString()+'%',
              textAlign: TextAlign.left,
              style: TextStyle(
                color: const Color(0xFF686B6A) /* gray-dark */,
                fontSize: 12,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
             'المبلغ المتبقي:\n',
             textAlign: TextAlign.end,
                  style: TextStyle(
                    color: const Color(0xFF686B6A) /* gray-dark */,
                    fontSize: 6,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                  ),
            ),
             ],
           ), 
           Text(stateModel.remandMony.toString(),
           textAlign: TextAlign.end,
                  style: TextStyle(
                    color: appcolor,
                    fontSize: 6,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                  ),),
                  SizedBox(
                    height: 2,
                    child: ProgressBarWithLabel(progress: 0.5)),
                    SizedBox(
                      height: 5
                    ), 
           
                  Row(
                    children: [
                      DetalsButtom(fontSize: 10,width: 75,
                      height: 28,
                      ),
                      SizedBox(width: 5,),
                      DonateNowButtom(width: 75,
                      height: 28,
                      fontSize: 10,
                      ),
                    ],
                  ),
         ],
       ),
         )
      ],
        ),
        ),
    );
  }
}