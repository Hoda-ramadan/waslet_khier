import 'package:flutter/material.dart';
import 'package:waslet_khier/features/profile_feature/views/widgets/CustompayCard.dart';
import 'package:waslet_khier/features/profile_feature/views/widgets/defer_textfield.dart';
import 'package:waslet_khier/features/profile_feature/views/widgets/persoinalinfo_view.dart';
import 'package:waslet_khier/features/profile_feature/views/widgets/textformfile.dart';

class PaymentView_Bankbody extends StatelessWidget {
  const PaymentView_Bankbody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customappbar(text: "تبرع آمن "),
              const SizedBox(height: 30),

              Center(
                child: Column(
                  children: [
                    Text(
                      "الدفع ب فيزا",
                      style: TextStyle(
                        fontFamily: "Roboto",
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "تبرع آمن يدعم مشاريعنا الخيرية",
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 15),

              Center(
                child: Image.asset(
                  "assets/images/no-data/mobile-payments/pana.png",
                  height: 150,
                ),
              ),

              const SizedBox(height: 20),

              Text(
                "اختر مبلغ التبرع",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ),

              const SizedBox(height: 10),

              Row(
                children: const [
                  Expanded(child: CustomPayCard(txt: "50")),
                  SizedBox(width: 10),
                  Expanded(child: CustomPayCard(txt: "100")),
                  SizedBox(width: 10),
                  Expanded(child: CustomPayCard(txt: "500")),
                ],
              ),

              const SizedBox(height: 20),

              CustomTextfieldForPayment(),

              const SizedBox(height: 20),

              Text(
                "معلومات البطاقة",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ),

              const SizedBox(height: 10),

              customField(label: "اسم حامل البطاقة", hint: "مثال: نورهان فيصل"),

              const SizedBox(height: 10),

              customField(label: "رقم البطاقة", hint: "0000 0000 0000 0000"),

              const SizedBox(height: 10),

              Row(
                children: [
                  Expanded(
                    child: customField(label: "تاريخ الانتهاء", hint: "MM/YY"),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: customField(label: "CVV", hint: "***"),
                  ),
                ],
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
