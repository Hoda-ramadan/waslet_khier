import 'dart:io';
 
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
 
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/features/admin_feature/data/create_case_model.dart';
import 'package:waslet_khier/features/admin_feature/data/cubit/admin_sates_cubit.dart';
import 'package:waslet_khier/features/admin_feature/data/cubit/admin_states.dart';
import '../admin_constants.dart';
 
class AddCaseScreen extends StatefulWidget {
  const AddCaseScreen({super.key});
 
  @override
  State<AddCaseScreen> createState() => _AddCaseScreenState();
}
 
class _AddCaseScreenState extends State<AddCaseScreen> {
  final _formKey = GlobalKey<FormState>();
 
  // ── Controllers ───────────────────────────────────────────────────────────
  final _titleCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  final _beneficiaryCtrl = TextEditingController();
  final _ageCtrl = TextEditingController();
  final _amountCtrl = TextEditingController();
  final _locationCtrl = TextEditingController();
 
  // ── Dropdown / picker state ───────────────────────────────────────────────
  // Category list — replace with real data from your API if available
  final List<Map<String, dynamic>> _categories = [
    {'id': 23, 'name': 'تعليم'},
    {'id': 24, 'name': 'صحة'},
    {'id': 25, 'name': 'غذاء'},
    {'id': 26, 'name': 'مسكن'},
  ];
  int? _selectedCategoryId;
 
  final List<String> _priorities = ['Normal', 'Urgent', 'Critical'];
  String _priority = 'Normal';
 
  bool _isFeatured = false;
  DateTime? _endDate;
 
  // ── File state ────────────────────────────────────────────────────────────
  File? _coverImage;
  List<File> _attachments = [];
 
  // ── Helpers ───────────────────────────────────────────────────────────────
  String _priorityLabel(String p) {
    switch (p) {
      case 'Urgent':
        return 'عاجل';
      case 'Critical':
        return 'حرج';
      default:
        return 'عادية';
    }
  }
 
