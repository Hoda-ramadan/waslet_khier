import 'dart:typed_data';
 
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/core/api/api_service.dart'; // ← fixed: capital 'Api'
import 'package:waslet_khier/features/admin_feature/admin_constants.dart';
import 'package:waslet_khier/features/admin_feature/data/admin_case_model.dart';
import 'package:waslet_khier/features/admin_feature/data/repo/admin_repo.dart';
import 'package:waslet_khier/features/charity_feature/data/models/category_model/category_madel2/category_madel2.dart';
 
class AdminEditCaseView extends StatefulWidget {
  final AdminCaseModel caseData;
  final int charityId;
  final int adminId;
 
  const AdminEditCaseView({
    super.key,
    required this.caseData,
    required this.charityId,
    required this.adminId,
  });
 
  @override
  State<AdminEditCaseView> createState() => _AdminEditCaseViewState();
}
 
class _AdminEditCaseViewState extends State<AdminEditCaseView> {
  final _formKey = GlobalKey<FormState>();
 
  // ── Controllers ────────────────────────────────────────────────────────────
  late final TextEditingController _titleCtrl;
  late final TextEditingController _descCtrl;
  late final TextEditingController _beneficiaryCtrl;
  late final TextEditingController _ageCtrl;
  late final TextEditingController _targetCtrl;
  late final TextEditingController _locationCtrl;
 
  // ── State ──────────────────────────────────────────────────────────────────
  String _priority = 'Normal';
  String _status = 'Active';
  bool _isFeatured = false;
  DateTime? _endDate;
  int? _selectedCategoryId;
  String? _selectedCategoryName;
 
  // Cover image
  XFile? _pickedCoverImage;
  Uint8List? _coverImageBytes;
 
  // Attachment files
  final List<XFile> _pickedAttachments = [];
  final List<Uint8List> _attachmentBytes = [];
  final List<String> _attachmentNames = [];
 
  // Categories list
  List<CategoryMadel> _categories = [];
  bool _loadingCategories = true;
 
  // Submission
  bool _isSubmitting = false;
 
  late final ApiService _api;
 
  // ── Priority / Status options ──────────────────────────────────────────────
  final List<String> _priorities = ['Normal', 'High', 'Low', 'Urgent', 'Critical'];
  final List<String> _statuses = ['Active', 'Pending', 'Closed'];
 
  String _priorityLabel(String p) {
    switch (p) {
      case 'High':     return 'عالية';
      case 'Low':      return 'منخفضة';
      case 'Urgent':   return 'عاجل';
      case 'Critical': return 'حرج';
      default:         return 'عادية';
    }
  }
 
  String _statusLabel(String s) {
    switch (s) {
      case 'Pending': return 'قيد المراجعة';
      case 'Closed':  return 'مغلق';
      default:        return 'نشط';
    }
  }
 
  @override
  void initState() {
    super.initState();
    _api = ApiService(Dio());
 
    final d = widget.caseData;
    _titleCtrl       = TextEditingController(text: d.title);
    _descCtrl        = TextEditingController(text: d.description);
    _beneficiaryCtrl = TextEditingController(text: d.beneficiaryName);
    _ageCtrl         = TextEditingController(text: d.age?.toString() ?? '');
    _targetCtrl      = TextEditingController(text: d.targetAmount.toString());
 
    // ── location: use it only if AdminCaseModel exposes it, otherwise empty ──
    // If your AdminCaseModel has a `location` field, replace '' with d.location ?? ''
    _locationCtrl = TextEditingController(text: '');
 
    _priority   = d.priority.isEmpty ? 'Normal' : d.priority;
    _status     = d.status.isEmpty   ? 'Active'  : d.status;
 
    // ── isFeatured / endDate: guard if AdminCaseModel doesn't expose them ────
    // Replace the fallback values with d.isFeatured / d.endDate when available
    _isFeatured = false;
    _endDate    = null;
 
    _fetchCategories();
  }
 
  Future<void> _fetchCategories() async {
    try {
      final cats = await _api.getCategoriesByCharity(widget.charityId);
      setState(() {
        _categories        = cats;
        _loadingCategories = false;
        final match = cats.firstWhere(
          (c) => c.name == widget.caseData.categoryName,
          orElse: () => cats.isNotEmpty ? cats.first : CategoryMadel(),
        );
        _selectedCategoryId   = match.id;
        _selectedCategoryName = match.name;
      });
    } catch (_) {
      setState(() => _loadingCategories = false);
    }
  }
 
