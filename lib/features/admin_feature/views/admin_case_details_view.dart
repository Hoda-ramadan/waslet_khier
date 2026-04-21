import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/features/cases_feature/data/models/caseModeljson/case_model/case_model.dart';
import '../../../core/api/api_service.dart';
import '../admin_constants.dart';
 
class AdminCaseDetailsView extends StatefulWidget {
  final int caseId;
  const AdminCaseDetailsView({super.key, required this.caseId});
 
  @override
  State<AdminCaseDetailsView> createState() => _AdminCaseDetailsViewState();
}
 
class _AdminCaseDetailsViewState extends State<AdminCaseDetailsView> {
  CaseModel? _caseModel;
  bool _isLoading = true;
  bool _isDeleting = false;
  String? _errorMessage;
 
  final ApiService _api = ApiService(Dio());
 
  @override
  void initState() {
    super.initState();
    _fetchCaseDetails();
  }
 
  Future<void> _fetchCaseDetails() async {
    try {
      final data = await _api.get(endPoint: '/Case/${widget.caseId}');
      setState(() {
        _caseModel = CaseModel.fromJson(data);
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }
 
  Future<void> _softDelete() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text('حذف الحالة',
              style: TextStyle(
                  color: kAdminTextDark, fontWeight: FontWeight.bold)),
          content: const Text(
            'هل أنت متأكد من حذف هذه الحالة؟\nلا يمكن التراجع عن هذا الإجراء.',
            style: TextStyle(color: kAdminTextGrey, height: 1.5),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('إلغاء',
                  style: TextStyle(color: kAdminTextGrey)),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              style: ElevatedButton.styleFrom(
                backgroundColor: kAdminRed,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                elevation: 0,
              ),
              child: const Text('حذف',
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
 
    if (confirm != true) return;
    setState(() => _isDeleting = true);
 
    try {
      await _api.softDeleteCase(widget.caseId);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('تم حذف الحالة بنجاح'),
            backgroundColor: kAdminGreen,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)),
          ),
        );
        // Return the deleted caseId so the list can remove it
        Navigator.pop(context, widget.caseId);
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isDeleting = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('فشل الحذف: ${e.toString()}'),
            backgroundColor: kAdminRed,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)),
          ),
        );
      }
    }
  }
 
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
              fontSize: 18),
        ),
        actions: [
          if (!_isLoading && _caseModel != null)
            _isDeleting
                ? const Padding(
                    padding: EdgeInsets.all(14),
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                          color: kAdminRed, strokeWidth: 2),
                    ),
                  )
                : IconButton(
                    onPressed: _softDelete,
                    icon: const Icon(Icons.delete_outline, color: kAdminRed),
                    tooltip: 'حذف الحالة',
                  ),
        ],
      ),
      body: _buildBody(),
    );
  }
 
  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator(color: appcolor));
    }
 
    if (_errorMessage != null) {
      return Center(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: kAdminRed, size: 48),
              const SizedBox(height: 12),
              Text(_errorMessage!,
                  style: const TextStyle(color: kAdminRed),
                  textAlign: TextAlign.center),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isLoading = true;
                    _errorMessage = null;
                  });
                  _fetchCaseDetails();
                },
                style: ElevatedButton.styleFrom(backgroundColor: appcolor),
                child: const Text('إعادة المحاولة',
                    style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      );
    }
 
    final c = _caseModel!;
 
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header card ───────────────────────────────────────────────
            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
              decoration: BoxDecoration(
                color: kAdminCardBg,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Cover image
                  CircleAvatar(
                    radius: 48,
                    backgroundColor: kAdminPrimaryLight,
                    backgroundImage: c.coverImageUrl != null
                        ? NetworkImage(c.coverImageUrl!)
                        : null,
                    child: c.coverImageUrl == null
                        ? const Icon(Icons.person,
                            size: 50, color: appcolor)
                        : null,
                  ),
                  const SizedBox(height: 12),
                  // Beneficiary name
                  Text(
                    c.beneficiaryName ?? '—',
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: kAdminTextDark),
                  ),
                  const SizedBox(height: 4),
                  // Category name
                  Text(c.categoryName ?? '—',
                      style: const TextStyle(
                          fontSize: 13, color: kAdminTextGrey)),
                  const SizedBox(height: 10),
                  // Status + Priority + Featured badges
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 8,
                    runSpacing: 6,
                    children: [
                      _Badge(
                          label: _statusLabel(c.status),
                          color: _statusColor(c.status)),
                      _Badge(
                          label: _priorityLabel(c.priority),
                          color: _priorityColor(c.priority)),
                      if (c.isFeatured == true)
                        const _Badge(
                            label: '⭐ مميزة', color: Colors.amber),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Charity name (visible label, no ID)
                  Text(
                    c.charityName ?? '—',
                    style: const TextStyle(
                        fontSize: 12, color: kAdminTextGrey),
                  ),
                  const SizedBox(height: 4),
                  // Creation date
                  if (c.createdAt != null)
                    Text(
                      'تاريخ التسجيل: ${c.createdAt!.day}/${c.createdAt!.month}/${c.createdAt!.year}',
                      style: const TextStyle(
                          fontSize: 11, color: kAdminTextGrey),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 20),
 
            // ── Funding progress ──────────────────────────────────────────
            if (c.targetAmount != null && c.targetAmount! > 0) ...[
              const _SectionLabel(label: 'نسبة التمويل'),
              const SizedBox(height: 8),
              _FundingProgress(
                  collected: c.collectedAmount ?? 0,
                  target: c.targetAmount!),
              const SizedBox(height: 20),
            ],
 
            // ── Case info ─────────────────────────────────────────────────
            const _SectionLabel(label: 'معلومات الحالة'),
            const SizedBox(height: 10),
 
            // Age
            if (c.age != null)
              _InfoRow(
                  icon: Icons.cake_outlined,
                  label: 'العمر',
                  value: '${c.age} سنة'),
            if (c.age != null) const SizedBox(height: 10),
 
            // Charity
            _InfoRow(
                icon: Icons.business_outlined,
                label: 'الجمعية',
                value: c.charityName ?? '—'),
            const SizedBox(height: 10),
 
            // Category
            _InfoRow(
                icon: Icons.category_outlined,
                label: 'التصنيف',
                value: c.categoryName ?? '—'),
            const SizedBox(height: 10),
 
            // Location
           
 
            // End date
            if (c.endDate != null) ...[
              _InfoRow(
                  icon: Icons.calendar_today_outlined,
                  label: 'تاريخ الانتهاء',
                  value:
                      '${c.endDate!.day}/${c.endDate!.month}/${c.endDate!.year}'),
              const SizedBox(height: 10),
            ],
 
            // Donors count
            if (c.donorsCount != null) ...[
              _InfoRow(
                  icon: Icons.people_outline,
                  label: 'عدد المتبرعين',
                  value: '${c.donorsCount}'),
              const SizedBox(height: 10),
            ],
 
            // Title
            _InfoRow(
                icon: Icons.title_outlined,
                label: 'عنوان الحالة',
                value: c.title ?? '—'),
            const SizedBox(height: 20),
 
            // ── Description ───────────────────────────────────────────────
            const _SectionLabel(label: 'وصف الحالة'),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: kAdminCardBg,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 8,
                      offset: const Offset(0, 3))
                ],
              ),
              child: Text(
                c.description ?? '—',
                style: const TextStyle(
                    fontSize: 13, color: kAdminTextGrey, height: 1.7),
              ),
            ),
            const SizedBox(height: 20),
 
            // ── Attachments ───────────────────────────────────────────────
            if (c.attachments != null && c.attachments!.isNotEmpty) ...[
              const _SectionLabel(label: 'المستندات المرفقة'),
              const SizedBox(height: 12),
              ...c.attachments!.map((att) {
                final url = att.fileUrl ?? '';
                final isImage = url.endsWith('.jpg') ||
                    url.endsWith('.jpeg') ||
                    url.endsWith('.png');
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: _AttachmentItem(
                    label: isImage ? 'صورة مرفقة' : 'مستند مرفق (PDF)',
                    isImage: isImage,
                    fileUrl: att.fileUrl,
                  ),
                );
              }),
              const SizedBox(height: 14),
            ],
 
            // ── Accept / Reject ───────────────────────────────────────────
            
            const SizedBox(height: 12),
 
            // ── Delete button ─────────────────────────────────────────────
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: _isDeleting ? null : _softDelete,
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: kAdminRed),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  backgroundColor: kAdminRed.withOpacity(0.05),
                ),
                icon: _isDeleting
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                            color: kAdminRed, strokeWidth: 2),
                      )
                    : const Icon(Icons.delete_outline,
                        color: kAdminRed, size: 18),
                label: Text(
                  _isDeleting ? 'جاري الحذف...' : 'حذف الحالة',
                  style:
                      const TextStyle(color: kAdminRed, fontSize: 13),
                ),
              ),
            ),
            const SizedBox(height: 12),
 
            // ── Contact ───────────────────────────────────────────────────
         
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
 
  // ── Helpers ───────────────────────────────────────────────────────────────
 
  Color _statusColor(String? s) {
    switch (s) {
      case 'Active': return kAdminGreen;
      case 'Pending': return Colors.orange;
      case 'Closed': return kAdminRed;
      default: return kAdminTextGrey;
    }
  }
 
  String _statusLabel(String? s) {
    switch (s) {
      case 'Active': return 'نشط';
      case 'Pending': return 'قيد المراجعة';
      case 'Closed': return 'مغلق';
      default: return s ?? '—';
    }
  }
 
  String _priorityLabel(String? p) {
    switch (p) {
      case 'High': return 'أولوية عالية';
      case 'Normal': return 'أولوية عادية';
      case 'Low': return 'أولوية منخفضة';
      default: return p ?? '—';
    }
  }
 
  Color _priorityColor(String? p) {
    switch (p) {
      case 'High': return kAdminRed;
      case 'Normal': return appcolor;
      case 'Low': return kAdminTextGrey;
      default: return kAdminTextGrey;
    }
  }
}
 
