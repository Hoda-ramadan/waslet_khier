import 'package:flutter/material.dart';
import 'package:waslet_khier/features/home_feature/views/widgets/charites_card_grid_veiw.dart';

class Charities extends StatelessWidget {
  const Charities({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
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
            'الجمعيات الخيرية',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: const Color(0xFF05130C),
              fontSize: 20,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w700,
            ),),
             
          ],
        ),
        SizedBox(
          height: 10,
        ),
        CharitesCardGridVeiw()
      
      
       ],
      ),
    );
}
}