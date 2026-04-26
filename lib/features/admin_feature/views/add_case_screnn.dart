import 'dart:typed_data';
 
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
 
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/core/api/api_service.dart';
import 'package:waslet_khier/featureAuth/authprovider.dart/authprovider.dart';
import 'package:waslet_khier/features/admin_feature/data/create_case_model.dart';
import 'package:waslet_khier/features/admin_feature/data/create_case_request_model.dart';
import 'package:waslet_khier/features/admin_feature/data/cubit/admin_sates_cubit.dart';
import 'package:waslet_khier/features/admin_feature/data/cubit/admin_states.dart';
import '../admin_constants.dart';
 
class _PickedFile {
  final String name;
  final String? path;
  final Uint8List? bytes;
  _PickedFile({required this.name, this.path, this.bytes});
}
 
class AddCaseScreen extends StatefulWidget {
  const AddCaseScreen({super.key});
 
  @override
  State<AddCaseScreen> createState() => _AddCaseScreenState();
}
 
class _AddCaseScreenState extends State<AddCaseScreen> {
  final _formKey = GlobalKey<FormState>();
 
  final _titleCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  final _beneficiaryCtrl = TextEditingController();
  final _ageCtrl = TextEditingController();
  final _amountCtrl = TextEditingController();
  final _locationCtrl = TextEditingController();
 
  List<Map<String, dynamic>> _categories = [];
  bool _categoriesLoading = true;
 
  int? _selectedCategoryId;
  String _priority = 'Normal';
  bool _isFeatured = false;
  DateTime? _endDate;
 
  XFile? _coverXFile;
  Uint8List? _coverBytes;
  List<_PickedFile> _attachments = [];
 
  @override
  void initState() {
    super.initState();
    _loadCategories();
  }
 
  Future<void> _loadCategories() async {
    final charityId = context.read<AdminCubit>().charityId;
    try {
      final apiService = ApiService(Dio());
      final response =
          await apiService.get(endPoint: '/Category') as List<dynamic>;
      final filtered = response
          .map((e) => e as Map<String, dynamic>)
          .where((c) => c['charityId'] == charityId)
          .map((c) => {'id': c['id'] as int, 'name': c['name'] as String})
          .toList();
      setState(() {
        _categories = filtered;
        _categoriesLoading = false;
      });
    } catch (e) {
      setState(() => _categoriesLoading = false);
      if (mounted) {
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
    final picked = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );
    if (picked == null) return;
    final bytes = await picked.readAsBytes();
    setState(() {
      _coverXFile = picked;
      _coverBytes = bytes;
    });
  }
 
  Future<void> _pickAttachments() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.any,
      withData: kIsWeb,
    );
    if (result == null) return;
    setState(() {
      _attachments = result.files
          .map(
            (f) => _PickedFile(
              name: f.name,
              path: kIsWeb ? null : f.path,
              bytes: kIsWeb ? f.bytes : null,
            ),
          )
          .toList();
    });
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
 
