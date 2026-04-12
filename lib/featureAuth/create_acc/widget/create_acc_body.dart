import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/core/class/assets.dart';
import 'package:waslet_khier/core/class/showsnackbar.dart';
import 'package:waslet_khier/core/class/showsuccessdialog.dart';
import 'package:waslet_khier/featureAuth/Forgetpassword/data/presentation/views_model/widget/CustomAppbar.dart';
import 'package:waslet_khier/featureAuth/auth/presintation/view_model/custom_textfild.dart';
import 'package:waslet_khier/featureAuth/auth/presintation/view_model/widget/check_haveing_acc.dart';
import 'package:waslet_khier/featureAuth/auth/presintation/view_model/widget/custombuttom.dart';
import 'package:waslet_khier/featureAuth/create_acc/data/models/donor_register/donor_register.dart';

class CreateAccBody extends StatefulWidget {
  const CreateAccBody({super.key});

  @override
  State<CreateAccBody> createState() => _CreateAccBodyState();
}

class _CreateAccBodyState extends State<CreateAccBody> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Center(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const Custom_Appbar(),
                  const SizedBox(height: 20),
                  Image.asset(
                    Assets.personimage,
                    width: 100,
                    height: 100,
                    fit: BoxFit.fill,
                  ),
                  const Text("انشاء حساب", style: TextStyle(fontSize: 18)),
                  const SizedBox(height: 20),

                  CustomTextField(
                    controller: firstNameController,
                    labelText: "الاسم الاول",
                    prefxIcon: Icons.person,
                    hintTtxt: '',
                    isSuffixIcon: false,
                  ),
                  const SizedBox(height: 20),

                  CustomTextField(
                    controller: lastNameController,
                    labelText: "الاسم الثاني",
                    prefxIcon: Icons.person,
                    hintTtxt: '',
                    isSuffixIcon: false,
                  ),
                  const SizedBox(height: 20),

                  CustomTextField(
                    controller: phoneController,
                    labelText: "رقم الهاتف",
                    prefxIcon: Icons.phone,
                    hintTtxt: '',
                    isSuffixIcon: false,
                  ),
                  const SizedBox(height: 20),

                  CustomTextField(
                    controller: emailController,
                    labelText: 'البريد الالكتروني',
                    prefxIcon: FontAwesomeIcons.envelope,
                    hintTtxt: '',
                    isSuffixIcon: false,
                  ),
                  const SizedBox(height: 20),

                  CustomTextField(
                    controller: passwordController,
                    labelText: "كلمة المرور",
                    prefxIcon: Icons.lock_outline,
                    isSuffixIcon: true,
                    hintTtxt: '',
                  ),
                  const SizedBox(height: 20),

                  CustomTextField(
                    controller: confirmPasswordController,
                    labelText: "تاكيد كلمة المرور",
                    prefxIcon: Icons.lock_outline,
                    isSuffixIcon: true,
                    hintTtxt: '',
                  ),
                  const SizedBox(height: 30),

                  Custombuttom(
                    text: "انشاء",
                    onPressed: () async {
                      if (passwordController.text !=
                          confirmPasswordController.text) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("كلمتا المرور غير متطابقتين"),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }

                      if (formKey.currentState!.validate()) {
                        setState(() {
                          isLoading = true;
                        });
                        try {
                          showSuccessDialog(context);
                        } on FirebaseAuthException catch (e) {
                          showsnackbar(
                            e.code as FirebaseAuthException,
                            context,
                          );
                        } catch (ex) {
                          showsnackbar(
                            "حدث خطأ ما، حاول لاحقاً" as FirebaseAuthException,
                            context,
                          );
                        }
                        setState(() {
                          isLoading = false;
                        });
                      }
                    },
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
        ),
      ),
    );
  }
}
