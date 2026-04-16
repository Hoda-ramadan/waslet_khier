import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/core/class/showsuccessdialog.dart';
import 'package:waslet_khier/featureAuth/Forgetpassword/data/presentation/views_model/widget/CustomAppbar.dart';
import 'package:waslet_khier/featureAuth/auth/presintation/view_model/custom_textfild.dart';
import 'package:waslet_khier/featureAuth/auth/presintation/view_model/widget/check_haveing_acc.dart';
import 'package:waslet_khier/featureAuth/auth/presintation/view_model/widget/custombuttom.dart';
import 'package:waslet_khier/featureAuth/create_acc/data/cubits/registerCubit.dart';
import 'package:waslet_khier/featureAuth/create_acc/data/cubits/registerStates.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final GlobalKey<FormState> formKey = GlobalKey();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _onRegister(BuildContext context) {
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('كلمتا المرور غير متطابقتين'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (formKey.currentState!.validate()) {
      context.read<RegisterCubit>().register(
        FirstName: firstNameController.text.trim(),
        LastName: lastNameController.text.trim(),
        Phone: phoneController.text.trim(),
        Email: emailController.text.trim(),
        Password: passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Custom_Appbar(),
              Image.asset(
                'assets/images/radix-icons_avatar (1).png',
                fit: BoxFit.cover,
              ),
              const Text(
                'انشاء حساب',
                style: TextStyle(
                  fontSize: 22,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 30),

              CustomTextField(
                controller: firstNameController,
                labelText: 'الاسم الأول',
                prefxIcon: Icons.person,
                hintTtxt: '',
                isSuffixIcon: false,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الاسم الأول مطلوب';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),

              CustomTextField(
                controller: lastNameController,
                labelText: 'الاسم الأخير',
                prefxIcon: Icons.person,
                hintTtxt: '',
                isSuffixIcon: false,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الاسم الأخير مطلوب';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),

              CustomTextField(
                controller: phoneController,
                labelText: 'رقم الهاتف',
                prefxIcon: Icons.phone,
                hintTtxt: '',
                isSuffixIcon: false,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'رقم الهاتف مطلوب';
                  return null;
                },
              ),
              const SizedBox(height: 15),

              CustomTextField(
                controller: emailController,
                labelText: 'البريد الإلكتروني',
                prefxIcon: Icons.email,
                hintTtxt: '',
                isSuffixIcon: false,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'البريد مطلوب';
                  if (!value.contains('@')) return 'بريد إلكتروني غير صحيح';
                  return null;
                },
              ),
              const SizedBox(height: 15),

              CustomTextField(
                controller: passwordController,
                labelText: 'كلمة المرور',
                prefxIcon: Icons.lock_outline,
                hintTtxt: '',
                isSuffixIcon: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'كلمة المرور مطلوبة';
                  }
                  if (value.length < 6) return 'كلمة المرور أقل من 6 أحرف';
                  return null;
                },
              ),
              const SizedBox(height: 15),

              CustomTextField(
                controller: confirmPasswordController,
                labelText: 'تأكيد كلمة المرور',
                prefxIcon: Icons.lock_outline,
                hintTtxt: '',
                isSuffixIcon: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'تأكيد كلمة المرور مطلوب';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),

              BlocConsumer<RegisterCubit, RegisterState>(
                listener: (context, state) {
                  if (state is RegisterSuccess) {
                    showSuccessDialog(context);
                  } else if (state is RegisterFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  final isLoading = state is RegisterLoading;
                  return Custombuttom(
                    text: isLoading ? 'جاري الإنشاء...' : 'انشاء',
                    onPressed: isLoading ? null : () => _onRegister(context),
                    color: appcolor,
                    textcolor: Colors.white,
                  );
                },
              ),

              const SizedBox(height: 30),

              checkhavingAcc(
                text1: 'لديك حساب بالفعل؟ ',
                text2: 'سجل الدخول الان',
                textcolor1: Colors.deepOrange,
                textcolor2: Colors.black,
                path: '',
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
