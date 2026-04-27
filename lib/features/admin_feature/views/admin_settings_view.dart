import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/featureAuth/authprovider.dart/authprovider.dart';
import 'package:waslet_khier/features/charity_feature/data/cubit/charity_deteals_cubit.dart';
import 'package:waslet_khier/features/charity_feature/data/models/charity_model.dart';
import '../admin_constants.dart';
import '../widgets/admin_header.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminSettingsView extends StatefulWidget {
  final int charityId; // ✅ receive charityId from AdminMainScreen
  const AdminSettingsView({super.key, required this.charityId});

  @override
  State<AdminSettingsView> createState() => _AdminSettingsViewState();
}

class _AdminSettingsViewState extends State<AdminSettingsView> {
  bool _notificationsEnabled = true;

  @override
  void initState() {
    super.initState();
    // Load charity data when screen opens
    context.read<CharityDetealsCubit>().getCharityById(widget.charityId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kAdminBackground,
      appBar: const AdminHeader(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            children: [
              const SizedBox(height: 10),

              // ── Org Logo + Name
              BlocBuilder<CharityDetealsCubit, CharityState>(
                builder: (context, state) {
                  final charityName = state is CharityDetailsSuccess
                      ? (state.charity.name ?? 'مؤسسة حياة كريمة')
                      : 'مؤسسة حياة كريمة';
                 

                  return Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
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
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: appcolor.withOpacity(0.3),
                              width: 2,
                            ),
                          ),
                          child: const Icon(
                            Icons.business_rounded,
                            color: appcolor,
                            size: 40,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          charityName,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: kAdminTextDark,
                          ),
                        ),
                        const SizedBox(height: 4),
                       
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),

              // ── بيانات الجمعية — navigates to EditCharityPage
              BlocBuilder<CharityDetealsCubit, CharityState>(
                builder: (context, state) {
                  return _SettingsMenuItem(
                    icon: Icons.description_outlined,
                    label: 'بيانات الجمعية',
                    subtitle: 'السجلات والرخص والمعلومات',
                    onTap: () {
                      if (state is CharityDetailsSuccess) {
                        // ✅ Navigate using GoRouter with charity as extra
                        context.go(
                          '/admin/${widget.charityId}/edit_charity',
                          extra: state.charity,
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('جاري تحميل بيانات الجمعية...'),
                          ),
                        );
                      }
                    },
                  );
                },
              ),
              const SizedBox(height: 10),

              _SettingsMenuItem(
                icon: Icons.credit_card_rounded,
                label: 'طرق التبرع',
                subtitle: null,
                isHighlighted: true,
                onTap: () {},
              ),
              const SizedBox(height: 10),

              // ── Notifications Toggle
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: kAdminCardBg,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Switch(
                      value: _notificationsEnabled,
                      activeColor: appcolor,
                      onChanged: (v) =>
                          setState(() => _notificationsEnabled = v),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'التنبيهات',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: kAdminTextDark,
                          ),
                        ),
                        Text(
                          'تلقي إشعارات للأحداث والتبرعات الجديدة',
                          style: TextStyle(fontSize: 11, color: kAdminTextGrey),
                        ),
                      ],
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.notifications_outlined,
                      color: kAdminTextGrey,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // ── Logout
              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton.icon(
                  onPressed: () async {
                    await Provider.of<AuthProvider_info>(
                      context,
                      listen: false,
                    ).logout();
                    context.go('/profile/logout');
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: kAdminRed, width: 1.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  icon: const Icon(Icons.logout_rounded,
                      color: kAdminRed, size: 20),
                  label: const Text(
                    'تسجيل خروج',
                    style: TextStyle(
                      color: kAdminRed,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

// _SettingsMenuItem stays exactly the same — no changes needed
class _SettingsMenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? subtitle;
  final bool isHighlighted;
  final VoidCallback onTap;

  const _SettingsMenuItem({
    required this.icon,
    required this.label,
    required this.subtitle,
    this.isHighlighted = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: kAdminCardBg,
          borderRadius: BorderRadius.circular(14),
          border: isHighlighted ? Border.all(color: appcolor, width: 1.5) : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            const Icon(Icons.chevron_left, color: appcolor),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: isHighlighted ? appcolor : kAdminTextDark,
                  ),
                ),
                if (subtitle != null)
                  Text(subtitle!,
                      style: const TextStyle(
                          fontSize: 11, color: kAdminTextGrey)),
              ],
            ),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isHighlighted
                    ? appcolor.withOpacity(0.1)
                    : Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: appcolor, size: 20),
            ),
          ],
        ),
      ),
    );
  }
}