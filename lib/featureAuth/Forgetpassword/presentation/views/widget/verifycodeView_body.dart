import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/core/class/assets.dart';
import 'package:waslet_khier/featureAuth/Forgetpassword/data/cubit/resetpasswordcubit.dart';
import 'package:waslet_khier/featureAuth/Forgetpassword/data/cubit/resetpasswordstates.dart';
import 'package:waslet_khier/featureAuth/Forgetpassword/presentation/views/widget/CustomAppbar.dart';
import 'package:waslet_khier/featureAuth/Forgetpassword/presentation/views/widget/getcodefield.dart';
import 'package:waslet_khier/featureAuth/auth/presintation/view_model/widget/custombuttom.dart';

class VerifyCodeBody extends StatefulWidget {
  const VerifyCodeBody({super.key});

  @override
  State<VerifyCodeBody> createState() => _VerifyCodeBodyState();
}

class _VerifyCodeBodyState extends State<VerifyCodeBody> {
  late List<TextEditingController> controllers;
  late List<FocusNode> focusNodes;

  @override
  void initState() {
    super.initState();
    controllers = List.generate(6, (_) => TextEditingController());
    focusNodes = List.generate(6, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (var c in controllers) {
      c.dispose();
    }
    for (var f in focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  String get code => controllers.map((e) => e.text).join();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ResetpasswordCubit, ForgetPasswordState>(
      listener: (context, state) {
        // في verifycodeView_body.dart - لما ينجح
        if (state is VerifyCodeSuccess) {
          context.push(
            '/profile/logout/forgetpassword/VerifycodeView/ChangepasswordView',
            extra: context
                .read<
                  ResetpasswordCubit
                >(), // ✅ نفس الـ cubit فيه الـ verifyToken
          );
        } else if (state is VerifyCodeFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error), backgroundColor: Colors.red),
          );
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const Custom_Appbar(),
                SvgPicture.asset(
                  Assets.verifycodeimage,
                  height: 277,
                  width: 302,
                  fit: BoxFit.fill,
                ),
                const Text(
                  "ادخل رمز التحقق",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                const Text(
                  "تم ارسال رمز مكون من 6 ارقام الى بريدك الالكتروني",
                  style: TextStyle(fontSize: 12, color: Color(0xFF696B6A)),
                ),
                const SizedBox(height: 20),
                Getcodefield(controllers: controllers, focusNodes: focusNodes),
                const SizedBox(height: 20),
                state is VerifyCodeLoading
                    ? const CircularProgressIndicator()
                    : Custombuttom(
                        text: "تحقق",
                        color: appcolor,
                        textcolor: Colors.white,
                        onPressed: () {
                          context.read<ResetpasswordCubit>().verifyCode(code);
                        },
                      ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    // ✅ امسحي الـ controllers وابعتي الإيميل تاني
                    for (var c in controllers) {
                      c.clear();
                    }
                    context.read<ResetpasswordCubit>().sendEmail(
                      context.read<ResetpasswordCubit>().savedEmail,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('تم إعادة إرسال الكود')),
                    );
                  },
                  child: const Text(
                    "لم يصلك الرمز ؟ اعد الارسال",
                    style: TextStyle(color: Color(0xFFFF8A3D), fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
