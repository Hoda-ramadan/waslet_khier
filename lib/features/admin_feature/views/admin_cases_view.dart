import 'package:flutter/material.dart';
import 'package:waslet_khier/const.dart';
import '../admin_constants.dart';
import '../widgets/admin_header.dart';

class AdminCasesView extends StatelessWidget {
  const AdminCasesView({super.key});

  static const List<_CaseData> _cases = [
    _CaseData(
      title: 'توفير وجبات غذائية',
      description: 'دعم أسرة بسيطة بوجبات يومية تكفي احتياجاتهم',
      progress: 0.5,
      image: 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=400',
    ),
    _CaseData(
      title: 'كفالة تعليم طفل',
      description: 'توفير مصاريف الدراسة والزي المدرسي لطفل غير قادر',
      progress: 0.65,
      image: 'https://images.unsplash.com/photo-1503676260728-1c00da094a0b?w=400',
    ),
    _CaseData(
      title: 'إجراء عملية جراحية عاجلة',
      description: 'مساعدة مريض يحتاج عملية جراحية عاجلة لإنقاذ حياته',
      progress: 0.2,
      image: 'https://images.unsplash.com/photo-1579684385127-1ef15d508118?w=400',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kAdminBackground,
      appBar: const AdminHeader(),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _cases.length,
        separatorBuilder: (_, __) => const SizedBox(height: 14),
        itemBuilder: (context, index) =>
            _CaseCard(data: _cases[index]),
      ),
    );
  }
}

class _CaseData {
  final String title;
  final String description;
  final double progress;
  final String image;
  const _CaseData({
    required this.title,
    required this.description,
    required this.progress,
    required this.image,
  });
}

class _CaseCard extends StatelessWidget {
  final _CaseData data;
  const _CaseCard({super.key, required this.data});

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
          // Image
          ClipRRect(
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.network(
              data.image,
              height: 160,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                height: 160,
                color: appcolor,
                child: const Icon(Icons.image_not_supported,
                    color: appcolor, size: 40),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(14),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    data.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: kAdminTextDark,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    data.description,
                    style: const TextStyle(
                      fontSize: 12,
                      color: kAdminTextGrey,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),

                  // Progress
                  Row(
                    children: [
                      Text(
                        '${(data.progress * 100).toInt()}%',
                        style: const TextStyle(
                          fontSize: 12,
                          color: appcolor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: data.progress,
                            backgroundColor: Colors.white,
                            valueColor: const AlwaysStoppedAnimation(
                                appcolor),
                            minHeight: 6,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Buttons Row
                  Row(
                    children: [
                      // Edit Button
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: appcolor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 0,
                            padding:
                                const EdgeInsets.symmetric(vertical: 10),
                          ),
                          child: const Text(
                            'تعديل الحالة',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      // Details
                      TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.chevron_left,
                            color: appcolor, size: 18),
                        label: const Text(
                          'التفاصيل',
                          style: TextStyle(
                            color: appcolor,
                            fontSize: 13,
                          ),
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
}
