import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/core/class/assets.dart';
import 'package:waslet_khier/featureAuth/Forgetpassword/data/cubit/resetpasswordcubit.dart';
import 'package:waslet_khier/featureAuth/Forgetpassword/data/cubit/resetpasswordstates.dart';
import 'package:waslet_khier/featureAuth/Forgetpassword/presentation/views/widget/CustomAppbar.dart';
import 'package:waslet_khier/featureAuth/auth/presintation/view_model/custom_textfild.dart';
import 'package:waslet_khier/featureAuth/auth/presintation/view_model/widget/custombuttom.dart';

class ForgetPasswordBody extends StatefulWidget {
  const ForgetPasswordBody({super.key});

  @override
  State<ForgetPasswordBody> createState() => _ForgetPasswordBodyState();
}

class _ForgetPasswordBodyState extends State<ForgetPasswordBody> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ResetpasswordCubit, ForgetPasswordState>(
      listener: (context, state) {
        // في forgetpasswordview_body.dart - لما ينجح
        if (state is ForgetPasswordSuccess) {
          context.push(
            '/profile/logout/forgetpassword/VerifycodeView',
            extra: context.read<ResetpasswordCubit>(), // ✅ بتبعت نفس الـ cubit
          );
        } else if (state is ForgetPasswordFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error), backgroundColor: Colors.red),
          );
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const Custom_Appbar(),
                const SizedBox(height: 20),
                SvgPicture.asset(
                  Assets.forgetpasswordimage,
                  height: 277,
                  width: 302,
                  fit: BoxFit.fill,
                ),
                const SizedBox(height: 20),
                const ListTile(
                  title: Text("هل نسيت كلمة المرور؟", textAlign: TextAlign.end),
                  subtitle: Text(
                    "يرجى ادخال البريد الالكتروني لتغيير كلمة المرور",
                    textAlign: TextAlign.end,
                  ),
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: _emailController,
                  labelText: "البريد الالكتروني",
                  hintTtxt: "",
                  prefxIcon: FontAwesomeIcons.envelope,
                  isSuffixIcon: false,
                ),
                const SizedBox(height: 20),
                state is ForgetPasswordLoading
                    ? const CircularProgressIndicator(color: appcolor)
                    : Custombuttom(
                        text: "التالي",
                        color: appcolor,
                        textcolor: Colors.white,
                        onPressed: () {
                          context.read<ResetpasswordCubit>().sendEmail(
                            _emailController.text.trim(),
                          );
                        },
                      ),
                const SizedBox(height: 100),
              ],
            ),
          ),
        );
      },
    );
  }
}
