import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/core/class/assets.dart';
import 'package:waslet_khier/featureAuth/Forgetpassword/data/cubit/resetpasswordcubit.dart';
import 'package:waslet_khier/featureAuth/Forgetpassword/data/cubit/resetpasswordstates.dart';
import 'package:waslet_khier/featureAuth/Forgetpassword/presentation/views/widget/CustomAppbar.dart';
import 'package:waslet_khier/featureAuth/auth/presintation/view_model/custom_textfild.dart';
import 'package:waslet_khier/featureAuth/auth/presintation/view_model/widget/custombuttom.dart';

class ChangePasswordBody extends StatefulWidget {
  const ChangePasswordBody({super.key});

  @override
  State<ChangePasswordBody> createState() => _ChangePasswordBodyState();
}

class _ChangePasswordBodyState extends State<ChangePasswordBody> {
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  @override
  void dispose() {
    _passController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ResetpasswordCubit, ForgetPasswordState>(
      listener: (context, state) {
        if (state is ChangePasswordSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.green,
            ),
          );
          context.go('/login');
        } else if (state is ChangePasswordFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error), backgroundColor: Colors.red),
          );
        }
      },
      builder: (context, state) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const Custom_Appbar(),
                SvgPicture.asset(
                  Assets.loginimage,
                  width: 247,
                  height: 254,
                  fit: BoxFit.fill,
                ),
                const Text(
                  "انشئ كلمة مرور جديدة",
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 17),
                CustomTextField(
                  controller: _passController,
                  labelText: "كلمة المرور",
                  hintTtxt: '',
                  prefxIcon: Icons.lock_outline,
                  isSuffixIcon: true,
                ),
                const SizedBox(height: 17),
                CustomTextField(
                  controller: _confirmController,
                  labelText: "تاكيد كلمة المرور",
                  hintTtxt: '',
                  prefxIcon: Icons.lock_outline,
                  isSuffixIcon: true,
                ),
                const SizedBox(height: 17),
                state is ChangePasswordLoading
                    ? const CircularProgressIndicator()
                    : Custombuttom(
                        text: "تغيير",
                        color: appcolor,
                        textcolor: Colors.white,
                        onPressed: () {
                          context.read<ResetpasswordCubit>().changePassword(
                            newPassword: _passController.text.trim(),
                            confirmPassword: _confirmController.text.trim(),
                          );
                        },
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}
