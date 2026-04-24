import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/featureAuth/authprovider.dart/authprovider.dart';
import 'package:waslet_khier/features/cases_feature/data/models/caseModeljson/case_model/case_model.dart';
import 'package:waslet_khier/features/cases_feature/views/widgets/detals_view_case_image.dart';
import 'package:waslet_khier/features/cases_feature/views/widgets/states_taps.dart';
import 'package:waslet_khier/features/cases_feature/views/widgets/stause_row.dart';
import 'package:waslet_khier/features/cases_feature/views/widgets/title_text.dart';
import 'package:waslet_khier/features/charity_feature/data/cubit/charity_deteals_cubit.dart';
import 'package:waslet_khier/features/charity_feature/views/widget/charity_item.dart';
import 'package:waslet_khier/features/home_feature/data/cubit/featch_casess_cubit_cubit.dart';
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
  late CaseModel _currentCase;

  @override
  void initState() {
    super.initState();
    _currentCase = widget.casee;

    if (widget.casee.charityId != null) {
      context.read<CharityDetealsCubit>().getCharityById(
        widget.casee.charityId!,
      );
    }
    final donorId =
        Provider.of<AuthProvider_info>(context, listen: false).donor?.id ?? 0;
    context.read<Favcubit>().getfav(donorId);
  }

  Future<void> _refreshCase() async {
    await context.read<FeatchCasessCubitCubit>().featchCasess();
  }

  @override
  Widget build(BuildContext context) {
    final CaseModel c = _currentCase;

    final double target = (c.targetAmount ?? 1).toDouble();
    final double collected = (c.collectedAmount ?? 0).toDouble();
    final double progress = target == 0
        ? 0
        : (collected / target).clamp(0.0, 1.0);
    final double remaining = (target - collected).clamp(0, double.infinity);
    final int percentage = (progress * 100).toInt();
    final int remainingDays = c.endDate != null
        ? c.endDate!.difference(DateTime.now()).inDays
        : 0;

    // ✅ الإضافة الوحيدة: BlocListener يسمع لما الـ cases تتحدث
    return BlocListener<FeatchCasessCubitCubit, FeatchCasessCubitState>(
      listener: (context, state) {
        if (state is FeatchCasesCubitSucesses) {
          final updated = state.casee.firstWhere(
            (c) => c.id == _currentCase.id,
            orElse: () => _currentCase,
          );
          if (mounted) setState(() => _currentCase = updated);
        }
      },
      child: RefreshIndicator(
        color: tintAppColor,
        onRefresh: _refreshCase,
        child: ListView(
          padding: const EdgeInsets.all(22),
          children: [
            DetalsViewCaseImage(image: c.coverImageUrl ?? ''),
            const SizedBox(height: 12),

            if (c.priority != null || c.status != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (c.priority != null) StatesTaps(casePority: c.priority!),
                  if (c.status != null) ...[
                    const SizedBox(width: 8),
                    Chip(
                      label: Text(
                        c.status!,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.white,
                        ),
                      ),
                      backgroundColor: tintAppColor,
                      padding: EdgeInsets.zero,
                    ),
                  ],
                ],
              ),
            const SizedBox(height: 12),

            Center(child: TitleText(caseName: c.title ?? 'بدون عنوان')),
            const SizedBox(height: 4),

            if (c.beneficiaryName != null)
              Center(
                child: Text(
                  'المستفيد: ${c.beneficiaryName}',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

            if (c.age != null)
              Center(
                child: Text(
                  'العمر: ${c.age} سنة',
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                ),
              ),

            if (c.categoryName != null)
              Center(
                child: Text(
                  'التصنيف: ${c.categoryName}',
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                ),
              ),

            const SizedBox(height: 16),

            StauseRow(
              remaindMoney: remaining,
              personCount: c.donorsCount ?? 0,
              endDate: remainingDays,
            ),
            const SizedBox(height: 8),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'تم جمع $percentage%',
                  style: TextStyle(color: tintAppColor, fontSize: 12),
                ),
                Text(
                  'المطلوب: $target ج.م',
                  style: TextStyle(color: tintAppColor, fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: 4),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'تم جمع: $collected ج.م',
                  style: TextStyle(
                    color: Colors.green.shade600,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'المتبقي: ${remaining.toStringAsFixed(0)} ج.م',
                  style: const TextStyle(color: Colors.redAccent, fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: 6),

            ProgressBarWithLabel(progress: progress),
            const SizedBox(height: 16),

            if (c.endDate != null)
              _InfoRow(
                icon: Icons.calendar_today_outlined,
                label: 'تاريخ الانتهاء',
                value:
                    '${c.endDate!.day}/${c.endDate!.month}/${c.endDate!.year}',
              ),

            if (c.createdAt != null)
              _InfoRow(
                icon: Icons.access_time,
                label: 'تاريخ الإنشاء',
                value:
                    '${c.createdAt!.day}/${c.createdAt!.month}/${c.createdAt!.year}',
              ),

            const SizedBox(height: 8),

            const Center(
              child: Text(
                'وصف الحالة',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 6),
            _DescriptionText(description: c.description),
            const SizedBox(height: 15),
            BlocBuilder<CharityDetealsCubit, CharityState>(
              builder: (context, state) {
                if (state is CharityDetailsLoading) {
                  return const Center(child: CircularProgressIndicator());
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
                _HeartButton(caseId: c.id ?? 0),
                const SizedBox(width: 30),
                Expanded(child: DonateNowButtom(fontSize: 22, caseModel: c)),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });
  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Icon(icon, size: 14, color: Colors.grey),
          const SizedBox(width: 6),
          Text(
            '$label: ',
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

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
      style: const TextStyle(color: Colors.grey, height: 1.6),
    );
  }
}
