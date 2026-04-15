import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/core/class/showsuccessdialog.dart';
import 'package:waslet_khier/featureAuth/Forgetpassword/data/presentation/views_model/widget/CustomAppbar.dart';
import 'package:waslet_khier/featureAuth/auth/presintation/view_model/custom_textfild.dart';
import 'package:waslet_khier/featureAuth/auth/presintation/view_model/widget/check_haveing_acc.dart';
import 'package:waslet_khier/featureAuth/auth/presintation/view_model/widget/custombuttom.dart';

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
                "assets/images/radix-icons_avatar (1).png",
                fit: BoxFit.cover,
              ),
              Text(
                "انشاء حساب",
                style: TextStyle(
                  fontSize: 22,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 30),

              CustomTextField(
                validator: (value) {},
                controller: firstNameController,
                labelText: "الاسم الأول",
                prefxIcon: Icons.person,
                hintTtxt: '',
                isSuffixIcon: false,
              ),
              const SizedBox(height: 15),

              CustomTextField(
                validator: (value) {},
                controller: lastNameController,
                labelText: "الاسم الأخير",
                prefxIcon: Icons.person,
                hintTtxt: '',
                isSuffixIcon: false,
              ),
              const SizedBox(height: 15),

              CustomTextField(
                validator: (value) {},
                controller: phoneController,
                labelText: "رقم الهاتف",
                prefxIcon: Icons.phone,
                hintTtxt: '',
                isSuffixIcon: false,
              ),
              const SizedBox(height: 15),

              CustomTextField(
                validator: (value) {},
                controller: emailController,
                labelText: "البريد الإلكتروني",
                prefxIcon: Icons.email,
                hintTtxt: '',
                isSuffixIcon: false,
              ),
              const SizedBox(height: 15),

              CustomTextField(
                validator: (value) {},
                controller: passwordController,
                labelText: "كلمة المرور",
                prefxIcon: Icons.lock_outline,
                isSuffixIcon: true,
                hintTtxt: '',
              ),
              const SizedBox(height: 20),

              CustomTextField(
                validator: (value) {},
                controller: confirmPasswordController,
                labelText: "تأكيد كلمة المرور",
                prefxIcon: Icons.lock_outline,
                isSuffixIcon: true,
                hintTtxt: '',
              ),
              const SizedBox(height: 30),

              Custombuttom(
                onPressed: () {},
                text: "انشاء",
                color: appcolor,
                textcolor: Colors.white,
              ),

              const SizedBox(height: 30),

              checkhavingAcc(
                text1: "لديك حساب بالفعل؟ ",
                text2: "سجل الدخول الان",
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
