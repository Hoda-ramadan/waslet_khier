import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:waslet_khier/const.dart';
import 'package:waslet_khier/core/Api/api_service.dart';

import 'package:waslet_khier/core/class/assets.dart';
import 'package:waslet_khier/featureAuth/auth/data/cubit/loginCubit.dart';
import 'package:waslet_khier/featureAuth/auth/data/cubit/states.dart';
import 'package:waslet_khier/featureAuth/auth/data/login_response_repo.dart';

import 'package:waslet_khier/featureAuth/auth/presintation/view_model/widget/check_haveing_acc.dart';
import 'package:waslet_khier/featureAuth/auth/presintation/view_model/widget/custombuttom.dart';
import 'package:waslet_khier/featureAuth/auth/presintation/view_model/widget/rememberme.dart';

import 'package:waslet_khier/featureAuth/auth/presintation/view_model/custom_textfild.dart';

class LoginviewBody extends StatelessWidget {
  const LoginviewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginCubit(LoginRepo(ApiService(Dio()))),
      child: const _LoginviewBodyContent(),
    );
  }
}

class _LoginviewBodyContent extends StatefulWidget {
  const _LoginviewBodyContent();

  @override
  State<_LoginviewBodyContent> createState() => _LoginviewBodyContentState();
}

class _LoginviewBodyContentState extends State<_LoginviewBodyContent> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          // TODO: navigate to home screen
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('تم تسجيل الدخول بنجاح'),
              backgroundColor: Colors.green,
            ),
          );
        } else if (state is LoginFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      child: SingleChildScrollView(
        child: Center(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  Image.asset(
                    'assets/images/Group 80.png',
                    width: 151,
                    height: 151,
                  ),
                  const SizedBox(height: 30),

                  // Email field
                  CustomTextField(
                    controller: emailController,
                    labelText: 'البريد الالكتروني',
                    hintTtxt: '',
                    prefxIcon: FontAwesomeIcons.envelope,
                    isSuffixIcon: false,
                    validator: (v) => v == null || v.isEmpty
                        ? 'أدخل البريد الإلكتروني'
                        : null,
                  ),
                  const SizedBox(height: 10),

                  // Password field
                  CustomTextField(
                    controller: passwordController,
                    labelText: 'كلمة المرور',
                    hintTtxt: '',
                    prefxIcon: Icons.lock_outline,
                    isSuffixIcon: true,
                    validator: (v) =>
                        v == null || v.isEmpty ? 'أدخل كلمة المرور' : null,
                  ),
                  const SizedBox(height: 10),

                  const RememberMe(),
                  const SizedBox(height: 30),

                  // Login button
                  BlocBuilder<LoginCubit, LoginState>(
                    builder: (context, state) {
                      if (state is LoginLoading) {
                        return const CircularProgressIndicator();
                      }
                      return Custombuttom(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            context.read<LoginCubit>().login(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                            );
                          }
                        },
                        text: "تسجيل الدخول",
                        color: appcolor,
                        textcolor: Colors.white,
                      );
                    },
                  ),
                  const SizedBox(height: 24),

                  checkhavingAcc(
                    text1: ' ليس لديك حساب ؟ ',
                    text2: 'تسجيل حساب',
                    textcolor1: Colors.black,
                    textcolor2: Colors.deepOrange,
                    path: '/createacc',
                  ),
                  const SizedBox(height: 60),

                  Custombuttom(
                    onPressed: () {},
                    text: "الدخول كزائر",
                    color: Colors.white,
                    textcolor: appcolor,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
