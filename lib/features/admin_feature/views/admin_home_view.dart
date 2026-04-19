import 'package:flutter/material.dart';
import 'package:waslet_khier/const.dart';
import '../admin_constants.dart';
import '../widgets/admin_header.dart';
import '../widgets/admin_stat_card.dart';

class AdminHomeView extends StatelessWidget {
  const AdminHomeView({super.key});

  static const List<_BarData> _bars = [
    _BarData('السبت', 0.6),
    _BarData('الأحد', 0.9),
    _BarData('الاثنين', 0.5),
    _BarData('الثلاثاء', 0.7),
    _BarData('الأربعاء', 0.4),
    _BarData('الخميس', 0.85),
    _BarData('الجمعة', 0.65),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kAdminBackground,
      appBar: const AdminHeader(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Title
              const Text(
                'مؤسسة حياة كريمة',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: kAdminTextDark,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'ملخص أداء الجمعية لهذا الأسبوع',
                style: TextStyle(fontSize: 13, color: kAdminTextGrey),
              ),
              const SizedBox(height: 16),

              // ── Stats Grid
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: const [
                  AdminStatCard(
                    title: 'إجمالي التبرعات',
                    value: '45,200 ج.م',
                    icon: Icons.attach_money_rounded,
                    iconColor: appcolor,
                    iconBg: Colors.white,
                  ),
                  AdminStatCard(
                    title: 'عدد المتبرعين',
                    value: '2000',
                    icon: Icons.people_alt_rounded,
                    iconColor: kAdminOrange,
                    iconBg: Color(0xFFFFF0E6),
                  ),
                  AdminStatCard(
                    title: 'الحالات النشطة',
                    value: '20',
                    icon: Icons.local_fire_department_rounded,
                    iconColor: kAdminBlue,
                    iconBg: Color(0xFFE6F3FB),
                  ),
                  AdminStatCard(
                    title: 'الحالات المكتملة',
                    value: '5',
                    icon: Icons.check_circle_rounded,
                    iconColor: kAdminGreen,
                    iconBg: Color(0xFFE6F9F0),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // ── Add Case Button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: appcolor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 0,
                  ),
                  icon: const Icon(Icons.add, color: Colors.white, size: 22),
                  label: const Text(
                    'إضافة حالة جديدة',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // ── Export Button
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.file_download_outlined,
                    color: appcolor),
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

              // ── Weekly Chart
              Container(
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
                      'نمو التبرعات الاسبوعي',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: kAdminTextDark,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 150,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: _bars
                            .map((b) => _BarWidget(data: b))
                            .toList(),
                      ),
                    ),
                  ],
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

class _BarData {
  final String label;
  final double ratio;
  const _BarData(this.label, this.ratio);
}

class _BarWidget extends StatelessWidget {
  final _BarData data;
  const _BarWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 28,
          height: 120 * data.ratio,
          decoration: BoxDecoration(
            color: appcolor,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          data.label,
          style: const TextStyle(fontSize: 9, color: kAdminTextGrey),
        ),
      ],
    );
  }
}
