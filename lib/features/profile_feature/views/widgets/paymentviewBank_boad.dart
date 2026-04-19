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
      child: SingleChildScrollView(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            children: [
              customappbar(text: "تبرع آمن "),
              SizedBox(height: 30),
              Text(
                "الدفع ب فيزا ",
                style: TextStyle(
                  fontFamily: "Roboto",
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                "تبرع آمن يدعم مشاريعنا الخيرية  ",
                style: TextStyle(
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
              ),
              SizedBox(height: 15),
              Image.asset("assets/images/no-data/mobile-payments/pana.png"),
              Text(
                "اختر مبلغ التبرع",
                style: TextStyle(
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
                textAlign: TextAlign.end,
              ),
              Row(
                children: [
                  CustomPayCard(txt: "50"),
                  SizedBox(width: 15),
                  CustomPayCard(txt: "100"),
                  SizedBox(width: 15),
                  CustomPayCard(txt: "100"),
                ],
              ),
              SizedBox(height: 25),
              CustomTextfieldForPayment(),
              SizedBox(height: 15),
              Text(
                "معلومات البطاقة ",
                style: TextStyle(
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
                textAlign: TextAlign.end,
              ),
              SizedBox(height: 10),
              Expanded(
                child: customField(
                  label: "'اسم حامل البطاقة",
                  hint: "مثال: نورهان فيصل",
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: customField(
                  label: "رقم البطاقة ",
                  hint: "0000 0000 0000 0000  ",
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: customField(label: "تاريخ الانتهاء", hint: "MM/YY"),
                  ),
                  Expanded(
                    child: customField(label: "الرقم السري (CVV)", hint: "***"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
