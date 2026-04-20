import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/featureAuth/auth/data/models/login_response_model.dart';
import 'package:waslet_khier/featureAuth/auth/presintation/view_model/widget/custombuttom.dart';
import 'package:waslet_khier/featureAuth/authprovider.dart/authprovider.dart';
import 'package:waslet_khier/features/profile_feature/views/widgets/customtextformfeild.dart';
import 'package:waslet_khier/features/profile_feature/views/widgets/persoinalinfo_view.dart';

class PersoninfoView_body extends StatefulWidget {
  const PersoninfoView_body({super.key});

  @override
  State<PersoninfoView_body> createState() => _PersoninfoView_bodyState();
}

class _PersoninfoView_bodyState extends State<PersoninfoView_body> {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;

  @override
  void initState() {
    super.initState();
    final donor = context.read<AuthProvider_info>().donor;
    firstNameController = TextEditingController(text: donor?.firstName ?? '');
    lastNameController = TextEditingController(text: donor?.lastName ?? '');
    emailController = TextEditingController(text: donor?.email ?? '');
    phoneController = TextEditingController(text: donor?.phoneNumber ?? '');
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AuthProvider_info>();
    final donor = provider.donor;

    if (donor == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const SizedBox(height: 10),
            customappbar(text: 'المعلومات الشخصية'),

            // 👤 Avatar + Name
            Center(
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/radix-icons_avatar (1).png',
                    width: 70,
                    height: 105,
                  ),
                  Text(donor.firstName),
                ],
              ),
            ),
            const SizedBox(height: 20),

            const Text('الاسم الاول'),
            customtextformfeild(
              controller: firstNameController,
              icon: Icons.person,
            ),
            const SizedBox(height: 10),

            const Text('الاسم الثاني'),
            customtextformfeild(
              controller: lastNameController,
              icon: Icons.person,
            ),
            const SizedBox(height: 10),

            const Text('البريد الالكتروني'),
            customtextformfeild(
              controller: emailController,
              icon: Icons.email,
            ),
            const SizedBox(height: 10),

            const Text('رقم الهاتف'),
            customtextformfeild(
              controller: phoneController,
              icon: Icons.smartphone,
            ),
            const SizedBox(height: 30),

            // 🔐 Change Password
            GestureDetector(
              onTap: () => context.go('/profile/logout/forgetpassword'),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Row(
                  children: [
                    Icon(Icons.lock_clock_outlined, color: tintAppColor),
                    const SizedBox(width: 5),
                    Text(
                      'تغيير كلمة المرور',
                      style: TextStyle(color: tintAppColor),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),

            // 💾 Save Button
            Custombuttom(
              onPressed: () {
                final updatedDonor = DonorModel(
                  id: donor.id,
                  firstName: firstNameController.text.trim(),
                  lastName: lastNameController.text.trim(),
                  email: emailController.text.trim(),
                  phoneNumber: phoneController.text.trim(),
                  imageUrl: donor.imageUrl, // ✅ keep original
                );

                context.read<AuthProvider_info>().setAuthData(
                  token: provider.token,
                  donor: updatedDonor,
                );

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('تم حفظ التعديلات بنجاح')),
                );
              },
              text: 'حفظ التعديلات',
              color: tintAppColor,
              textcolor: Colors.white,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}