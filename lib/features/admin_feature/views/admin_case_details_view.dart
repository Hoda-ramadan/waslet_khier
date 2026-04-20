import 'package:flutter/material.dart';
import 'package:waslet_khier/const.dart';
import '../admin_constants.dart';

class AdminCaseDetailsView extends StatelessWidget {
  final int charityId; // ✅ add this
  const AdminCaseDetailsView({super.key, required this.charityId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kAdminBackground,
      appBar: AppBar(
        backgroundColor: kAdminBackground,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.chevron_right, color: appcolor, size: 28),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          'تفاصيل الحالة',
          style: TextStyle(
            color: kAdminTextDark,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Avatar + Name
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 45,
                      backgroundColor: kAdminPrimaryLight,
                      child: const Icon(
                        Icons.person,
                        size: 50,
                        color: appcolor,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'منصور أشرف',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: kAdminTextDark,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'الصحة / جراحة القلب',
                      style: TextStyle(fontSize: 13, color: kAdminTextGrey),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: kAdminGreen.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        '5 فبراير 2022',
                        style: TextStyle(
                          fontSize: 12,
                          color: kAdminGreen,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'REQ-97543-2022#',
                      style: TextStyle(fontSize: 11, color: kAdminTextGrey),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // ── Info Rows
              _InfoRow(
                icon: Icons.cake_outlined,
                label: 'العمر',
                value: '28سنة',
              ),
              const SizedBox(height: 10),
              _InfoRow(
                icon: Icons.phone_outlined,
                label: 'الهاتف',
                value: '28913O5XXXXXXX',
              ),
              const SizedBox(height: 10),
              _InfoRow(
                icon: Icons.phone_android_outlined,
                label: 'الواتس',
                value: '01020XXXXXX',
              ),
              const SizedBox(height: 16),

              // ── Description
              const Text(
                'وصف الحالة',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: kAdminTextDark,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'المتقدم يعاني من حالة في تجمع الدم أثناء أداء عمله الصعب وفقدان القدرة على الإتقان في عمله الشاق طلب المساعدة للحصول على العلاج اللازم لمساعدته في تكاليف العملية الجراحية.',
                style: TextStyle(
                  fontSize: 13,
                  color: kAdminTextGrey,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 20),

              // ── Attachments
              const Text(
                'المستندات المرفقة',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: kAdminTextDark,
                ),
              ),
              const SizedBox(height: 12),
              _AttachmentItem(label: 'التقرير الطبي', isImage: true),
              const SizedBox(height: 10),
              _AttachmentItem(label: 'إثبات الدخل (PDF)', isImage: false),
              const SizedBox(height: 24),

              // ── Action Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: kAdminRed),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      icon: const Icon(Icons.close, color: kAdminRed, size: 18),
                      label: const Text(
                        'رفض الطلب',
                        style: TextStyle(color: kAdminRed, fontSize: 13),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: appcolor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      icon: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 18,
                      ),
                      label: const Text(
                        'قبول واعتماد',
                        style: TextStyle(color: Colors.white, fontSize: 13),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // ── Contact Button
              SizedBox(
                width: double.infinity,
                child: TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.chat_bubble_outline, color: appcolor),
                  label: const Text(
                    'التواصل مع الحالة',
                    style: TextStyle(color: appcolor, fontSize: 14),
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

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: kAdminCardBg,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              color: kAdminTextDark,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          Text(
            label,
            style: const TextStyle(fontSize: 14, color: kAdminTextGrey),
          ),
          const SizedBox(width: 10),
          Icon(icon, color: appcolor, size: 20),
        ],
      ),
    );
  }
}

class _AttachmentItem extends StatelessWidget {
  final String label;
  final bool isImage;

  const _AttachmentItem({required this.label, required this.isImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: kAdminCardBg,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              isImage ? Icons.visibility_outlined : Icons.download_outlined,
              color: appcolor,
            ),
          ),
          const Spacer(),
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              color: kAdminTextDark,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 10),
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: kAdminPrimaryLight,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              isImage ? Icons.image_outlined : Icons.picture_as_pdf_outlined,
              color: appcolor,
              size: 28,
            ),
          ),
        ],
      ),
    );
  }
}