  Future<void> _pickCoverImage() async {
    final file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file == null) return;
    final bytes = await file.readAsBytes();
    setState(() {
      _pickedCoverImage = file;
      _coverImageBytes  = bytes;
    });
  }
 
  Future<void> _pickAttachments() async {
    final files = await ImagePicker().pickMultiImage();
    for (final f in files) {
      final bytes = await f.readAsBytes();
      setState(() {
        _pickedAttachments.add(f);
        _attachmentBytes.add(bytes);
        _attachmentNames.add(f.name);
      });
    }
  }
 
  Future<void> _pickEndDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _endDate ?? DateTime.now().add(const Duration(days: 30)),
      firstDate:   DateTime.now(),
      lastDate:    DateTime(2100),
      builder: (ctx, child) => Theme(
        data: ThemeData.light().copyWith(
          colorScheme: const ColorScheme.light(primary: appcolor),
        ),
        child: child!,
      ),
    );
    if (picked != null) setState(() => _endDate = picked);
  }
 
  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedCategoryId == null) {
      _showSnack('يرجى اختيار الفئة', isError: true);
      return;
    }
 
    setState(() => _isSubmitting = true);
 
    try {
      final repo = AdminRepo(_api);
      await repo.editCase(
        caseId:          widget.caseData.id,
        title:           _titleCtrl.text.trim(),
        description:     _descCtrl.text.trim(),
        beneficiaryName: _beneficiaryCtrl.text.trim(),
        age:             int.parse(_ageCtrl.text.trim()),
        targetAmount:    double.parse(_targetCtrl.text.trim()),
        categoryId:      _selectedCategoryId!,
        priority:        _priority,
        status:          _status,
        charityId:       widget.charityId,
        adminId:         widget.adminId,
        isFeatured:      _isFeatured,
        location: _locationCtrl.text.trim().isEmpty
            ? null
            : _locationCtrl.text.trim(),
        endDate: _endDate != null
            ? '${_endDate!.year}-${_endDate!.month.toString().padLeft(2, '0')}-${_endDate!.day.toString().padLeft(2, '0')}'
            : null,
        coverImageBytes: _coverImageBytes,
        coverImageName:  _pickedCoverImage?.name,
        coverImagePath:  (!kIsWeb && _pickedCoverImage != null)
            ? _pickedCoverImage!.path
            : null,
        attachmentBytes: _attachmentBytes,
        attachmentNames: _attachmentNames,
        attachmentPaths: (!kIsWeb)
            ? _pickedAttachments.map((f) => f.path).toList()
            : [],
      );
 
      if (mounted) {
        _showSnack('تم تعديل الحالة بنجاح');
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (mounted) {
        _showSnack('فشل التعديل: ${e.toString()}', isError: true);
        setState(() => _isSubmitting = false);
      }
    }
  }
 
  void _showSnack(String msg, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:          Text(msg),
        backgroundColor:  isError ? kAdminRed : kAdminGreen,
        behavior:         SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
 
  @override
  void dispose() {
    _titleCtrl.dispose();
    _descCtrl.dispose();
    _beneficiaryCtrl.dispose();
    _ageCtrl.dispose();
    _targetCtrl.dispose();
    _locationCtrl.dispose();
    super.dispose();
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
          'تعديل الحالة',
          style: TextStyle(
              color: kAdminTextDark,
              fontWeight: FontWeight.bold,
              fontSize: 18),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Case Info ───────────────────────────────────────────────
                _SectionHeader(label: 'معلومات الحالة'),
                const SizedBox(height: 12),
 
                _InputField(
                  controller: _titleCtrl,
                  label: 'عنوان الحالة',
                  icon: Icons.title_outlined,
                  validator: (v) =>
                      v == null || v.isEmpty ? 'يرجى إدخال العنوان' : null,
                ),
                const SizedBox(height: 12),
 
                _InputField(
                  controller: _descCtrl,
                  label: 'وصف الحالة',
                  icon: Icons.description_outlined,
                  maxLines: 4,
                  validator: (v) =>
                      v == null || v.isEmpty ? 'يرجى إدخال الوصف' : null,
                ),
                const SizedBox(height: 12),
 
                // Category dropdown
                _loadingCategories
                    ? const Center(
                        child: CircularProgressIndicator(color: appcolor))
                    : _DropdownField<int>(
                        value: _selectedCategoryId,
                        label: 'اختر الفئة',
                        icon: Icons.category_outlined,
                        items: _categories
                            .map((c) => DropdownMenuItem(
                                  value: c.id,
                                  child: Text(c.name ?? ''),
                                ))
                            .toList(),
                        onChanged: (v) {
                          final cat =
                              _categories.firstWhere((c) => c.id == v);
                          setState(() {
                            _selectedCategoryId   = v;
                            _selectedCategoryName = cat.name;
                          });
                        },
                      ),
                const SizedBox(height: 12),
 
                // Priority
                _DropdownField<String>(
                  value: _priority,
                  label: 'الأولوية',
                  icon: Icons.flag_outlined,
                  items: _priorities
                      .map((p) => DropdownMenuItem(
                            value: p,
                            child: Text(_priorityLabel(p)),
                          ))
                      .toList(),
                  onChanged: (v) => setState(() => _priority = v!),
                ),
                const SizedBox(height: 12),
 
                // Status
                _DropdownField<String>(
                  value: _status,
                  label: 'الحالة',
                  icon: Icons.info_outline,
                  items: _statuses
                      .map((s) => DropdownMenuItem(
                            value: s,
                            child: Text(_statusLabel(s)),
                          ))
                      .toList(),
                  onChanged: (v) => setState(() => _status = v!),
                ),
                const SizedBox(height: 24),
 
                // ── Beneficiary ─────────────────────────────────────────────
                _SectionHeader(label: 'بيانات المستفيد'),
                const SizedBox(height: 12),
 
                _InputField(
                  controller: _beneficiaryCtrl,
                  label: 'اسم المستفيد',
                  icon: Icons.person_outline,
                  validator: (v) =>
                      v == null || v.isEmpty ? 'يرجى إدخال اسم المستفيد' : null,
                ),
                const SizedBox(height: 12),
 
                _InputField(
                  controller: _ageCtrl,
                  label: 'العمر',
                  icon: Icons.cake_outlined,
                  keyboardType: TextInputType.number,
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'يرجى إدخال العمر';
                    if (int.tryParse(v) == null) return 'يرجى إدخال رقم صحيح';
                    return null;
                  },
                ),
                const SizedBox(height: 24),
 
                // ── Donation ────────────────────────────────────────────────
                _SectionHeader(label: 'تفاصيل التبرع'),
                const SizedBox(height: 12),
 
                _InputField(
                  controller: _targetCtrl,
                  label: 'المبلغ المستهدف (ج.م)',
                  icon: Icons.attach_money,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'يرجى إدخال المبلغ';
                    if (double.tryParse(v) == null)
                      return 'يرجى إدخال رقم صحيح';
                    return null;
                  },
                ),
                const SizedBox(height: 12),
 
                // End date picker
                GestureDetector(
                  onTap: _pickEndDate,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
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
                        const Icon(Icons.calendar_today_outlined,
                            color: appcolor, size: 20),
                        const SizedBox(width: 12),
                        Text(
                          _endDate != null
                              ? '${_endDate!.day}/${_endDate!.month}/${_endDate!.year}'
                              : 'اضغط لاختيار تاريخ',
                          style: TextStyle(
                              fontSize: 14,
                              color: _endDate != null
                                  ? kAdminTextDark
                                  : kAdminTextGrey),
                        ),
                        const Spacer(),
                        if (_endDate != null)
                          GestureDetector(
                            onTap: () => setState(() => _endDate = null),
                            child: const Icon(Icons.close,
                                color: kAdminTextGrey, size: 18),
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
 
                // ── Extra ───────────────────────────────────────────────────
                _SectionHeader(label: 'معلومات إضافية'),
                const SizedBox(height: 12),
 
                _InputField(
                  controller: _locationCtrl,
                  label: 'الموقع (اختياري)',
                  icon: Icons.location_on_outlined,
                ),
                const SizedBox(height: 12),
 
                // isFeatured toggle
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 12),
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
                      const Icon(Icons.star_outline, color: appcolor, size: 20),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('تمييز الحالة',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: kAdminTextDark,
                                    fontWeight: FontWeight.w500)),
                            const SizedBox(height: 2),
                            Text('ستظهر الحالة في القائمة المميزة',
                                style:
                                    const TextStyle(fontSize: 11, color: kAdminTextGrey)),
                          ],
                        ),
                      ),
                      Switch(
                        value: _isFeatured,
                        onChanged: (v) => setState(() => _isFeatured = v),
                        activeColor: appcolor,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
 
                // ── Images ──────────────────────────────────────────────────
                _SectionHeader(label: 'الصور والمرفقات'),
                const SizedBox(height: 12),
 
                GestureDetector(
                  onTap: _pickCoverImage,
                  child: Container(
                    height: 160,
                    decoration: BoxDecoration(
                      color: kAdminCardBg,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: appcolor.withOpacity(0.3), width: 1.5),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 8,
                            offset: const Offset(0, 3))
                      ],
                    ),
                    child: _coverImageBytes != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.memory(_coverImageBytes!,
                                fit: BoxFit.cover, width: double.infinity),
                          )
                        : widget.caseData.coverImageUrl != null
                            ? Stack(fit: StackFit.expand, children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                    widget.caseData.coverImageUrl!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.black.withOpacity(0.35),
                                  ),
                                  child: const Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.edit,
                                          color: Colors.white, size: 32),
                                      SizedBox(height: 8),
                                      Text('اضغط لتغيير الصورة',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13)),
                                    ],
                                  ),
                                ),
                              ])
                            : const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.add_photo_alternate_outlined,
                                      color: appcolor, size: 40),
                                  SizedBox(height: 8),
                                  Text('اضغط لإضافة صورة الغلاف',
                                      style: TextStyle(
                                          color: kAdminTextGrey, fontSize: 13)),
                                ],
                              ),
                  ),
                ),
                const SizedBox(height: 12),
 
                OutlinedButton.icon(
                  onPressed: _pickAttachments,
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: appcolor.withOpacity(0.4)),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    minimumSize: const Size(double.infinity, 0),
                  ),
                  icon: const Icon(Icons.attach_file, color: appcolor),
                  label: const Text('إضافة ملفات مرفقة',
                      style: TextStyle(color: appcolor, fontSize: 14)),
                ),
 
                if (_pickedAttachments.isNotEmpty) ...[
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 6,
                    children: List.generate(_pickedAttachments.length, (i) {
                      return Chip(
                        label: Text(
                          _pickedAttachments[i].name,
                          style: const TextStyle(fontSize: 11),
                          overflow: TextOverflow.ellipsis,
                        ),
                        deleteIcon: const Icon(Icons.close, size: 14),
                        onDeleted: () => setState(() {
                          _pickedAttachments.removeAt(i);
                          _attachmentBytes.removeAt(i);
                          _attachmentNames.removeAt(i);
                        }),
                        backgroundColor: kAdminPrimaryLight,
                        labelStyle: const TextStyle(color: appcolor),
                        deleteIconColor: appcolor,
                      );
                    }),
                  ),
                ],
                const SizedBox(height: 28),
 
                // ── Submit ──────────────────────────────────────────────────
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isSubmitting ? null : _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: appcolor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: _isSubmitting
                        ? const SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                                color: Colors.white, strokeWidth: 2),
                          )
                        : const Text(
                            'حفظ التعديلات',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
 
// ── Section header ─────────────────────────────────────────────────────────────
 
class _SectionHeader extends StatelessWidget {
  final String label;
  const _SectionHeader({required this.label});
 
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 20,
          decoration: BoxDecoration(
              color: appcolor, borderRadius: BorderRadius.circular(2)),
        ),
        const SizedBox(width: 8),
        Text(label,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: kAdminTextDark)),
      ],
    );
  }
}
 
