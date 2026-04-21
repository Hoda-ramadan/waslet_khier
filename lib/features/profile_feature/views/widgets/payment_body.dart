import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/pymentoption_item.dart';
import 'package:waslet_khier/features/profile_feature/views/widgets/persoinalinfo_view.dart';

class Payment_body extends StatelessWidget {
  const Payment_body({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          customappbar(text: "طرق التبرع "),
          SizedBox(height: 20),
          Text(
            "بنوفرلك طرق كتيير للتبرع وتقديم المساعدة لأكثر من 40 جمعية و مؤسسة خيرية في مصر.",
            style: TextStyle(
              fontFamily: "Roboto",
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  context.push("/profile/PaymentwayView/CardPaymentView");
                },
                child: PymentoptionItem(image: "assets/Frame 390.png"),
              ),

              GestureDetector(
                onTap: () {
                  context.push("/profile/PaymentwayView/CardPaymentView");
                },
                child: PymentoptionItem(image: "assets/Frame 390.png"),
              ),

              GestureDetector(
                onTap: () {
                  context.push("/profile/PaymentwayView/CardPaymentView");
                },
                child: PymentoptionItem(image: "assets/Frame 390.png"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
