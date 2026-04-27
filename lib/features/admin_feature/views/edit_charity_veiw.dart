import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/features/admin_feature/data/cubit/update_charity_details_cubit.dart';
import 'package:waslet_khier/features/admin_feature/data/cubit/update_charity_detals_states.dart';
import 'package:waslet_khier/features/charity_feature/data/models/charity_model.dart';
 
class EditCharityPage extends StatefulWidget {
  final CharityModel charity;
 
  const EditCharityPage({super.key, required this.charity});
 
  @override
  State<EditCharityPage> createState() => _EditCharityPageState();
}
 
class _EditCharityPageState extends State<EditCharityPage> {
  final _formKey = GlobalKey<FormState>();
 
  late final TextEditingController _nameCtrl;
  late final TextEditingController _addressCtrl;
  late final TextEditingController _phoneCtrl;
  late final TextEditingController _emailCtrl;
  late final TextEditingController _facebookCtrl;
  late final TextEditingController _websiteCtrl;
  late final TextEditingController _instagramCtrl;
  late final TextEditingController _descCtrl;
 
  File? _logoFile;
  File? _coverImageFile;
  File? _mapFile;
 
  String? _logoFileName;
  String? _coverImageFileName;
  String? _mapFileName;
 
  @override
  void initState() {
    super.initState();
    final c = widget.charity;
    _nameCtrl      = TextEditingController(text: c.name ?? '');
    _addressCtrl   = TextEditingController(text: c.address ?? '');
    _phoneCtrl     = TextEditingController(text: c.phoneNumber ?? '');
    _emailCtrl     = TextEditingController(text: c.email ?? '');
    _facebookCtrl  = TextEditingController(text: c.facebookUrl ?? '');
    _websiteCtrl   = TextEditingController(text: c.websiteUrl ?? '');
    _instagramCtrl = TextEditingController(text: c.instagramUrl ?? '');
    _descCtrl      = TextEditingController(text: c.description ?? '');
  }
 
  @override
  void dispose() {
    _nameCtrl.dispose();
    _addressCtrl.dispose();
    _phoneCtrl.dispose();
    _emailCtrl.dispose();
    _facebookCtrl.dispose();
    _websiteCtrl.dispose();
    _instagramCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }
 