  // ✅ NEW: Show Add Category Dialog
  Future<void> _showAddCategoryDialog() async {
    final nameCtrl = TextEditingController();
    final formKey = GlobalKey<FormState>();
    bool isLoading = false;
    XFile? iconXFile;
    Uint8List? iconBytes;
 
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setDialogState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              title: Row(
                children: [
                  Icon(Icons.category_outlined, color: appcolor),
                  const SizedBox(width: 8),
                  const Text('إضافة فئة جديدة'),
                ],
              ),
              content: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Name field
                    TextFormField(
                      controller: nameCtrl,
                      validator: (v) =>
                          v == null || v.trim().isEmpty ? 'مطلوب' : null,
                      decoration: InputDecoration(
                        labelText: 'اسم الفئة',
                        prefixIcon:
                            Icon(Icons.label_outline, color: appcolor),
                        filled: true,
                        fillColor: kAdminCardBg,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              BorderSide(color: appcolor, width: 1.5),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              const BorderSide(color: Colors.red),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              const BorderSide(color: Colors.red),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
 
                    // Icon image picker
                    GestureDetector(
                      onTap: () async {
                        final picked = await ImagePicker().pickImage(
                          source: ImageSource.gallery,
                          imageQuality: 85,
                        );
                        if (picked == null) return;
                        final bytes = await picked.readAsBytes();
                        setDialogState(() {
                          iconXFile = picked;
                          iconBytes = bytes;
                        });
                      },
                      child: Container(
                        height: 100,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: kAdminCardBg,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: appcolor.withOpacity(0.3)),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: iconBytes != null
                            ? Stack(
                                fit: StackFit.expand,
                                children: [
                                  Image.memory(iconBytes!,
                                      fit: BoxFit.cover),
                                  Positioned(
                                    top: 4,
                                    right: 4,
                                    child: GestureDetector(
                                      onTap: () =>
                                          setDialogState(() {
                                        iconXFile = null;
                                        iconBytes = null;
                                      }),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: Colors.black54,
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(Icons.close,
                                            color: Colors.white,
                                            size: 16),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.center,
                                children: [
                                  Icon(
                                      Icons
                                          .add_photo_alternate_outlined,
                                      color: appcolor,
                                      size: 28),
                                  const SizedBox(height: 4),
                                  Text(
                                    'أيقونة الفئة (اختياري)',
                                    style: TextStyle(
                                        color: kAdminTextGrey,
                                        fontSize: 12),
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed:
                      isLoading ? null : () => Navigator.of(ctx).pop(),
                  child: const Text('إلغاء',
                      style: TextStyle(color: Colors.grey)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: appcolor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: isLoading
                      ? null
                      : () async {
                          if (!formKey.currentState!.validate()) return;
                          setDialogState(() => isLoading = true);
 
                          try {
                            final charityId =
                                context.read<AdminCubit>().charityId;
                            final apiService = ApiService(Dio());
 
                            final formData = FormData.fromMap({
                              'Name': nameCtrl.text.trim(),
                              'CharityId': charityId.toString(),
                              if (iconBytes != null && iconXFile != null)
                                'IconFile': MultipartFile.fromBytes(
                                  iconBytes!,
                                  filename: iconXFile!.name,
                                ),
                            });
 
                            await apiService.dio.post(
                              '${apiService.baseurl}/Category',
                              data: formData,
                            );
 
                            // ✅ Reload categories after creation
                            await _loadCategories();
 
                            if (mounted) {
                              Navigator.of(ctx).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      const Text('تم إنشاء الفئة بنجاح ✓'),
                                  backgroundColor: appcolor,
                                ),
                              );
                            }
                          } catch (e) {
                            setDialogState(() => isLoading = false);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('فشل إنشاء الفئة: $e'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                  child: isLoading
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                              color: Colors.white, strokeWidth: 2),
                        )
                      : const Text('إضافة',
                          style: TextStyle(color: Colors.white)),
                ),
              ],
            );
          },
        );
      },
    );
  }
 
  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedCategoryId == null) {
      _showError('يرجى اختيار الفئة');
      return;
    }
 
    final cubit = context.read<AdminCubit>();
    final authProvider =
        Provider.of<AuthProvider_info>(context, listen: false);
    final adminId = authProvider.admin?.id ?? 0;
 
    print('=== SUBMIT DEBUG ===');
    print('adminId: $adminId');
    print('charityId: ${cubit.charityId}');
    print('categoryId: $_selectedCategoryId');
    print('title: ${_titleCtrl.text.trim()}');
    print('attachments count: ${_attachments.length}');
    print('cover image: ${_coverXFile?.name}');
    print('====================');
 
    if (adminId == 0) {
      _showError('خطأ: يرجى إعادة تسجيل الدخول');
      return;
    }
 
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
      adminId: adminId,
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
      coverImagePath: kIsWeb ? null : _coverXFile?.path,
      coverImageBytes: kIsWeb ? _coverBytes : null,
      coverImageName: _coverXFile?.name,
      attachmentPaths:
          kIsWeb ? [] : _attachments.map((f) => f.path!).toList(),
      attachmentBytes:
          kIsWeb ? _attachments.map((f) => f.bytes!).toList() : [],
      attachmentNames: _attachments.map((f) => f.name).toList(),
    );
  }
 
  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(msg), backgroundColor: Colors.red));
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
 
  @override
  Widget build(BuildContext context) {
    return BlocListener<AdminCubit, AdminState>(
      listener: (context, state) {
        if (state is CreateCaseSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: appcolor,
            ),
          );
          Navigator.of(context).pop(true);
        } else if (state is CreateCaseFailure) {
          _showError(state.error);
        }
      },
      child: Scaffold(
        backgroundColor: kAdminBackground,
        appBar: AppBar(
          backgroundColor: appcolor,
          foregroundColor: Colors.white,
          title: const Text(
            'إضافة حالة جديدة',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: [
            BlocBuilder<AdminCubit, AdminState>(
              builder: (context, state) => state is CreateCaseLoading
                  ? const Padding(
                      padding: EdgeInsets.all(16),
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      ),
                    )
                  : IconButton(
                      icon: const Icon(Icons.check),
                      onPressed: _submit,
                    ),
            ),
          ],
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _SectionHeader(title: 'معلومات الحالة'),
              const SizedBox(height: 10),
              _field(
                _titleCtrl,
                'عنوان الحالة',
                Icons.title,
                validator: _required,
              ),
              const SizedBox(height: 12),
              _field(
                _descCtrl,
                'وصف الحالة',
                Icons.description_outlined,
                maxLines: 4,
                validator: _required,
              ),
              const SizedBox(height: 12),
 
              // ✅ Category dropdown with Add Category button
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
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ✅ Add Category button at top of list
                          GestureDetector(
                            onTap: _showAddCategoryDialog,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 10),
                              margin: const EdgeInsets.only(bottom: 8),
                              decoration: BoxDecoration(
                                color: appcolor.withOpacity(0.08),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: appcolor.withOpacity(0.3)),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.add_circle_outline,
                                      color: appcolor, size: 18),
                                  const SizedBox(width: 6),
                                  Text(
                                    'إضافة فئة جديدة',
                                    style: TextStyle(
                                        color: appcolor, fontSize: 13),
                                  ),
                                ],
                              ),
                            ),
                          ),
 
                          // ✅ Normal dropdown (or empty message)
                          _categories.isEmpty
                              ? const Text(
                                  'لا توجد فئات لهذه الجمعية',
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 12),
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
                                          child:
                                              Text(c['name'] as String),
                                        ),
                                      )
                                      .toList(),
                                  onChanged: (v) => setState(
                                      () => _selectedCategoryId = v),
                                ),
                        ],
                      ),
              ),
              const SizedBox(height: 12),
 
              _dropCard(
                'الأولوية',
                Icons.flag_outlined,
                DropdownButton<String>(
                  value: _priority,
                  isExpanded: true,
                  underline: const SizedBox(),
                  items: ['Normal', 'Urgent', 'Critical']
                      .map(
                        (p) => DropdownMenuItem(
                          value: p,
                          child: Text(
                            p == 'Urgent'
                                ? 'عاجل'
                                : p == 'Critical'
                                    ? 'حرج'
                                    : 'عادية',
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (v) =>
                      setState(() => _priority = v ?? 'Normal'),
                ),
              ),
              const SizedBox(height: 20),
 
              _SectionHeader(title: 'بيانات المستفيد'),
              const SizedBox(height: 10),
              _field(
                _beneficiaryCtrl,
                'اسم المستفيد',
                Icons.person_outline,
                validator: _required,
              ),
              const SizedBox(height: 12),
              _field(
                _ageCtrl,
                'العمر',
                Icons.cake_outlined,
                keyboardType: TextInputType.number,
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'مطلوب';
                  if (int.tryParse(v.trim()) == null)
                    return 'رقم غير صحيح';
                  return null;
                },
              ),
              const SizedBox(height: 20),
 
              _SectionHeader(title: 'تفاصيل التبرع'),
              const SizedBox(height: 10),
              _field(
                _amountCtrl,
                'المبلغ المستهدف (ج.م)',
                Icons.attach_money,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'مطلوب';
                  if (double.tryParse(v.trim()) == null)
                    return 'رقم غير صحيح';
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
 
              _SectionHeader(title: 'معلومات إضافية'),
              const SizedBox(height: 10),
              _field(
                _locationCtrl,
                'الموقع (اختياري)',
                Icons.location_on_outlined,
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 12,
                ),
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
                              color: kAdminTextDark,
                            ),
                          ),
                          Text(
                            'ستظهر الحالة في القائمة المميزة',
                            style: TextStyle(
                              fontSize: 11,
                              color: kAdminTextGrey,
                            ),
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
 
              _SectionHeader(title: 'الصور والمرفقات'),
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
                  child: _coverBytes != null
                      ? Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.memory(_coverBytes!, fit: BoxFit.cover),
                            Positioned(
                              top: 6,
                              left: 6,
                              child: GestureDetector(
                                onTap: () => setState(() {
                                  _coverXFile = null;
                                  _coverBytes = null;
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
                  _attachments.isEmpty
                      ? 'إضافة ملفات مرفقة'
                      : 'تغيير المرفقات (${_attachments.length})',
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
              ..._attachments.asMap().entries.map(
                    (e) => ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(
                        Icons.insert_drive_file_outlined,
                        color: appcolor,
                      ),
                      title: Text(
                        e.value.name,
                        style: const TextStyle(
                            fontSize: 12, color: kAdminTextDark),
                      ),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.close,
                          size: 18,
                          color: kAdminTextGrey,
                        ),
                        onPressed: () =>
                            setState(() => _attachments.removeAt(e.key)),
                      ),
                    ),
                  ),
 
              const SizedBox(height: 24),
 
              BlocBuilder<AdminCubit, AdminState>(
                builder: (context, state) {
                  final loading = state is CreateCaseLoading;
                  return ElevatedButton(
                    onPressed: loading ? null : _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: appcolor,
                      minimumSize: const Size(double.infinity, 52),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: loading
                        ? const SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : const Text(
                            'حفظ الحالة',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
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
 
  String? _required(String? v) =>
      v == null || v.trim().isEmpty ? 'مطلوب' : null;
 
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