// ── Shared widgets ────────────────────────────────────────────────────────────
 
class _Badge extends StatelessWidget {
  final String label;
  final Color color;
  const _Badge({required this.label, required this.color});
 
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(label,
          style: TextStyle(
              fontSize: 12, color: color, fontWeight: FontWeight.w600)),
    );
  }
}
 
class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel({required this.label});
 
  @override
  Widget build(BuildContext context) {
    return Text(label,
        style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: kAdminTextDark));
  }
}
 
class _FundingProgress extends StatelessWidget {
  final double collected;
  final double target;
  const _FundingProgress(
      {required this.collected, required this.target});
 
  @override
  Widget build(BuildContext context) {
    final percent = (collected / target).clamp(0.0, 1.0);
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: kAdminCardBg,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 3))
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${(percent * 100).toStringAsFixed(0)}%',
                  style: const TextStyle(
                      color: appcolor, fontWeight: FontWeight.bold)),
              Text(
                  '${collected.toStringAsFixed(0)} / ${target.toStringAsFixed(0)} ج.م',
                  style: const TextStyle(
                      fontSize: 13, color: kAdminTextGrey)),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: percent,
              minHeight: 8,
              backgroundColor: kAdminPrimaryLight,
              color: appcolor,
            ),
          ),
        ],
      ),
    );
  }
}
 
