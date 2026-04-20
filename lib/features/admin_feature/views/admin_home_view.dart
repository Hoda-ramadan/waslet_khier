import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/core/Api/api_service.dart';
import 'package:waslet_khier/features/admin_feature/data/cubit/admin_sates_cubit.dart';
import 'package:waslet_khier/features/admin_feature/data/cubit/admin_states.dart';
import 'package:waslet_khier/features/admin_feature/data/repo/admin_repo.dart';
import 'package:waslet_khier/features/admin_feature/views/add_case_screnn.dart';
import '../admin_constants.dart';
import '../widgets/admin_header.dart';
import '../widgets/admin_stat_card.dart';

class AdminHomeView extends StatelessWidget {
  final int charityId;
  const AdminHomeView({super.key, required this.charityId});

  @override
  Widget build(BuildContext context) {
    print('>>> AdminHomeView charityId: $charityId');
    return BlocProvider(
      create: (_) =>
          AdminCubit(AdminRepo(ApiService(Dio())), charityId: charityId)
            ..loadDashboard(),
      child: const _AdminHomeContent(),
    );
  }
}

class _AdminHomeContent extends StatelessWidget {
  const _AdminHomeContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kAdminBackground,
      appBar: const AdminHeader(),
      body: BlocBuilder<AdminCubit, AdminState>(
        builder: (context, state) {
          print('>>> AdminCubit state: $state');

          if (state is AdminLoading || state is AdminInitial) {
            return const Center(
              child: CircularProgressIndicator(color: appcolor),
            );
          }

          if (state is AdminFailure) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.error, style: const TextStyle(color: Colors.red)),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () => context.read<AdminCubit>().loadDashboard(),
                    child: const Text('إعادة المحاولة'),
                  ),
                ],
              ),
            );
          }

          final stats = (state as AdminSuccess).stats;

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Charity name + logo
                  Row(
                    children: [
                      if (stats.charityLogo != null)
                        CircleAvatar(
                          radius: 22,
                          backgroundImage: NetworkImage(stats.charityLogo!),
                        ),
                      if (stats.charityLogo != null) const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          stats.charityName,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: kAdminTextDark,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'ملخص أداء الجمعية',
                    style: TextStyle(fontSize: 13, color: kAdminTextGrey),
                  ),
                  const SizedBox(height: 16),

                  // ── Stats Grid
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      AdminStatCard(
                        title: 'إجمالي التبرعات',
                        value: '${stats.totalDonations} ج.م',
                        icon: Icons.attach_money_rounded,
                        iconColor: appcolor,
                        iconBg: Colors.white,
                      ),
                      AdminStatCard(
                        title: 'عدد المتبرعين',
                        value: '${stats.totalDonors}',
                        icon: Icons.people_alt_rounded,
                        iconColor: kAdminOrange,
                        iconBg: const Color(0xFFFFF0E6),
                      ),
                      AdminStatCard(
                        title: 'المشاريع النشطة',
                        value: '${stats.activeCases}',
                        icon: Icons.local_fire_department_rounded,
                        iconColor: kAdminBlue,
                        iconBg: const Color(0xFFE6F3FB),
                      ),
                      AdminStatCard(
                        title: 'الحالات المكتملة',
                        value: '${stats.completedCases}',
                        icon: Icons.check_circle_rounded,
                        iconColor: kAdminGreen,
                        iconBg: const Color(0xFFE6F9F0),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // ── Add Case Button
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton.icon(
  onPressed: () async {
    // Navigate to AddCaseScreen and reload dashboard if case was created
    final created = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: context.read<AdminCubit>(), // reuse existing cubit
          child: const AddCaseScreen(),
        ),
      ),
    );

    if (created == true && context.mounted) {
      // Refresh the dashboard stats
      context.read<AdminCubit>().loadDashboard();
    }
  },
  icon: const Icon(Icons.add, color: Colors.white),
  label: const Text(
    'إضافة حالة جديدة',
    style: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  ),
  style: ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFF1B5E20),
    minimumSize: const Size(double.infinity, 52),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(14),
    ),
  ),
),
                  ),
                  const SizedBox(height: 10),

                  // ── Export Button
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.file_download_outlined,
                      color: appcolor,
                    ),
                    label: const Text(
                      'تصدير البيانات',
                      style: TextStyle(
                        color: appcolor,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // ── Charity Info Card (replaces fake chart)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: kAdminCardBg,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'معلومات الجمعية',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: kAdminTextDark,
                          ),
                        ),
                        const SizedBox(height: 12),

                        // ── Address
                        if (stats.charityAddress != null)
                          _InfoRow(
                            icon: Icons.location_on_outlined,
                            text: stats.charityAddress!,
                          ),

                        // ── Phone
                        if (stats.charityPhone != null)
                          _InfoRow(
                            icon: Icons.phone_outlined,
                            text: stats.charityPhone!,
                          ),

                        // ── Email
                        if (stats.charityEmail != null)
                          _InfoRow(
                            icon: Icons.email_outlined,
                            text: stats.charityEmail!,
                          ),

                        const SizedBox(height: 8),

                        // ── Active status badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: stats.isActive
                                ? const Color(0xFFE6F9F0)
                                : const Color(0xFFFFE6E6),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                stats.isActive
                                    ? Icons.check_circle_rounded
                                    : Icons.cancel_rounded,
                                size: 14,
                                color: stats.isActive
                                    ? kAdminGreen
                                    : Colors.red,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                stats.isActive
                                    ? 'الجمعية نشطة'
                                    : 'الجمعية غير نشطة',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: stats.isActive
                                      ? kAdminGreen
                                      : Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// ── Info Row Widget
class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: appcolor),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 13,
                color: kAdminTextGrey,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
