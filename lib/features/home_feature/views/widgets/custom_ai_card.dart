import 'package:flutter/material.dart';
import 'package:waslet_khier/features/home_feature/views/widgets/ai_card_donation_image.dart';
import 'package:waslet_khier/features/home_feature/views/widgets/donate_now_buttom.dart';
import 'package:waslet_khier/features/home_feature/views/widgets/progress_parth_with_label.dart';

class CustomAiCard extends StatelessWidget {
  const CustomAiCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){},
      child: Container(
        height: 180,
        width: 350,
        padding: const EdgeInsets.all(4),
        decoration: ShapeDecoration(
      color: const Color(0xFFF9F7FA),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      shadows: [
        BoxShadow(
          color: Color(0x3F000000),
          blurRadius: 4,
          offset: Offset(4, 4),
          spreadRadius: 0,
        )
      ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left text column
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'إطعام أسرة محتاجة',
                    style: TextStyle(
                      color: Color(0xFF040504),
                      fontSize: 14,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    'توفير كراتين غذائية لأسر مستحقة',
                    style: TextStyle(
                      color: Color(0xFF686B6A),
                      fontSize: 12,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Text('الجمعية: ', style: TextStyle(color: Color(0xFF686B6A), fontSize: 12)),
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: Image.asset('assets/images/masr_elkar.png'),
                      ),
                      Text('مصر الخير:', style: TextStyle(color: Color(0xFF686B6A), fontSize: 12)),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text('المبلغ المطلوب: 10,000 ج.م', style: TextStyle(color: Color(0xFF686B6A), fontSize: 12)),
                  SizedBox(height: 4),
                  Text("50%", style: TextStyle(color: Color(0xFF686B6A), fontSize: 12)),
                  SizedBox(
                    height: 4,
                    child: ProgressBarWithLabel(progress: 0.5),
                  ),
                ],
              ),
            ),
      
            SizedBox(width: 10),
      
            // Right image + button
            Column(
              children: [
                AiCardDonationImage(width: 118, height: 118), // fixed size
                SizedBox(height: 8),
                DonateNowButtom(width: 118, height: 36), // fixed size
              ],
            ),
          ],
        ),
      ),
    );
  }
}