import 'package:flutter/material.dart';
import 'package:waslet_khier/features/home_feature/data/models/state_model.dart';
import 'package:waslet_khier/features/home_feature/views/widgets/states_card.dart';
import 'package:waslet_khier/features/home_feature/views/widgets/states_card_grid_view.dart';

class States extends StatelessWidget {
  const States({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 GestureDetector(
                  onTap: (){},
                   child: Text(
                    'عرض الكل',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                    ),
                   ),
                 ),
                 Text(
                     'الحالات ',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFF05130C),
                  fontSize: 20,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                ),),
                 
              ],
            ),


         StatesCardGridView(),
      ],
    );
  }
}