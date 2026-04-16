import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/features/cases_feature/data/models/caseModeljson/case_model/case_model.dart';
import 'package:waslet_khier/features/cases_feature/widgets/detals_view_case_image.dart';
import 'package:waslet_khier/features/cases_feature/widgets/states_taps.dart';
import 'package:waslet_khier/features/cases_feature/widgets/stause_row.dart';
import 'package:waslet_khier/features/cases_feature/widgets/title_text.dart';
import 'package:waslet_khier/features/charity_feature/data/cubit/charity_cubit.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/card_of_charity.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/charity_item.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/collectionOfcards.dart';
import 'package:waslet_khier/features/home_feature/views/widgets/donate_now_buttom.dart';
import 'package:waslet_khier/features/home_feature/views/widgets/progress_parth_with_label.dart';

class CaseDetalesViewBody extends StatefulWidget {
  const CaseDetalesViewBody({super.key, required this.casee});
  final CaseModel casee;

  @override
  State<CaseDetalesViewBody> createState() => _CaseDetalesViewBodyState();
}

class _CaseDetalesViewBodyState extends State<CaseDetalesViewBody> {
  @override
  void initState() {
    super.initState();

    context.read<CharityCubit>().getCharityById(widget.casee.charityId!);
  }

  @override
  Widget build(BuildContext context) {
    final double target = (widget.casee.targetAmount ?? 1).toDouble();
    final double collected = (widget.casee.collectedAmount ?? 0).toDouble();

    final double progress = target == 0
        ? 0
        : (collected / target).clamp(0.0, 1.0);

    final double remaining = (target - collected).clamp(0, double.infinity);
    final int percentage = (progress * 100).toInt();
    final int remainingDays = widget.casee.endDate != null
        ? widget.casee.endDate!.difference(DateTime.now()).inDays
        : 0;

    return Padding(
      // ✅ fixed (added return)
      padding: const EdgeInsets.all(22),
      child: Center(
        child: ListView(
          children: [
            DetalsViewCaseImage(image: widget.casee.coverImageUrl!),
            SizedBox(height: 12),
            StatesTaps(casePority: widget.casee.priority!),
            SizedBox(height: 12),
            Center(child: TitleText(caseName: widget.casee.title!)),
            SizedBox(height: 16),
            StauseRow(
              remaindMoney: remaining,
              personCount: widget.casee.donorsCount ?? 0!,
              endDate: remainingDays,
            ),
            SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "تم جمع $percentage",
                  style: TextStyle(color: tintAppColor, fontSize: 12),
                ),
                Text(
                  "المطلوب$target ج.م",
                  style: TextStyle(color: tintAppColor, fontSize: 12),
                ),
              ],
            ),
            SizedBox(height: 5),
            ProgressBarWithLabel(progress: progress),
            SizedBox(height: 16),

            /// charty ////
            BlocBuilder<CharityCubit, CharityState>(
              builder: (context, state) {
                if (state is CharityDetailsLoading) {
                  return CircularProgressIndicator();
                }
                if (state is CharityDetailsSuccess) {
                  return CharityItem(
                    charityModel: state.charity,
                    icon: Icons.arrow_forward_ios,
                  );
                }
                if (state is CharityDetailsFaild) {
                  return Text(state.error);
                } else {
                  return Text('No Charity ');
                }
              },
            ),

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