  Future<void> _pickCoverImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );
    if (picked != null) setState(() => _coverImage = File(picked.path));
  }
 
  Future<void> _pickAttachments() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png', 'doc', 'docx'],
    );
    if (result != null) {
      setState(() {
        _attachments = result.paths
            .whereType<String>()
            .map((p) => File(p))
            .toList();
      });
    }
  }
 
  Future<void> _pickEndDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now.add(const Duration(days: 30)),
      firstDate: now,
      lastDate: DateTime(now.year + 5),
    );
    if (picked != null) setState(() => _endDate = picked);
  }
 
  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedCategoryId == null) {
      _showError('يرجى اختيار الفئة');
      return;
    }
 
    final cubit = context.read<AdminCubit>();
 
    final request = CreateCaseRequestModel(
      title: _titleCtrl.text.trim(),
      description: _descCtrl.text.trim(),
      beneficiaryName: _beneficiaryCtrl.text.trim(),
      age: int.parse(_ageCtrl.text.trim()),
      targetAmount: double.parse(_amountCtrl.text.trim()),
      categoryId: _selectedCategoryId!,
      priority: _priority,
      status: 'Active',
      charityId: cubit.charityId,
      adminId: cubit.charityId, // replace with real adminId from auth if needed
      isFeatured: _isFeatured,
      location: _locationCtrl.text.trim().isEmpty
          ? null
          : _locationCtrl.text.trim(),
      endDate: _endDate != null
          ? DateFormat('yyyy-MM-dd').format(_endDate!)
          : null,
    );
 
    cubit.createCase(
      request: request,
      coverImagePath: _coverImage?.path,
      attachmentPaths: _attachments.map((f) => f.path).toList(),
    );
  }
 
  void _showError(String msg) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(msg), backgroundColor: Colors.red));
  }
 
  @override
  void dispose() {
    _titleCtrl.dispose();
    _descCtrl.dispose();
    _beneficiaryCtrl.dispose();
    _ageCtrl.dispose();
    _amountCtrl.dispose();
    _locationCtrl.dispose();
    super.dispose();
  }
 
  // ── Build ─────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return BlocListener<AdminCubit, AdminState>(
      listener: (context, state) {
        if (state is CreateCaseSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: kAdminGreen,
            ),
          );
          Navigator.of(context).pop(true); // signal success to caller
        } else if (state is CreateCaseFailure) {
          _showError(state.error);
        }
      },
      child: Scaffold(
        backgroundColor: kAdminBackground,
        appBar: AppBar(
          backgroundColor: const Color(0xFF1B5E20),
          foregroundColor: Colors.white,
          title: const Text(
            'إضافة حالة جديدة',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: [
            BlocBuilder<AdminCubit, AdminState>(
              builder: (context, state) {
                if (state is CreateCaseLoading) {
                  return const Padding(
                    padding: EdgeInsets.all(16),
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                          color: Colors.white, strokeWidth: 2),
                    ),
                  );
                }
                return IconButton(
                  icon: const Icon(Icons.check),
                  onPressed: _submit,
                  tooltip: 'حفظ الحالة',
                );
              },
            ),
          ],
        ),
        body: Form(
          key: _formKey,
          child: ListView( // dectinaly
            padding: const EdgeInsets.all(16),
            children: [
              // ── Section: معلومات الحالة ──────────────────────────────
              _SectionHeader(title: 'معلومات الحالة'),
              const SizedBox(height: 10),
           
              _buildField(
                controller: _titleCtrl,
                label: 'عنوان الحالة',
                icon: Icons.title,
                validator: (v) =>
                    v == null || v.trim().isEmpty ? 'مطلوب' : null,
              ),
              const SizedBox(height: 12),
           
              _buildField(
                controller: _descCtrl,
                label: 'وصف الحالة',
                icon: Icons.description_outlined,
                maxLines: 4,
                validator: (v) =>
                    v == null || v.trim().isEmpty ? 'مطلوب' : null,
              ),
              const SizedBox(height: 12),
           
              // Category dropdown
              _buildDropdownCard(
                label: 'الفئة',
                icon: Icons.category_outlined,
                child: DropdownButton<int>(
                  value: _selectedCategoryId,
                  isExpanded: true,
                  underline: const SizedBox(),
                  hint: const Text('اختر الفئة'),
                  items: _categories
                      .map((c) => DropdownMenuItem<int>(
                            value: c['id'] as int,
                            child: Text(c['name'] as String),
                          ))
                      .toList(),
                  onChanged: (v) =>
                      setState(() => _selectedCategoryId = v),
                ),
              ),
              const SizedBox(height: 12),
           
              // Priority dropdown
              _buildDropdownCard(
                label: 'الأولوية',
                icon: Icons.flag_outlined,
                child: DropdownButton<String>(
                  value: _priority,
                  isExpanded: true,
                  underline: const SizedBox(),
                  items: _priorities
                      .map((p) => DropdownMenuItem(
                            value: p,
                            child: Text(_priorityLabel(p)),
                          ))
                      .toList(),
                  onChanged: (v) =>
                      setState(() => _priority = v ?? 'Normal'),
                ),
              ),
              const SizedBox(height: 20),
           
              // ── Section: بيانات المستفيد ─────────────────────────────
              _SectionHeader(title: 'بيانات المستفيد'),
              const SizedBox(height: 10),
           
              _buildField(
                controller: _beneficiaryCtrl,
                label: 'اسم المستفيد',
                icon: Icons.person_outline,
                validator: (v) =>
                    v == null || v.trim().isEmpty ? 'مطلوب' : null,
              ),
              const SizedBox(height: 12),
           
              _buildField(
                controller: _ageCtrl,
                label: 'العمر',
                icon: Icons.cake_outlined,
                keyboardType: TextInputType.number,
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'مطلوب';
                  if (int.tryParse(v.trim()) == null) {
                    return 'أدخل رقماً صحيحاً';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
           
              // ── Section: تفاصيل التبرع ───────────────────────────────
              _SectionHeader(title: 'تفاصيل التبرع'),
              const SizedBox(height: 10),
           
              _buildField(
                controller: _amountCtrl,
                label: 'المبلغ المستهدف (ج.م)',
                icon: Icons.attach_money,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'مطلوب';
                  if (double.tryParse(v.trim()) == null) {
                    return 'أدخل رقماً صحيحاً';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
           
              // End date picker
              GestureDetector(
                onTap: _pickEndDate,
                child: _buildDropdownCard(
                  label: 'تاريخ انتهاء الحالة (اختياري)',
                  icon: Icons.calendar_today_outlined,
                  child: Text(
                    _endDate != null
                        ? DateFormat('yyyy-MM-dd').format(_endDate!)
                        : 'اضغط لاختيار تاريخ',
                    style: TextStyle(
                      color: _endDate != null
                          ? kAdminTextDark
                          : kAdminTextGrey,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
           
              // ── Section: معلومات إضافية ──────────────────────────────
              _SectionHeader(title: 'معلومات إضافية'),
              const SizedBox(height: 10),
           
              _buildField(
                controller: _locationCtrl,
                label: 'الموقع (اختياري)',
                icon: Icons.location_on_outlined,
              ),
              const SizedBox(height: 12),
           
              // isFeatured toggle
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 12),
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
                        children: [
                          const Text(
                            'تمييز الحالة',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: kAdminTextDark),
                          ),
                          Text(
                            'ستظهر الحالة في القائمة المميزة',
                            style: TextStyle(
                                fontSize: 11, color: kAdminTextGrey),
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
           
              // ── Section: الملفات ─────────────────────────────────────
              _SectionHeader(title: 'الصور والمرفقات'),
              const SizedBox(height: 10),
           
              // Cover image picker
              GestureDetector(
                onTap: _pickCoverImage,
                child: Container(
                  height: 160,
                  decoration: BoxDecoration(
                    color: kAdminCardBg,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: appcolor.withOpacity(0.3), width: 1.5),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: _coverImage != null
                      ? Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.file(_coverImage!, fit: BoxFit.cover),
                            Positioned(
                              top: 6,
                              left: 6,
                              child: GestureDetector(
                                onTap: () =>
                                    setState(() => _coverImage = null),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.black54,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(Icons.close,
                                      color: Colors.white, size: 18),
                                ),
                              ),
                            ),
                          ],
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add_photo_alternate_outlined,
                                color: appcolor, size: 36),
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
           
              // Attachment files picker
              OutlinedButton.icon(
                onPressed: _pickAttachments,
                icon: const Icon(Icons.attach_file, color: appcolor),
                label: Text(
                  _attachments.isEmpty
                      ? 'إضافة ملفات مرفقة'
                      : 'تغيير المرفقات (${_attachments.length})',
                  style: const TextStyle(color: appcolor),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: appcolor),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  minimumSize: const Size(double.infinity, 48),
                ),
              ),
           
              if (_attachments.isNotEmpty) ...[
                const SizedBox(height: 8),
                ..._attachments.asMap().entries.map(
                      (e) => ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        leading: const Icon(Icons.insert_drive_file_outlined,
                            color: appcolor),
                        title: Text(
                          e.value.path.split('/').last,
                          style: const TextStyle(
                              fontSize: 12, color: kAdminTextDark),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.close,
                              size: 18, color: kAdminTextGrey),
                          onPressed: () => setState(
                              () => _attachments.removeAt(e.key)),
                        ),
                      ),
                    ),
              ],
           
              const SizedBox(height: 24),
           
              // ── Submit button ────────────────────────────────────────
              BlocBuilder<AdminCubit, AdminState>(
                builder: (context, state) {
                  final loading = state is CreateCaseLoading;
                  return ElevatedButton(
                    onPressed: loading ? null : _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1B5E20),
                      minimumSize: const Size(double.infinity, 52),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                    ),
                    child: loading
                        ? const SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                                color: Colors.white, strokeWidth: 2),
                          )
                        : const Text(
                            'حفظ الحالة',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                  );
                },
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
 
  // ── Reusable field builder ────────────────────────────────────────────────
  Widget _buildField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return  TextFormField(
  controller: controller,
  maxLines: maxLines,
  keyboardType: keyboardType,
  validator: validator,
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
 
  Widget _buildDropdownCard({
    required String label,
    required IconData icon,
    required Widget child,
  }) {
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
 
class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});
 
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
          title,
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