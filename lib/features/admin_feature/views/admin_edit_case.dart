import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:waslet_khier/const.dart';
import '../../../../core/Api/api_service.dart';
import 'package:waslet_khier/features/admin_feature/admin_constants.dart';
import 'package:waslet_khier/features/admin_feature/data/admin_case_model.dart';
import 'package:waslet_khier/features/admin_feature/data/repo/admin_repo.dart';

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

  late final TextEditingController _titleCtrl;
  late final TextEditingController _descCtrl;
  late final TextEditingController _beneficiaryCtrl;
  late final TextEditingController _ageCtrl;
  late final TextEditingController _targetCtrl;
  late final TextEditingController _locationCtrl;

  String _priority = 'Normal';
  String _status = 'Active';
  bool _isFeatured = false;
  DateTime? _endDate;

  // ── Categories ─────────────────────────────────────────────────────────────
  List<Map<String, dynamic>> _categories = [];
  bool _categoriesLoading = true;
  int? _selectedCategoryId;

  // Cover image
  XFile? _pickedCoverImage;
  Uint8List? _coverImageBytes;

  // Attachments
  final List<XFile> _pickedAttachments = [];
  final List<Uint8List> _attachmentBytes = [];
  final List<String> _attachmentNames = [];

  bool _isSubmitting = false;

  late final ApiService _api;

  final List<String> _priorities = [
    'Normal',
    'High',
    'Low',
    'Urgent',
    'Critical',
  ];
  final List<String> _statuses = ['Active', 'Pending', 'Closed'];

  String _priorityLabel(String p) {
    switch (p) {
      case 'High':
        return 'عالية';
      case 'Low':
        return 'منخفضة';
      case 'Urgent':
        return 'عاجل';
      case 'Critical':
        return 'حرج';
      default:
        return 'عادية';
    }
  }

  String _statusLabel(String s) {
    switch (s) {
      case 'Pending':
        return 'قيد المراجعة';
      case 'Closed':
        return 'مغلق';
      default:
        return 'نشط';
    }
  }

  @override
  void initState() {
    super.initState();
    _api = ApiService(Dio());

    final d = widget.caseData;
    _titleCtrl = TextEditingController(text: d.title);
    _descCtrl = TextEditingController(text: d.description);
    _beneficiaryCtrl = TextEditingController(text: d.beneficiaryName);
    _ageCtrl = TextEditingController(text: d.age?.toString() ?? '');
    _targetCtrl = TextEditingController(text: d.targetAmount.toString());
    _locationCtrl = TextEditingController(text: '');

    _priority = d.priority.isEmpty ? 'Normal' : d.priority;
    _status = d.status.isEmpty ? 'Active' : d.status;

    _loadCategories();
  }

  Future<void> _loadCategories() async {
    try {
      // GET /Category — returns ALL categories across all charities
      final response = await _api.get(endPoint: '/Category') as List<dynamic>;

      // ── FIX: cast charityId safely to int regardless of JSON number type ──
      final filtered = response
          .map((e) => e as Map<String, dynamic>)
          .where((c) {
            final cid = c['charityId'];
            // API may return int or double — compare safely
            final cidInt = cid is int ? cid : (cid as num).toInt();
            return cidInt == widget.charityId;
          })
          .map((c) {
            final id = c['id'] is int
                ? c['id'] as int
                : (c['id'] as num).toInt();
            final name = c['name'] as String;
            return {'id': id, 'name': name};
          })
          .toList();

      // Pre-select by matching categoryName from case data
      int? preSelected;
      for (final c in filtered) {
        if ((c['name'] as String) == widget.caseData.categoryName) {
          preSelected = c['id'] as int;
          break;
        }
      }
      // Fallback to first item if no name match
      if (preSelected == null && filtered.isNotEmpty) {
        preSelected = filtered.first['id'] as int;
      }

      if (mounted) {
        setState(() {
          _categories = filtered;
          _selectedCategoryId = preSelected;
          _categoriesLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _categoriesLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('فشل تحميل الفئات: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _pickCoverImage() async {
    final file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file == null) return;
    final bytes = await file.readAsBytes();
    setState(() {
      _pickedCoverImage = file;
      _coverImageBytes = bytes;
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
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
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
      await AdminRepo(_api).editCase(
        caseId: widget.caseData.id,
        title: _titleCtrl.text.trim(),
        description: _descCtrl.text.trim(),
        beneficiaryName: _beneficiaryCtrl.text.trim(),
        age: int.parse(_ageCtrl.text.trim()),
        targetAmount: double.parse(_targetCtrl.text.trim()),
        categoryId: _selectedCategoryId!,
        priority: _priority,
        status: _status,
        charityId: widget.charityId,
        adminId: widget.adminId,
        isFeatured: _isFeatured,
        location: _locationCtrl.text.trim().isEmpty
            ? null
            : _locationCtrl.text.trim(),
        endDate: _endDate != null
            ? '${_endDate!.year}-${_endDate!.month.toString().padLeft(2, '0')}-${_endDate!.day.toString().padLeft(2, '0')}'
            : null,
        coverImageBytes: _coverImageBytes,
        coverImageName: _pickedCoverImage?.name,
        coverImagePath: (!kIsWeb && _pickedCoverImage != null)
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
        _showSnack('فشل التعديل: $e', isError: true);
        setState(() => _isSubmitting = false);
      }
    }
  }

  void _showSnack(String msg, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: isError ? kAdminRed : kAdminGreen,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
            fontSize: 18,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // ── Case Info ─────────────────────────────────────────────────
            const _SectionHeader(label: 'معلومات الحالة'),
            const SizedBox(height: 10),

            _field(
              _titleCtrl,
              'عنوان الحالة',
              Icons.title_outlined,
              validator: (v) => v == null || v.trim().isEmpty ? 'مطلوب' : null,
            ),
            const SizedBox(height: 12),

            _field(
              _descCtrl,
              'وصف الحالة',
              Icons.description_outlined,
              maxLines: 4,
              validator: (v) => v == null || v.trim().isEmpty ? 'مطلوب' : null,
            ),
            const SizedBox(height: 12),

            // ── Category ──────────────────────────────────────────────────
            _dropCard(
              'الفئة',
              Icons.category_outlined,
              _categoriesLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: appcolor,
                      ),
                    )
                  : _categories.isEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'لا توجد فئات لهذه الجمعية',
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),
                        const SizedBox(height: 4),
                        GestureDetector(
                          onTap: () {
                            setState(() => _categoriesLoading = true);
                            _loadCategories();
                          },
                          child: const Text(
                            'إعادة المحاولة',
                            style: TextStyle(
                              color: appcolor,
                              fontSize: 12,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    )
                  : DropdownButton<int>(
                      value: _selectedCategoryId,
                      isExpanded: true,
                      underline: const SizedBox(),
                      hint: const Text('اختر الفئة'),
                      items: _categories
                          .map(
                            (c) => DropdownMenuItem<int>(
                              value: c['id'] as int,
                              child: Text(c['name'] as String),
                            ),
                          )
                          .toList(),
                      onChanged: (v) => setState(() => _selectedCategoryId = v),
                    ),
            ),
            const SizedBox(height: 12),

            // Priority
            _dropCard(
              'الأولوية',
              Icons.flag_outlined,
              DropdownButton<String>(
                value: _priority,
                isExpanded: true,
                underline: const SizedBox(),
                items: _priorities
                    .map(
                      (p) => DropdownMenuItem(
                        value: p,
                        child: Text(_priorityLabel(p)),
                      ),
                    )
                    .toList(),
                onChanged: (v) => setState(() => _priority = v ?? 'Normal'),
              ),
            ),
            const SizedBox(height: 12),

            // Status
            _dropCard(
              'الحالة',
              Icons.info_outline,
              DropdownButton<String>(
                value: _status,
                isExpanded: true,
                underline: const SizedBox(),
                items: _statuses
                    .map(
                      (s) => DropdownMenuItem(
                        value: s,
                        child: Text(_statusLabel(s)),
                      ),
                    )
                    .toList(),
                onChanged: (v) => setState(() => _status = v ?? 'Active'),
              ),
            ),
            const SizedBox(height: 20),

            // ── Beneficiary ───────────────────────────────────────────────
            const _SectionHeader(label: 'بيانات المستفيد'),
            const SizedBox(height: 10),

            _field(
              _beneficiaryCtrl,
              'اسم المستفيد',
              Icons.person_outline,
              validator: (v) => v == null || v.trim().isEmpty ? 'مطلوب' : null,
            ),
            const SizedBox(height: 12),

            _field(
              _ageCtrl,
              'العمر',
              Icons.cake_outlined,
              keyboardType: TextInputType.number,
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'مطلوب';
                if (int.tryParse(v.trim()) == null) return 'رقم غير صحيح';
                return null;
              },
            ),
            const SizedBox(height: 20),

            // ── Donation ──────────────────────────────────────────────────
            const _SectionHeader(label: 'تفاصيل التبرع'),
            const SizedBox(height: 10),

            _field(
              _targetCtrl,
              'المبلغ المستهدف (ج.م)',
              Icons.attach_money,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'مطلوب';
                if (double.tryParse(v.trim()) == null) return 'رقم غير صحيح';
                return null;
              },
            ),
            const SizedBox(height: 12),

            GestureDetector(
              onTap: _pickEndDate,
              child: _dropCard(
                'تاريخ انتهاء الحالة (اختياري)',
                Icons.calendar_today_outlined,
                Text(
                  _endDate != null
                      ? '${_endDate!.day}/${_endDate!.month}/${_endDate!.year}'
                      : 'اضغط لاختيار تاريخ',
                  style: TextStyle(
                    color: _endDate != null ? kAdminTextDark : kAdminTextGrey,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // ── Extra ─────────────────────────────────────────────────────
            const _SectionHeader(label: 'معلومات إضافية'),
            const SizedBox(height: 10),

            _field(
              _locationCtrl,
              'الموقع (اختياري)',
              Icons.location_on_outlined,
            ),
            const SizedBox(height: 12),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: kAdminCardBg,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.star_border, color: appcolor),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'تمييز الحالة',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: kAdminTextDark,
                          ),
                        ),
                        Text(
                          'ستظهر الحالة في القائمة المميزة',
                          style: TextStyle(fontSize: 11, color: kAdminTextGrey),
                        ),
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
            const SizedBox(height: 20),

            // ── Images ────────────────────────────────────────────────────
            const _SectionHeader(label: 'الصور والمرفقات'),
            const SizedBox(height: 10),

            GestureDetector(
              onTap: _pickCoverImage,
              child: Container(
                height: 160,
                decoration: BoxDecoration(
                  color: kAdminCardBg,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: appcolor.withOpacity(0.3),
                    width: 1.5,
                  ),
                ),
                clipBehavior: Clip.antiAlias,
                child: _coverImageBytes != null
                    ? Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.memory(_coverImageBytes!, fit: BoxFit.cover),
                          Positioned(
                            top: 6,
                            left: 6,
                            child: GestureDetector(
                              onTap: () => setState(() {
                                _pickedCoverImage = null;
                                _coverImageBytes = null;
                              }),
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.black54,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : widget.caseData.coverImageUrl != null
                    ? Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.network(
                            widget.caseData.coverImageUrl!,
                            fit: BoxFit.cover,
                          ),
                          Container(
                            color: Colors.black.withOpacity(0.35),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.edit, color: Colors.white, size: 32),
                                SizedBox(height: 8),
                                Text(
                                  'اضغط لتغيير الصورة',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add_photo_alternate_outlined,
                            color: appcolor,
                            size: 36,
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'اضغط لإضافة صورة الغلاف',
                            style: TextStyle(color: kAdminTextGrey),
                          ),
                        ],
                      ),
              ),
            ),
            const SizedBox(height: 12),

            OutlinedButton.icon(
              onPressed: _pickAttachments,
              icon: const Icon(Icons.attach_file, color: appcolor),
              label: Text(
                _pickedAttachments.isEmpty
                    ? 'إضافة ملفات مرفقة'
                    : 'تغيير المرفقات (${_pickedAttachments.length})',
                style: const TextStyle(color: appcolor),
              ),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: appcolor),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minimumSize: const Size(double.infinity, 48),
              ),
            ),

            ..._pickedAttachments.asMap().entries.map(
              (e) => ListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                leading: const Icon(
                  Icons.insert_drive_file_outlined,
                  color: appcolor,
                ),
                title: Text(
                  e.value.name,
                  style: const TextStyle(fontSize: 12, color: kAdminTextDark),
                ),
                trailing: IconButton(
                  icon: const Icon(
                    Icons.close,
                    size: 18,
                    color: kAdminTextGrey,
                  ),
                  onPressed: () => setState(() {
                    _pickedAttachments.removeAt(e.key);
                    _attachmentBytes.removeAt(e.key);
                    _attachmentNames.removeAt(e.key);
                  }),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // ── Submit ────────────────────────────────────────────────────
            ElevatedButton(
              onPressed: _isSubmitting ? null : _submit,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1B5E20),
                minimumSize: const Size(double.infinity, 52),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: _isSubmitting
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : const Text(
                      'حفظ التعديلات',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _field(
    TextEditingController ctrl,
    String label,
    IconData icon, {
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: ctrl,
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: validator,
      textDirection: TextDirection.rtl,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: appcolor),
        filled: true,
        fillColor: kAdminCardBg,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: appcolor, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red),
        ),
      ),
    );
  }

  Widget _dropCard(String label, IconData icon, Widget child) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: kAdminCardBg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: appcolor),
          const SizedBox(width: 10),
          Expanded(child: child),
        ],
      ),
    );
  }
}

// ── Widgets ────────────────────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  final String label;
  const _SectionHeader({required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 18,
          decoration: BoxDecoration(
            color: appcolor,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: kAdminTextDark,
          ),
        ),
      ],
    );
  }
}