  Future<void> _pickFile({
    required void Function(File file, String name) onPicked,
  }) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
      allowMultiple: false,
    );
    if (result != null && result.files.single.path != null) {
      final file = File(result.files.single.path!);
      final name = result.files.single.name;
      setState(() => onPicked(file, name));
    }
  }
 
  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
 
    final formData = FormData.fromMap({
      'Name':         _nameCtrl.text.trim(),
      'Address':      _addressCtrl.text.trim(),
      'PhoneNumber':  _phoneCtrl.text.trim(),
      'Email':        _emailCtrl.text.trim(),
      'FacebookUrl':  _facebookCtrl.text.trim(),
      'WebsiteUrl':   _websiteCtrl.text.trim(),
      'InstagramUrl': _instagramCtrl.text.trim(),
      'Description':  _descCtrl.text.trim(),
      if (_logoFile != null)
        'LogoFile': await MultipartFile.fromFile(
            _logoFile!.path, filename: _logoFileName),
      if (_coverImageFile != null)
        'CoverImageFile': await MultipartFile.fromFile(
            _coverImageFile!.path, filename: _coverImageFileName),
      if (_mapFile != null)
        'MapFile': await MultipartFile.fromFile(
            _mapFile!.path, filename: _mapFileName),
    });
 
    context.read<EditCharityCubit>().updateCharity(
      charityId: widget.charity.id!,
      formData: formData,
    );
  }
 
  @override
  Widget build(BuildContext context) {
    return BlocListener<EditCharityCubit, EditCharityState>(
      listener: (context, state) {
        if (state is EditCharitySuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('تم تحديث بيانات الجمعية بنجاح'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pop(context);
        } else if (state is EditCharityFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: backGroundColor,
        appBar: AppBar(
          backgroundColor: appcolor,
          title: const Text(
            'تعديل بيانات الجمعية',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Text Fields ──────────────────────────────────────────
                  _buildField('اسم الجمعية', _nameCtrl, Icons.business_rounded),
                  _buildField('العنوان', _addressCtrl, Icons.location_on_outlined),
                  _buildField(
                    'رقم الهاتف',
                    _phoneCtrl,
                    Icons.phone_outlined,
                    keyboardType: TextInputType.phone,
                    isLtr: true, // ✅ phone numbers are LTR
                  ),
                  _buildField(
                    'البريد الإلكتروني',
                    _emailCtrl,
                    Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    isLtr: true, // ✅ emails are LTR
                  ),
                  _buildField(
                    'رابط فيسبوك',
                    _facebookCtrl,
                    Icons.link_rounded,
                    isLtr: true, // ✅ URLs are LTR
                  ),
                  _buildField(
                    'الموقع الإلكتروني',
                    _websiteCtrl,
                    Icons.public_rounded,
                    isLtr: true, // ✅ URLs are LTR
                  ),
                  _buildField(
                    'رابط إنستغرام',
                    _instagramCtrl,
                    Icons.camera_alt_outlined,
                    isLtr: true, // ✅ URLs are LTR
                  ),
                  _buildField(
                    'الوصف',
                    _descCtrl,
                    Icons.description_outlined,
                    maxLines: 3,
                  ),
 
                  const SizedBox(height: 8),
                  const Text(
                    'الملفات',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 10),
 
                  // ── File Pickers ─────────────────────────────────────────
                  _buildFilePicker(
                    label: 'شعار الجمعية',
                    icon: Icons.image_outlined,
                    fileName: _logoFileName,
                    onTap: () => _pickFile(
                      onPicked: (f, n) {
                        _logoFile = f;
                        _logoFileName = n;
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildFilePicker(
                    label: 'صورة الغلاف',
                    icon: Icons.photo_outlined,
                    fileName: _coverImageFileName,
                    onTap: () => _pickFile(
                      onPicked: (f, n) {
                        _coverImageFile = f;
                        _coverImageFileName = n;
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildFilePicker(
                    label: 'خريطة الموقع',
                    icon: Icons.map_outlined,
                    fileName: _mapFileName,
                    onTap: () => _pickFile(
                      onPicked: (f, n) {
                        _mapFile = f;
                        _mapFileName = n;
                      },
                    ),
                  ),
 
                  const SizedBox(height: 24),
 
                  // ── Save Button ──────────────────────────────────────────
                  BlocBuilder<EditCharityCubit, EditCharityState>(
                    builder: (context, state) {
                      final isLoading = state is EditCharityLoading;
                      return SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton.icon(
                          onPressed: isLoading ? null : _submit,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: appcolor,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          icon: isLoading
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Icon(Icons.save_rounded),
                          label: Text(
                            isLoading ? 'جاري الحفظ...' : 'حفظ التغييرات',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
 
  Widget _buildField(
    String label,
    TextEditingController controller,
    IconData icon, {
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    bool isLtr = false, // ✅ flag for fields that need LTR (URLs, emails, phones)
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        // ✅ FIX: use textDirection per field instead of textAlign
        // Arabic fields: RTL so cursor starts right and text flows right
        // LTR fields (URLs/email/phone): LTR so typing works correctly
        textDirection: isLtr ? TextDirection.ltr : TextDirection.rtl,
        textAlign: isLtr ? TextAlign.left : TextAlign.right,
        validator: (v) =>
            (v == null || v.isEmpty) ? 'هذا الحقل مطلوب' : null,
        decoration: InputDecoration(
          labelText: label,
          // ✅ flip icon position for LTR fields inside RTL layout
          prefixIcon: isLtr ? null : Icon(icon, color: appcolor),
          suffixIcon: isLtr ? Icon(icon, color: appcolor) : null,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: appcolor, width: 1.5),
          ),
          labelStyle: const TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
 
  Widget _buildFilePicker({
    required String label,
    required IconData icon,
    required String? fileName,
    required VoidCallback onTap,
  }) {
    final picked = fileName != null;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: picked ? appcolor.withOpacity(0.05) : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: picked ? appcolor : Colors.grey.shade200,
            width: picked ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              picked ? Icons.check_circle_rounded : Icons.upload_file_rounded,
              color: picked ? appcolor : Colors.grey,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                picked ? fileName! : label,
                style: TextStyle(
                  color: picked ? appcolor : Colors.grey,
                  fontSize: 14,
                  fontWeight: picked ? FontWeight.w600 : FontWeight.normal,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.grey,
              size: 14,
            ),
          ],
        ),
      ),
    );
  }
}