class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _InfoRow(
      {required this.icon,
      required this.label,
      required this.value});
 
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: kAdminCardBg,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 3))
        ],
      ),
      child: Row(
        children: [
          Text(value,
              style: const TextStyle(
                  fontSize: 14,
                  color: kAdminTextDark,
                  fontWeight: FontWeight.w500)),
          const Spacer(),
          Text(label,
              style: const TextStyle(
                  fontSize: 14, color: kAdminTextGrey)),
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
  final String? fileUrl;
  const _AttachmentItem(
      {required this.label,
      required this.isImage,
      this.fileUrl});
 
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
              offset: const Offset(0, 3))
        ],
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              // TODO: open fileUrl in viewer / browser
            },
            icon: Icon(
                isImage
                    ? Icons.visibility_outlined
                    : Icons.download_outlined,
                color: appcolor),
          ),
          const Spacer(),
          Text(label,
              style: const TextStyle(
                  fontSize: 13,
                  color: kAdminTextDark,
                  fontWeight: FontWeight.w500)),
          const SizedBox(width: 10),
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
                color: kAdminPrimaryLight,
                borderRadius: BorderRadius.circular(8)),
            child: isImage && fileUrl != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child:
                        Image.network(fileUrl!, fit: BoxFit.cover),
                  )
                : Icon(
                    isImage
                        ? Icons.image_outlined
                        : Icons.picture_as_pdf_outlined,
                    color: appcolor,
                    size: 28,
                  ),
          ),
        ],
      ),
    );
  }
}