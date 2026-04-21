import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/featureAuth/authprovider.dart/authprovider.dart';
import 'package:waslet_khier/features/cases_feature/data/models/caseModeljson/case_model/case_model.dart';
import 'package:waslet_khier/features/cases_feature/widgets/detals_view_case_image.dart';
import 'package:waslet_khier/features/cases_feature/widgets/states_taps.dart';
import 'package:waslet_khier/features/cases_feature/widgets/stause_row.dart';
import 'package:waslet_khier/features/cases_feature/widgets/title_text.dart';
import 'package:waslet_khier/features/charity_feature/data/cubit/charity_deteals_cubit.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/charity_item.dart';
import 'package:waslet_khier/features/home_feature/views/widgets/donate_now_buttom.dart';
import 'package:waslet_khier/features/home_feature/views/widgets/progress_parth_with_label.dart';
import 'package:waslet_khier/features/profile_feature/data/favCubit/favCubit.dart';
import 'package:waslet_khier/features/profile_feature/data/favCubit/favstate.dart';

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
    context.read<CharityDetealsCubit>().getCharityById(widget.casee.charityId!);

    // ✅ جيب المفضلة عشان نعرف الحالة دي مفضلة ولا لأ
    final donorId =
        Provider.of<AuthProvider_info>(context, listen: false).donor?.id ?? 0;
    context.read<Favcubit>().getfav(donorId);
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
      padding: const EdgeInsets.all(22),
      child: Center(
        child: ListView(
          children: [
            DetalsViewCaseImage(image: widget.casee.coverImageUrl!),
            const SizedBox(height: 12),
            StatesTaps(casePority: widget.casee.priority!),
            const SizedBox(height: 12),
            Center(child: TitleText(caseName: widget.casee.title!)),
            const SizedBox(height: 16),
            StauseRow(
              remaindMoney: remaining,
              personCount: widget.casee.donorsCount ?? 0,
              endDate: remainingDays,
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "تم جمع $percentage%",
                  style: TextStyle(color: tintAppColor, fontSize: 12),
                ),
                Text(
                  "المطلوب: $target ج.م",
                  style: TextStyle(color: tintAppColor, fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: 5),
            ProgressBarWithLabel(progress: progress),
            const SizedBox(height: 16),

            // الجمعية
            BlocBuilder<CharityDetealsCubit, CharityState>(
              builder: (context, state) {
                if (state is CharityDetailsLoading) {
                  return const CircularProgressIndicator();
                }
                if (state is CharityDetailsSuccess) {
                  return CharityItem(
                    charityModel: state.charity,
                    icon: Icons.arrow_forward_ios,
                  );
                }
                if (state is CharityDetailsFaild) {
                  return Text(state.error);
                }
                return const SizedBox();
              },
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                // ✅ FIXED: القلب الحقيقي بدل الـ dummy
                _HeartButton(caseId: widget.casee.id!),
                const Spacer(),
                SizedBox(
                  width: 280,
                  height: 50,
                  child: DonateNowButtom(fontSize: 22),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _DescriptionText(description: widget.casee.description),
          ],
        ),
      ),
    );
  }
}

// ✅ NEW: القلب بيشتغل مع الـ FavCubit
class _HeartButton extends StatelessWidget {
  const _HeartButton({required this.caseId});
  final int caseId;

  @override
  Widget build(BuildContext context) {
    final donorId =
        Provider.of<AuthProvider_info>(context, listen: false).donor?.id ?? 0;

    return BlocBuilder<Favcubit, FavorieState>(
      builder: (context, state) {
        final isFav = context.read<Favcubit>().isFavorite(caseId);

        return IconButton(
          onPressed: () {
            context.read<Favcubit>().toggleFavorite(
              donorId: donorId,
              caseId: caseId,
            );
          },
          icon: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, anim) =>
                ScaleTransition(scale: anim, child: child),
            child: Icon(
              isFav ? Icons.favorite : Icons.favorite_border,
              key: ValueKey(isFav),
              color: isFav ? Colors.red : Colors.grey,
              size: 30,
            ),
          ),
        );
      },
    );
  }
}

class _DescriptionText extends StatelessWidget {
  const _DescriptionText({this.description});
  final String? description;

  @override
  Widget build(BuildContext context) {
    return Text(
      description ??
          'نحتاج إلى توفير العلاج والرعاية الطبية اللازمة لمساعدة هذه الحالة.',
      style: const TextStyle(color: Colors.grey),
    );
  }
}