// ── Text input ─────────────────────────────────────────────────────────────────
 
class _InputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final int maxLines;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
 
  const _InputField({
    required this.controller,
    required this.label,
    required this.icon,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
    this.validator,
  });
 
  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboardType,
        validator: validator,
        textDirection: TextDirection.rtl,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: appcolor, size: 20),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none),
          filled: true,
          fillColor: Colors.transparent,
          labelStyle: const TextStyle(color: kAdminTextGrey, fontSize: 14),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }
}
 
// ── Dropdown ───────────────────────────────────────────────────────────────────
 
class _DropdownField<T> extends StatelessWidget {
  final T? value;
  final String label;
  final IconData icon;
  final List<DropdownMenuItem<T>> items;
  final void Function(T?) onChanged;
 
  const _DropdownField({
    required this.value,
    required this.label,
    required this.icon,
    required this.items,
    required this.onChanged,
  });
 
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
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
          Icon(icon, color: appcolor, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<T>(
                value: value,
                hint: Text(label,
                    style: const TextStyle(
                        color: kAdminTextGrey, fontSize: 14)),
                items: items,
                onChanged: onChanged,
                isExpanded: true,
                icon: const Icon(Icons.expand_more, color: kAdminTextGrey),
                style:
                    const TextStyle(color: kAdminTextDark, fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}