import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/core/api/api_service.dart';

import 'package:waslet_khier/features/admin_feature/data/admin_case_model.dart';
import 'package:waslet_khier/features/admin_feature/data/cubit/admin_sates_cubit.dart';
import 'package:waslet_khier/features/admin_feature/data/cubit/admin_states.dart';
import 'package:waslet_khier/features/admin_feature/data/repo/admin_repo.dart';
import '../admin_constants.dart';
import '../widgets/admin_header.dart';
 
class AdminCasesView extends StatelessWidget {
  final int charityId;
  const AdminCasesView({super.key, required this.charityId});
 
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          AdminCubit(AdminRepo(ApiService(Dio())), charityId: charityId)
            ..loadCases(charityId),
      child: Scaffold(
        backgroundColor: kAdminBackground,
        appBar: const AdminHeader(),
        body: BlocBuilder<AdminCubit, AdminState>(
          builder: (context, state) {
            if (state is AdminCasesLoading) {
              return const Center(
                  child: CircularProgressIndicator(color: appcolor));
            }
 
            if (state is AdminCasesFailure) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.error,
                        style: const TextStyle(color: Colors.red)),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () =>
                          context.read<AdminCubit>().loadCases(charityId),
                      child: const Text('إعادة المحاولة'),
                    ),
                  ],
                ),
              );
            }
 
            if (state is AdminCasesSuccess) {
              final cases = state.cases;
 
              if (cases.isEmpty) {
                return const Center(
                  child: Text(
                    'لا توجد حالات مسجلة',
                    style:
                        TextStyle(color: kAdminTextGrey, fontSize: 15),
                  ),
                );
              }
 
              return ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: cases.length,
                separatorBuilder: (_, __) =>
                    const SizedBox(height: 14),
                itemBuilder: (context, index) => _CaseCard(
                  data: cases[index],
                  charityId: charityId,
                  // Called when details screen returns a deleted caseId
                  onDeleted: (deletedId) {
                    context
                        .read<AdminCubit>()
                        .removeCaseById(deletedId);
                  },
                ),
              );
            }
 
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
 
class _CaseCard extends StatelessWidget {
  final AdminCaseModel data;
  final int charityId;
  final void Function(int deletedId) onDeleted;
 
  const _CaseCard({
    super.key,
    required this.data,
    required this.charityId,
    required this.onDeleted,
  });
 
  Color get _priorityColor {
    switch (data.priority) {
      case 'Urgent': return Colors.orange;
      case 'Critical': return Colors.red;
      default: return kAdminGreen;
    }
  }
 
  String get _priorityLabel {
    switch (data.priority) {
      case 'Urgent': return 'عاجل';
      case 'Critical': return 'حرج';
      default: return data.priority;
    }
  }
 
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kAdminCardBg,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Cover Image
          ClipRRect(
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(16)),
            child: data.coverImageUrl != null
                ? Image.network(
                    data.coverImageUrl!,
                    height: 160,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => _imageFallback(),
                  )
                : _imageFallback(),
          ),
 
          Padding(
            padding: const EdgeInsets.all(14),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Badges
                  Row(
                    children: [
                      _Badge(
                          label: data.categoryName, color: appcolor),
                      const SizedBox(width: 6),
                      _Badge(
                          label: _priorityLabel,
                          color: _priorityColor),
                      const Spacer(),
                      _Badge(
                        label: data.isActive ? 'نشط' : 'منتهي',
                        color: data.isActive
                            ? kAdminGreen
                            : kAdminTextGrey,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
 
                  // ── Title
                  Text(
                    data.title,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: kAdminTextDark),
                  ),
                  const SizedBox(height: 4),
 
                  // ── Description
                  Text(
                    data.description,
                    style: const TextStyle(
                        fontSize: 12, color: kAdminTextGrey),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),
 
                  // ── Amounts
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'المبلغ المطلوب: ${data.targetAmount.toInt()} ج.م',
                        style: const TextStyle(
                            fontSize: 11, color: kAdminTextGrey),
                      ),
                      Text(
                        'تم جمع: ${data.collectedAmount.toInt()} ج.م',
                        style: const TextStyle(
                            fontSize: 11,
                            color: appcolor,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
 
                  // ── Progress bar
                  Row(
                    children: [
                      Text(
                        '${(data.progress * 100).toInt()}%',
                        style: const TextStyle(
                            fontSize: 12,
                            color: appcolor,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: data.progress,
                            backgroundColor:
                                Colors.grey.shade200,
                            valueColor:
                                const AlwaysStoppedAnimation(
                                    appcolor),
                            minHeight: 6,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
 
                  // ── Buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: appcolor,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(10)),
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(
                                vertical: 10),
                          ),
                          child: GestureDetector(
                            onTap: () async {
                              final result = await context.push<bool>(
                                '/admin/$charityId/edit_case',
                                extra: {
                                  'caseData': data,
                                  'adminId':
                                      7, // TODO: replace with real adminId from your auth provider
                                },
                              );
                              // If edit was saved, refresh the list
                              if (result == true && context.mounted) {
                                context.read<AdminCubit>().loadCases(charityId);
                              }
                            },
                            child: const Text(
                              'تعديل الحالة',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      TextButton.icon(
                        onPressed: () async {
                          // Navigate and wait for result
                          // Details screen returns the deleted caseId (int) on delete,
                          // or null if user just went back
                          final result = await context.push<int>(
                            '/admin/$charityId/case_details',
                            extra: data.id,
                          );
                          if (result != null) {
                            onDeleted(result);
                          }
                        },
                        icon: const Icon(Icons.chevron_left,
                            color: appcolor, size: 18),
                        label: const Text(
                          'التفاصيل',
                          style: TextStyle(
                              color: appcolor, fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
 
  Widget _imageFallback() => Container(
        height: 160,
        color: Colors.grey.shade200,
        child: const Icon(Icons.image_not_supported,
            color: kAdminTextGrey, size: 40),
      );
}
 
class _Badge extends StatelessWidget {
  final String label;
  final Color color;
  const _Badge({required this.label, required this.color});
 
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: color),
      ),
    );
  }
}