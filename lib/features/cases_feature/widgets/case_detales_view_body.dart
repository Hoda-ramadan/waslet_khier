import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:waslet_khier/features/cases_feature/widgets/detals_view_case_image.dart';
import 'package:waslet_khier/features/cases_feature/widgets/states_taps.dart';
import 'package:waslet_khier/features/cases_feature/widgets/stause_row.dart';
import 'package:waslet_khier/features/cases_feature/widgets/title_text.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/card_of_charity.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/charity_item.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/collectionOfcards.dart';
import 'package:waslet_khier/features/home_feature/views/widgets/donate_now_buttom.dart';

class CaseDetalesViewBody extends StatelessWidget {
  const CaseDetalesViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      // ✅ fixed (added return)
      padding: const EdgeInsets.all(22),
      child: Center(
        child: ListView(
          children: [
            DetalsViewCaseImage(),
            SizedBox(height: 12),
            StatesTaps(),
            SizedBox(height: 12),
            Center(child: TitleText()),
            SizedBox(height: 16),
            StauseRow(),
            SizedBox(height: 16),
<<<<<<< HEAD
<<<<<<< HEAD
            CharityItem(icon: Icons.arrow_forward_ios_outlined),
=======
            ///CharityItem(),
>>>>>>> d1b92ec510280e76e32d52c3973ba365bcede513
=======

            ///CharityItem(),
>>>>>>> bef6ecd46f9596b2c4d31f925cd9d193d44ea4c5
            SizedBox(height: 20),
            Row(
              children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.favorite)),
                Spacer(),
                SizedBox(
                  width: 280,
                  height: 50,
                  child: DonateNowButtom(fontSize: 22),
                ),
              ],
            ),
            SizedBox(height: 12),
            _DescriptionText(),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;

  const _StatCard({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.deepPurple),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
          const SizedBox(height: 4),
          Text(title, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}

class _DonationCard extends StatelessWidget {
  const _DonationCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.deepPurple),
      ),
      child: Row(
        children: [
          const Icon(Icons.verified, color: Colors.deepPurple),
          const SizedBox(width: 10),
          const Expanded(child: Text("مستشفى 57357 لعلاج سرطان الأطفال")),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: const [
              Text(
                "57,157",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              Text("تم جمعه"),
            ],
          ),
        ],
      ),
    );
  }
}

class _DonateButton extends StatelessWidget {
  const _DonateButton();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: const Text("تبرع الآن", style: TextStyle(fontSize: 16)),
    );
  }
}

class _DescriptionText extends StatelessWidget {
  const _DescriptionText();

  @override
  Widget build(BuildContext context) {
    return const Text(
      "نحتاج إلى توفير العلاج والرعاية الطبية اللازمة لطفل مصاب بالسرطان لمساعدته على استكمال رحلة الشفاء.",
      style: TextStyle(color: Colors.grey),
    );
  }
}
