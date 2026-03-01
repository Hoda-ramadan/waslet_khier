import 'package:flutter/material.dart';
import 'package:waslet_khier/features/home_feature/data/models/charity_model.dart';
import 'package:waslet_khier/features/home_feature/views/widgets/charites_card.dart';

final List<CharityModel> charities = [
  CharityModel(
    image: 'assets/images/أهل مصر.png',
    name: 'مستشفى أهل مصر',
  ),
  CharityModel(
    image: 'assets/images/رسالة.png',
    name: 'جمعية رسالة',
  ),
  CharityModel(
    image: 'assets/images/57357.png',
    name: 'مستشفى 57357',
  ),
  CharityModel(
    image: 'assets/images/بنك الطعام.png',
    name: 'بنك الطعام',
  ),
  CharityModel(
    image: 'assets/images/مركز علاج الاورام.png',
    name: 'مركز علاج الاورام',
  ),

   CharityModel(
    image: 'assets/images/مجدي يعقوب.png',
    name: 'مجدي يعقوب.',
  ),
    CharityModel(
    image: 'assets/images/masr_elkar.png',
    name:    'مؤسسة مصر الخير',

  ),
    CharityModel(
    image: 'assets/images/مستشفي500500.png',
    name:      'مستشفي 500500',


  ),

];
class CharitesCardGridVeiw extends StatelessWidget {
  const CharitesCardGridVeiw({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: GridView.builder(
        itemCount: charities.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4,
        mainAxisSpacing: 8,
        crossAxisSpacing: 16,
        mainAxisExtent: 70
        
        ), itemBuilder: (context,index)
        
        {
           return CharitesCard(charityModel: charities[index]);
        }),
    );

  }
}