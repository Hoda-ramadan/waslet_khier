import 'package:flutter/material.dart';
import 'package:waslet_khier/core/class/assets.dart';
import 'package:waslet_khier/features/profile_feature/views/widgets/persoinalinfo_view.dart';

class AboutAppBody extends StatelessWidget {
  const AboutAppBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          customappbar(text: 'حول التطبيق '),
          SizedBox(height: 20),
          Container(
            width: 218,
            //  height: 218,
            child: Image.asset(Assets.logoimage, fit: BoxFit.fill),
          ),
          Text(
            "وصلة خير هو تطبيق يهدف إلى تسهيل عملية التبرع وربط المتبرعين بالحالات الإنسانية والجمعيات الخيرية الموثوقة. نساعدك في الوصول للحالات الأكثر احتياجًا والتبرع بسهولة وأمان، لتكون سببًا في إحداث فرق حقيقي في حياة الآخرين.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}
